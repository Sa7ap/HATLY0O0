import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/update_order_status_usecase.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/submit_order_evaluation_usecase.dart';
import '../../domain/usecases/get_order_history_usecase.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/send_chat_message_usecase.dart';
import '../../domain/usecases/get_saved_addresses_usecase.dart';
import '../../domain/usecases/save_new_address_usecase.dart';
import '../../domain/usecases/update_customer_profile_usecase.dart';
import '../../domain/usecases/process_order_payment_usecase.dart';
import '../../domain/usecases/get_payment_receipt_usecase.dart';
import 'customer_order_event.dart';
import 'customer_order_state.dart';

class CustomerOrderBloc extends Bloc<CustomerOrderEvent, CustomerOrderState> {
  final CreateOrderUseCase createOrderUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;
  final SubmitOrderEvaluationUseCase submitOrderEvaluationUseCase;
  final GetOrderHistoryUseCase getOrderHistoryUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SendChatMessageUseCase sendChatMessageUseCase;
  final GetSavedAddressesUseCase getSavedAddressesUseCase;
  final SaveNewAddressUseCase saveNewAddressUseCase;
  final UpdateCustomerProfileUseCase updateCustomerProfileUseCase;
  final ProcessOrderPaymentUseCase processOrderPaymentUseCase;
  final GetPaymentReceiptUseCase getPaymentReceiptUseCase;
  final SharedPreferences sharedPreferences;

  CustomerOrderBloc({
    required this.createOrderUseCase,
    required this.updateOrderStatusUseCase,
    required this.getNotificationsUseCase,
    required this.submitOrderEvaluationUseCase,
    required this.getOrderHistoryUseCase,
    required this.getChatMessagesUseCase,
    required this.sendChatMessageUseCase,
    required this.getSavedAddressesUseCase,
    required this.saveNewAddressUseCase,
    required this.updateCustomerProfileUseCase,
    required this.processOrderPaymentUseCase,
    required this.getPaymentReceiptUseCase,
    required this.sharedPreferences,
  }) : super(CustomerOrderInitialState()) {
    on<CreateOrderRequestedEvent>((event, emit) async {
      emit(CustomerOrderLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(CreateOrderSuccessState());
    });

    on<UpdateOrderStatusRequestedEvent>((event, emit) async {
      emit(CustomerOrderLoadingState());
      final result = await updateOrderStatusUseCase.call(
        orderId: event.orderId,
        newStatus: event.newStatus,
      );
      result.fold(
        (failure) =>
            emit(CustomerOrderFailureState(errorMessage: failure.message)),
        (_) => emit(
          UpdateOrderStatusSuccessState(
            orderId: event.orderId,
            newStatus: event.newStatus,
          ),
        ),
      );
    });

    // --- Updated Event Handler: Mutates Local Balances Upon Successful Payment ---
    on<ProcessOrderPaymentEvent>((event, emit) async {
      emit(CustomerOrderLoadingState());

      final result = await processOrderPaymentUseCase.call(
        payment: event.payment,
      );

      await result.fold(
        (failure) async =>
            emit(CustomerOrderFailureState(errorMessage: failure.message)),
        (_) async {
          // Live calculation: Deducting the total amount from customer wallet
          double currentCustomerBalance =
              sharedPreferences.getDouble('customer_wallet_balance') ?? 450.0;
          double updatedCustomerBalance =
              currentCustomerBalance - event.payment.amountPaid;
          await sharedPreferences.setDouble(
            'customer_wallet_balance',
            updatedCustomerBalance,
          );

          // Live calculation: Depositing the delivery fee share into driver wallet
          double currentDriverBalance =
              sharedPreferences.getDouble('driver_wallet_balance') ?? 450.0;
          double updatedDriverBalance =
              currentDriverBalance + event.payment.deliveryFee;
          await sharedPreferences.setDouble(
            'driver_wallet_balance',
            updatedDriverBalance,
          );

          emit(ProcessOrderPaymentSuccessState());
        },
      );
    });

    on<GetPaymentReceiptDetailEvent>((event, emit) async {
      emit(CustomerOrderLoadingState());
      final result = await getPaymentReceiptUseCase.call(
        orderId: event.orderId,
      );
      result.fold(
        (failure) =>
            emit(CustomerOrderFailureState(errorMessage: failure.message)),
        (receipt) =>
            emit(GetPaymentReceiptDetailSuccessState(receipt: receipt)),
      );
    });

    on<UpdateCartItemQuantityEvent>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 100));
      emit(CartItemQuantityUpdatedState(updatedQuantity: event.newQuantity));
    });

    on<MerchantUpdateKitchenStatusEvent>((event, emit) async {
      emit(CustomerOrderLoadingState());
      await Future.delayed(const Duration(milliseconds: 400));
      emit(
        MerchantKitchenStatusUpdatedState(
          orderId: event.orderId,
          kitchenStatus: event.kitchenStatus,
        ),
      );
    });

    on<UpdateAppSettingsEvent>((event, emit) async {
      emit(CustomerOrderLoadingState());
      await sharedPreferences.setBool(
        AppConstants.keyDarkMode,
        event.settings.isDarkMode,
      );
      await sharedPreferences.setString(
        AppConstants.keyLanguage,
        event.settings.selectedLanguage,
      );
      await sharedPreferences.setBool(
        AppConstants.keyNotifications,
        event.settings.isNotificationsOn,
      );
      emit(AppSettingsUpdatedState(settings: event.settings));
    });
  }
}

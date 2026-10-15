import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hatlyai/features/customer/customer_orders/presentation/bloc/customer_order_bloc.dart';
import 'package:hatlyai/features/customer/customer_orders/presentation/bloc/customer_order_event.dart';
import 'package:hatlyai/features/customer/customer_orders/presentation/bloc/customer_order_state.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/create_order_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/update_order_status_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_notifications_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/submit_order_evaluation_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_order_history_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_chat_messages_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/send_chat_message_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_saved_addresses_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/save_new_address_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/update_customer_profile_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/process_order_payment_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_payment_receipt_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/entities/payment_entity.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/entities/cart_item_entity.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/entities/notification_entity.dart'; // استدعاء كيان الإشعارات
import 'package:hatlyai/features/customer/customer_orders/domain/entities/past_order_entity.dart'; // استدعاء كيان الطلبات السابقة
import 'package:hatlyai/features/customer/customer_orders/domain/entities/message_entity.dart'; // استدعاء كيان الرسائل
import 'package:hatlyai/features/customer/customer_orders/domain/entities/address_entity.dart'; // استدعاء كيان العناوين
import 'package:hatlyai/features/customer/customer_orders/domain/repositories/order_repository.dart';
import 'package:hatlyai/core/errors/failures.dart';

// هندسة كلاس محاكاة جلب الإيصال المالي النقي والمطابق أصيلاً للغة دارت لعام 2026
class FakeGetPaymentReceiptUseCase implements GetPaymentReceiptUseCase {
  @override
  late OrderRepository repository;

  @override
  Future<Either<Failure, PaymentEntity>> call({required String orderId}) async {
    return right(
      PaymentEntity(
        transactionId: 'TXN_2026_HATLY',
        orderId: orderId,
        paymentMethod: 'WALLET',
        amountPaid: 135.0,
        paymentStatus: 'SUCCESS',
        merchantShare: 95.0,
        deliveryFee: 30.0,
        platformFee: 10.0,
      ),
    );
  }
}

class FakeProcessOrderPaymentUseCase implements ProcessOrderPaymentUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, void>> call({required PaymentEntity payment}) async =>
      const Right(null);
}

class FakeSharedPreferences implements SharedPreferences {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class FakeCreateOrderUseCase implements CreateOrderUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, void>> call(dynamic order) async => const Right(null);
}

class FakeUpdateOrderStatusUseCase implements UpdateOrderStatusUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, void>> call({
    required String orderId,
    required String newStatus,
  }) async => const Right(null);
}

class FakeGetNotificationsUseCase implements GetNotificationsUseCase {
  @override
  late OrderRepository repository;
  @override
  // تصحيح: مطابقة توقيع الدالة وإرجاع قائمة من نوع الكيان الحقيقي المعتمد بمشروعك
  Future<Either<Failure, List<NotificationEntity>>> call() async =>
      const Right([]);
}

class FakeSubmitOrderEvaluationUseCase implements SubmitOrderEvaluationUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, void>> call(dynamic evaluation) async =>
      const Right(null);
}

class FakeGetOrderHistoryUseCase implements GetOrderHistoryUseCase {
  @override
  late OrderRepository repository;
  @override
  // تصحيح: مطابقة توقيع الدالة وإرجاع قائمة من نوع الكيان الحقيقي المعتمد بمشروعك
  Future<Either<Failure, List<PastOrderEntity>>> call() async =>
      const Right([]);
}

class FakeGetChatMessagesUseCase implements GetChatMessagesUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, List<MessageEntity>>> call(String orderId) async =>
      const Right([]);
}

class FakeSendChatMessageUseCase implements SendChatMessageUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, void>> call(
    String orderId,
    MessageEntity message,
  ) async => const Right(null);
}

class FakeGetSavedAddressesUseCase implements GetSavedAddressesUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, List<AddressEntity>>> call() async => const Right([]);
}

class FakeSaveNewAddressUseCase implements SaveNewAddressUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, void>> call(AddressEntity address) async =>
      const Right(null);
}

class FakeUpdateCustomerProfileUseCase implements UpdateCustomerProfileUseCase {
  @override
  late OrderRepository repository;
  @override
  Future<Either<Failure, void>> call({
    required String name,
    required String phone,
  }) async => const Right(null);
}

void main() {
  late CustomerOrderBloc bloc;
  late FakeProcessOrderPaymentUseCase fakeProcessOrderPaymentUseCase;
  late FakeGetPaymentReceiptUseCase fakeGetPaymentReceiptUseCase;
  late FakeSharedPreferences fakeSharedPreferences;

  setUp(() {
    fakeProcessOrderPaymentUseCase = FakeProcessOrderPaymentUseCase();
    fakeGetPaymentReceiptUseCase = FakeGetPaymentReceiptUseCase();
    fakeSharedPreferences = FakeSharedPreferences();

    bloc = CustomerOrderBloc(
      createOrderUseCase: FakeCreateOrderUseCase(),
      updateOrderStatusUseCase: FakeUpdateOrderStatusUseCase(),
      getNotificationsUseCase: FakeGetNotificationsUseCase(),
      submitOrderEvaluationUseCase: FakeSubmitOrderEvaluationUseCase(),
      getOrderHistoryUseCase: FakeGetOrderHistoryUseCase(),
      getChatMessagesUseCase: FakeGetChatMessagesUseCase(),
      sendChatMessageUseCase: FakeSendChatMessageUseCase(),
      getSavedAddressesUseCase: FakeGetSavedAddressesUseCase(),
      saveNewAddressUseCase: FakeSaveNewAddressUseCase(),
      updateCustomerProfileUseCase:
          FakeUpdateCustomerProfileUseCase(), // مستدعى ومطابق بالنواة
      processOrderPaymentUseCase: fakeProcessOrderPaymentUseCase,
      getPaymentReceiptUseCase: fakeGetPaymentReceiptUseCase,
      sharedPreferences: fakeSharedPreferences,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test(
    'الحالة الابتدائية للـ Bloc يجب أن تكون من نوع CustomerOrderInitialState',
    () {
      expect(bloc.state, isA<CustomerOrderInitialState>());
    },
  );

  blocTest<CustomerOrderBloc, CustomerOrderState>(
    'يجب أن يطلق [CartItemQuantityUpdatedState] عند نجاح تحديث كمية المنتج بالسلة',
    build: () => bloc,
    act: (bloc) => bloc.add(
      UpdateCartItemQuantityEvent(
        cartItem: const CartItemEntity(
          id: 'item_1',
          name: 'وجبة سوبر كومبو',
          price: 135.0,
          quantity: 1,
        ),
        newQuantity: 3,
      ),
    ),
    expect: () => [
      isA<CartItemQuantityUpdatedState>().having(
        (state) => state.updatedQuantity,
        'الكمية المحدثة',
        3,
      ),
    ],
  );

  blocTest<CustomerOrderBloc, CustomerOrderState>(
    'يجب أن يطلق [CustomerOrderLoadingState] ثم [GetPaymentReceiptDetailSuccessState] عند طلب تفاصيل الإيصال المالي المفكك بنجاح',
    build: () => bloc,
    act: (bloc) =>
        bloc.add(const GetPaymentReceiptDetailEvent(orderId: '2026')),
    expect: () => [
      CustomerOrderLoadingState(),
      isA<GetPaymentReceiptDetailSuccessState>().having(
        (state) => state.receipt.merchantShare,
        'صافي أرباح المتجر الموثقة',
        95.0,
      ),
    ],
  );
}

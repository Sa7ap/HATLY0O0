import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hatlyai/core/network/dio_client.dart';
import 'package:hatlyai/core/database/app_preferences.dart';

import 'package:hatlyai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hatlyai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hatlyai/features/auth/domain/repositories/auth_repository.dart';
import 'package:hatlyai/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/send_driver_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/verify_driver_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/send_merchant_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/verify_merchant_otp_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/add_product_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/get_driver_wallet_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/get_merchant_stats_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/get_driver_shifts_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/get_merchant_orders_usecase.dart';
import 'package:hatlyai/features/auth/domain/usecases/update_merchant_order_status_usecase.dart';

import 'package:hatlyai/features/customer/customer_orders/data/datasources/order_remote_data_source.dart';
import 'package:hatlyai/features/customer/customer_orders/data/repositories/order_repository_impl.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/repositories/order_repository.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/create_order_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/update_order_status_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/submit_order_evaluation_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_order_history_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_notifications_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_chat_messages_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/send_chat_message_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_saved_addresses_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/save_new_address_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/update_customer_profile_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/process_order_payment_usecase.dart';
import 'package:hatlyai/features/customer/customer_orders/domain/usecases/get_payment_receipt_usecase.dart';
// استيرادات ميزة المحفظة الإلكترونية للعميل
import 'package:hatlyai/features/customer/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:hatlyai/features/customer/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:hatlyai/features/customer/wallet/domain/repositories/wallet_repository.dart';
import 'package:hatlyai/features/customer/wallet/domain/usecases/get_wallet_balance_usecase.dart';
import 'package:hatlyai/features/customer/wallet/domain/usecases/update_wallet_balance_usecase.dart';
import 'package:hatlyai/features/customer/wallet/domain/usecases/get_wallet_transactions_usecase.dart';

// استيرادات Blocs إدارة الحالة المستقرة بمشروعك
import 'package:hatlyai/features/auth/presentation/customer/bloc/auth_bloc.dart';
import 'package:hatlyai/features/auth/presentation/driver/bloc/driver_auth_bloc.dart';
import 'package:hatlyai/features/auth/presentation/merchant/bloc/merchant_auth_bloc.dart';
import 'package:hatlyai/features/auth/presentation/merchant/product_bloc/merchant_product_bloc.dart';
import 'package:hatlyai/features/customer/customer_orders/presentation/bloc/customer_order_bloc.dart';
import 'package:hatlyai/features/auth/presentation/driver/wallet_bloc/driver_wallet_bloc.dart';
import 'package:hatlyai/features/customer/wallet/presentation/bloc/wallet_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<AppPreferences>(
    () => AppPreferences(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl<DioClient>()),
  );
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(sl<DioClient>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      appPreferences: sl<AppPreferences>(),
    ),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: sl<OrderRemoteDataSource>()),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(remoteDataSource: sl<WalletRemoteDataSource>()),
  );

  sl.registerLazySingleton<SendOtpUseCase>(
    () => SendOtpUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SendDriverOtpUseCase>(
    () => SendDriverOtpUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyDriverOtpUseCase>(
    () => VerifyDriverOtpUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SendMerchantOtpUseCase>(
    () => SendMerchantOtpUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyMerchantOtpUseCase>(
    () => VerifyMerchantOtpUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<CreateOrderUseCase>(
    () => CreateOrderUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<UpdateOrderStatusUseCase>(
    () => UpdateOrderStatusUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<GetWalletBalanceUseCase>(
    () => GetWalletBalanceUseCase(repository: sl<WalletRepository>()),
  );
  sl.registerLazySingleton<UpdateWalletBalanceUseCase>(
    () => UpdateWalletBalanceUseCase(repository: sl<WalletRepository>()),
  );
  sl.registerLazySingleton<GetWalletTransactionsUseCase>(
    () => GetWalletTransactionsUseCase(repository: sl<WalletRepository>()),
  );
  sl.registerLazySingleton<GetDriverWalletUseCase>(
    () => GetDriverWalletUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetMerchantStatsUseCase>(
    () => GetMerchantStatsUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetDriverShiftsUseCase>(
    () => GetDriverShiftsUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetMerchantOrdersUseCase>(
    () => GetMerchantOrdersUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<UpdateMerchantOrderStatusUseCase>(
    () => UpdateMerchantOrderStatusUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<SubmitOrderEvaluationUseCase>(
    () => SubmitOrderEvaluationUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<GetOrderHistoryUseCase>(
    () => GetOrderHistoryUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<GetChatMessagesUseCase>(
    () => GetChatMessagesUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<SendChatMessageUseCase>(
    () => SendChatMessageUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<GetSavedAddressesUseCase>(
    () => GetSavedAddressesUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<SaveNewAddressUseCase>(
    () => SaveNewAddressUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<UpdateCustomerProfileUseCase>(
    () => UpdateCustomerProfileUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<ProcessOrderPaymentUseCase>(
    () => ProcessOrderPaymentUseCase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<GetPaymentReceiptUseCase>(
    () => GetPaymentReceiptUseCase(repository: sl<OrderRepository>()),
  );

  // حقن وتمرير كائن التخزين القياسي لـ SharedPreferences داخل الـ AuthBloc لعام 2026
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      sendOtpUseCase: sl<SendOtpUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUseCase>(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  sl.registerFactory<DriverAuthBloc>(
    () => DriverAuthBloc(
      sendDriverOtpUseCase: sl<SendDriverOtpUseCase>(),
      verifyDriverOtpUseCase: sl<VerifyDriverOtpUseCase>(),
    ),
  );
  sl.registerFactory<MerchantAuthBloc>(
    () => MerchantAuthBloc(
      sendMerchantOtpUseCase: sl<SendMerchantOtpUseCase>(),
      verifyMerchantOtpUseCase: sl<VerifyMerchantOtpUseCase>(),
    ),
  );
  sl.registerFactory<MerchantProductBloc>(
    () => MerchantProductBloc(
      addProductUseCase: sl<AddProductUseCase>(),
      getMerchantStatsUseCase: sl<GetMerchantStatsUseCase>(),
      getMerchantOrdersUseCase: sl<GetMerchantOrdersUseCase>(),
      updateMerchantOrderStatusUseCase: sl<UpdateMerchantOrderStatusUseCase>(),
    ),
  );

  // حقن وتمرير كائن التخزين القياسي لـ SharedPreferences داخل الـ CustomerOrderBloc المحدث
  sl.registerFactory<CustomerOrderBloc>(
    () => CustomerOrderBloc(
      createOrderUseCase: sl<CreateOrderUseCase>(),
      updateOrderStatusUseCase: sl<UpdateOrderStatusUseCase>(),
      getNotificationsUseCase: sl<GetNotificationsUseCase>(),
      submitOrderEvaluationUseCase: sl<SubmitOrderEvaluationUseCase>(),
      getOrderHistoryUseCase: sl<GetOrderHistoryUseCase>(),
      getChatMessagesUseCase: sl<GetChatMessagesUseCase>(),
      sendChatMessageUseCase: sl<SendChatMessageUseCase>(),
      getSavedAddressesUseCase: sl<GetSavedAddressesUseCase>(),
      saveNewAddressUseCase: sl<SaveNewAddressUseCase>(),
      updateCustomerProfileUseCase: sl<UpdateCustomerProfileUseCase>(),
      processOrderPaymentUseCase: sl<ProcessOrderPaymentUseCase>(),
      getPaymentReceiptUseCase: sl<GetPaymentReceiptUseCase>(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  // ... (Previous lazy singletons and usecase registrations remain fully consistent)

  // Passing sharedPreferences dependency into DriverWalletBloc initialization factory
  sl.registerFactory<DriverWalletBloc>(
    () => DriverWalletBloc(
      getDriverWalletUseCase: sl<GetDriverWalletUseCase>(),
      getDriverShiftsUseCase: sl<GetDriverShiftsUseCase>(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  sl.registerFactory<WalletBloc>(
    () => WalletBloc(
      getWalletBalanceUseCase: sl<GetWalletBalanceUseCase>(),
      updateWalletBalanceUseCase: sl<UpdateWalletBalanceUseCase>(),
      getWalletTransactionsUseCase: sl<GetWalletTransactionsUseCase>(),
    ),
  );
}

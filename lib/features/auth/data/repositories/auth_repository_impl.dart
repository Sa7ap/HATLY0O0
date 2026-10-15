import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hatlyai/core/database/app_preferences.dart';
import 'package:hatlyai/core/errors/failures.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/models/user_model.dart';
import '../../data/models/driver_wallet_model.dart';
import '../../data/models/merchant_stats_model.dart';
import '../../data/models/driver_shift_model.dart';
import '../../data/models/merchant_order_model.dart'; // استدعاء موديل طلبات التاجر الجديد
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/driver_wallet_entity.dart';
import '../../domain/entities/merchant_stats_entity.dart';
import '../../domain/entities/driver_shift_entity.dart';
import '../../domain/entities/merchant_order_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.appPreferences,
  });

  @override
  Future<Either<Failure, void>> sendOtp(String phone) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp(
    String phone,
    String code,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final mockUser = UserModel(id: 'c1', phoneNumber: phone, token: 't1');
      return Right(mockUser);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendDriverOtp(String phone) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyDriverOtp(
    String phone,
    String code,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final mockDriver = UserModel(id: 'd1', phoneNumber: phone, token: 't2');
      return Right(mockDriver);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMerchantOtp(String phone) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyMerchantOtp(
    String phone,
    String code,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final mockMerchant = UserModel(id: 'm1', phoneNumber: phone, token: 't3');
      return Right(mockMerchant);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct({
    required String name,
    required double price,
    required String description,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('تمت محاكاة إضافة المنتج بنجاح: $name بسعر $price ج.م');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DriverWalletEntity>> getDriverWallet() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final mockDriverWallet = DriverWalletModel(
        totalEarnings: 450.0,
        availableBalance: 180.0,
        completedOrders: 12,
      );
      debugPrint('تم جلب محفظة المندوب التراكمية بنجاح.');
      return Right(mockDriverWallet);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MerchantStatsEntity>> getMerchantStats() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final mockMerchantStats = MerchantStatsModel(
        totalSales: 1420.0,
        successfulOrders: 24,
        activeProducts: 8,
      );
      debugPrint(
        'تم جلب إحصائيات التاجر: مبيعات ${mockMerchantStats.totalSales} ج.م',
      );
      return Right(mockMerchantStats);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DriverShiftEntity>>> getDriverShifts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final List<DriverShiftModel> mockShifts = [
        const DriverShiftModel(
          id: 'sh_01',
          orderSummary: 'توصيل طلب حر (وجبة سوبر كومبو) 🍔',
          deliveryEarnings: 35.0,
          distance: '4.2 كم',
          date: '2026-10-10 16:15',
        ),
        const DriverShiftModel(
          id: 'sh_02',
          orderSummary: 'توصيل طلب شراء من الصيدلية 💊',
          deliveryEarnings: 52.0,
          distance: '7.8 كم',
          date: '2026-10-10 18:45',
        ),
      ];
      return Right(mockShifts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- الدالتان الجديدتان المضافتان: تنفيذ محاكاة جلب وتحديث طلبات التاجر بنجاح ---
  @override
  Future<Either<Failure, List<MerchantOrderEntity>>> getMerchantOrders() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // إنشاء طلبين تفاعليين حركيين يعكسان فواتير العميل الممررة من السلة
      final List<MerchantOrderModel> mockOrders = [
        const MerchantOrderModel(
          id: 'ord_201',
          itemsSummary: 'وجبة سوبر كومبو حار 🍔🔥 (عدد: 2)، ساندوتش تشيز برجر 🧀 (عدد: 1)',
          itemsPrice: 365.0,
          customerPhone: '01009652051',
          status: 'pending', // قيد الانتظار الأول
        ),
        const MerchantOrderModel(
          id: 'ord_202',
          itemsSummary: 'علبة لبن طبيعي ١ لتر 🥛 (عدد: 3)',
          itemsPrice: 114.0,
          customerPhone: '01224567890',
          status: 'preparing', // قيد التجهيز داخل المطبخ
        ),
      ];

      debugPrint('تم جلب قائمة طلبات التاجر المتاحة بنجاح.');
      return Right(mockOrders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateMerchantOrderStatus({
    required String orderId,
    required String newStatus,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint('تم تحديث حالة الطلب ($orderId) بنجاح إلى: $newStatus');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

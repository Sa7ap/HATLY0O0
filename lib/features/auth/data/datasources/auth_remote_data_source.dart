import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class AuthRemoteDataSource {
  // دالات العميل
  Future<void> sendOtp(String phoneNumber);
  Future<Response> verifyOtp(String phoneNumber, String otp);

  // دالات Mندوب
  Future<void> sendDriverOtp(String phoneNumber);
  Future<Response> verifyDriverOtp(String phoneNumber, String otp);

  // دالات التاجر
  Future<void> sendMerchantOtp(String phoneNumber);
  Future<Response> verifyMerchantOtp(String phoneNumber, String otp);

  // الدالة الجديدة المضافة: لإرسال بيانات المنتج للسيرفر
  Future<void> addProduct({
    required String name,
    required double price,
    required String description,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  // --- 1. تنفيذ دالات العميل ---
  @override
  Future<void> sendOtp(String phoneNumber) async {
    await _dioClient.post(
      ApiEndpoints.sendOtp,
      data: {'phone_number': phoneNumber},
    );
  }

  @override
  Future<Response> verifyOtp(String phoneNumber, String otp) async {
    return await _dioClient.post(
      ApiEndpoints.verifyOtp,
      data: {'phone_number': phoneNumber, 'otp': otp},
    );
  }

  // --- 2. تنفيذ دالات المندوب ---
  @override
  Future<void> sendDriverOtp(String phoneNumber) async {
    await _dioClient.post(
      ApiEndpoints.sendOtp,
      data: {'phone_number': phoneNumber, 'role': 'driver'},
    );
  }

  @override
  Future<Response> verifyDriverOtp(String phoneNumber, String otp) async {
    return await _dioClient.post(
      ApiEndpoints.verifyOtp,
      data: {'phone_number': phoneNumber, 'otp': otp, 'role': 'driver'},
    );
  }

  // --- 3. تنفيذ دالات التاجر ---
  @override
  Future<void> sendMerchantOtp(String phoneNumber) async {
    await _dioClient.post(
      ApiEndpoints.sendOtp,
      data: {'phone_number': phoneNumber, 'role': 'merchant'},
    );
  }

  @override
  Future<Response> verifyMerchantOtp(String phoneNumber, String otp) async {
    return await _dioClient.post(
      ApiEndpoints.verifyOtp,
      data: {'phone_number': phoneNumber, 'otp': otp, 'role': 'merchant'},
    );
  }

  // --- 4. تنفيذ دالة إضافة المنتج الجديدة ---
  @override
  Future<void> addProduct({
    required String name,
    required double price,
    required String description,
  }) async {
    await _dioClient.post(
      '/merchant/products', // رابط السيرفر المؤقت لإضافة المنتجات
      data: {'name': name, 'price': price, 'description': description},
    );
  }
}

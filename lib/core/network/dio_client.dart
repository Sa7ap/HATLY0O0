import 'package:dio/dio.dart';

import 'api_endpoints.dart';
import '../errors/failures.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 30), // وقت انتظار الاتصال
          receiveTimeout: const Duration(
            seconds: 30,
          ), // وقت انتظار استقبال البيانات
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    // إضافة الـ Interceptors لإدارة التوكن وتسجيل العمليات (Logging)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // هنا يمكنك جلب التوكن المحفوظ (مثلاً من SharedPreferences) وإضافته لكل طلب تلقائياً
          // String? token = ...;
          // if (token != null) options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException e, handler) => handler.next(e),
      ),
    );
  }

  // دالة مخصصة لإرسال طلبات الـ GET مع معالجة دقيقة للأخطاء
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // دالة مخصصة لإرسال طلبات الـ POST (مثل إرسال رقم الهاتف ورمز الـ OTP)
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // دالة داخلية لتحويل أخطاء مكتبة Dio إلى الـ Failures التي أنشأناها في البداية
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure('تعذر الاتصال بالشبكة');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['message'] ?? "حدث خطأ ما في السيرفر";
        return ServerFailure("خطأ $statusCode: $message");
      default:
        return const ServerFailure("حدث خطأ غير متوقع، يرجى المحاولة لاحقاً");
    }
  }
}

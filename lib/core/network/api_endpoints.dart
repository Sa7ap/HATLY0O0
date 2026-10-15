class ApiEndpoints {
  // الرابط الأساسي للسيرفر (قم بتغييره لاحقاً برابط السيرفر الخاص بك)
  static const String baseUrl = "https://yourdeliveryapp.com";

  // --- روابط المصادقة (Auth Endpoints) ---
  // تسجيل الدخول أو إرسال رمز التحقق عبر رقم الهاتف
  static const String sendOtp = "auth/send-otp";
  // التحقق من الرمز المدخل لإتمام الدخول
  static const String verifyOtp = "auth/verify-otp";

  // --- روابط العميل (Customer Endpoints) ---
  static const String customerProfile = "customer/profile";
  static const String categories = "customer/categories";
  static const String activeOrders = "customer/orders/active";
  static const String pastOrders = "customer/orders/past";

  // --- روابط المندوب (Driver Endpoints) ---
  static const String driverProfile = "driver/profile";
  static const String availableOrders = "driver/orders/available";

  // --- روابط التاجر (Merchant Endpoints) ---
  static const String merchantProfile = "merchant/profile";
  static const String merchantProducts = "merchant/products";
}

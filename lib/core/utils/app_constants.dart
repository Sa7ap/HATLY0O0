class AppConstants {
  // مفاتيح المحاكاة المالية المستقرة لمشروعك هاتلي
  static const double maxWalletBalance = 450.0;
  static const double merchantEarningsTarget = 1420.0;
  static const String driverShiftZoneCoverage = '30 كم';

  // --- مفاتيح التخزين الدائم الموحدة لـ SharedPreferences منعا للأخطاء الإملائية ---
  static const String keyDarkMode = 'is_dark_mode';
  static const String keyLanguage = 'selected_language';
  static const String keyNotifications = 'is_notifications_on';
  static const String keyBiometric = 'is_biometric_enabled';
  static const String keyTwoFactor = 'is_2fa_enabled';
  static const String keyUserLoggedIn =
      'is_user_logged_in'; // مفتاح العبور التلقائي للرئيسية
}

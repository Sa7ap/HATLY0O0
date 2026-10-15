import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  // مفاتيح التخزين الثابتة منعا للأخطاء الإملائية
  static const String _keyUserToken = "USER_TOKEN";
  static const String _keyUserPhone = "USER_PHONE";
  static const String _keyUserRole =
      "USER_ROLE"; // لحفظ نوع الحساب (عميل، مندوب، تاجر)

  // --- 1. دوال حفظ واسترجاع التوكن (Token) ---
  Future<bool> setUserToken(String token) async {
    return await _sharedPreferences.setString(_keyUserToken, token);
  }

  String getUserToken() {
    return _sharedPreferences.getString(_keyUserToken) ?? "";
  }

  // --- 2. دوال حفظ واسترجاع رقم الهاتف ---
  Future<bool> setUserPhone(String phone) async {
    return await _sharedPreferences.setString(_keyUserPhone, phone);
  }

  String getUserPhone() {
    return _sharedPreferences.getString(_keyUserPhone) ?? "";
  }

  // --- 3. دوال حفظ واسترجاع نوع الحساب لفتح الشاشة المناسبة عند بداية التشغيل ---
  Future<bool> setUserRole(String role) async {
    return await _sharedPreferences.setString(_keyUserRole, role);
  }

  String getUserRole() {
    return _sharedPreferences.getString(_keyUserRole) ?? "";
  }

  // --- 4. دالة تسجيل الخروج وتطهير البيانات المخزنة محلياً ---
  Future<bool> logout() async {
    return await _sharedPreferences.clear();
  }

  // فحص ما إذا كان المستخدم مسجلاً دخوله بالفعل أم لا
  bool isUserLoggedIn() {
    return getUserToken().isNotEmpty;
  }
}

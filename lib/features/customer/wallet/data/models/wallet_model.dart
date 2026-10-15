import '../../domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  const WalletModel({required super.balance, required super.currency});

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل التطبيق
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: (json['balance'] as num? ?? 0.0).toDouble(),
      currency: json['currency'] as String? ?? 'ج.م',
    );
  }

  // دالة تحويل كائن المحفظة داخل التطبيق إلى خريطة بيانات (Map JSON) لإرسالها للسيرفر
  Map<String, dynamic> toJson() {
    return {'balance': balance, 'currency': currency};
  }
}

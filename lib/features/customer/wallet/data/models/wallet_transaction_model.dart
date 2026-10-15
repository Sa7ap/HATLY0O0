import '../../domain/entities/wallet_transaction_entity.dart';

class WalletTransactionModel extends WalletTransactionEntity {
  const WalletTransactionModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.date,
    required super.isCredit,
  });

  // دالة تحويل البيانات القادمة من السيرفر (Map JSON) إلى كائن برمجى داخل التطبيق
  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      amount: (json['amount'] as num? ?? 0.0).toDouble(),
      date: json['date'] as String? ?? '',
      isCredit: json['is_credit'] as bool? ?? true,
    );
  }

  // دالة تحويل كائن المعاملة إلى خريطة بيانات (Map JSON) لإرسالها وتحديثها بالسيرفر
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'is_credit': isCredit,
    };
  }
}

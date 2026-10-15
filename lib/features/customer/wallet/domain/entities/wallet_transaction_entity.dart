import 'package:equatable/equatable.dart';

class WalletTransactionEntity extends Equatable {
  final String id; // المعرف الفريد للمعاملة الماليّة
  final String title; // عنوان العملية (مثال: شحن المحفظة، دفع لطلب حر)
  final double amount; // قيمة المبلغ المالي (double لحماية الكسور والقروش)
  final String date; // تاريخ ووقت العملية (مثال: 2026-10-10)
  final bool
  isCredit; // تحديد نوع العملية: true (شحن داخلي (+))، false (خصم مدفوعات (-))

  const WalletTransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isCredit,
  });

  @override
  List<Object?> get props => [id, title, amount, date, isCredit];
}

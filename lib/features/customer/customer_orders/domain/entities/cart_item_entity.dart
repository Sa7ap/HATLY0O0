import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String id; // المعرف الفريد للسلعة داخل السلة
  final String name; // اسم السلعة أو الوجبة المطلوبة
  final double price; // السعر الفردي للسلعة الواحدة
  final int quantity; // الكمية المطلوبة من هذه السلعة

  const CartItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  // دالة ذكية لحساب إجمالي السعر لهذه السلعة بناءً على الكمية
  double get totalPrice => price * quantity;

  // دالة نسخ الكائن لتسهيل تعديل الكميات (زيادة/نقصان) داخل الـ Bloc لاحقاً
  CartItemEntity copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity];
}

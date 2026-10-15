// lib/features/customer/home/presentation/home_price_row.dart
import 'package:flutter/material.dart';

class HomePriceRow extends StatefulWidget {
  final TextEditingController itemPriceController;
  final TextEditingController deliveryPriceController;
  final bool isManualDelivery;

  const HomePriceRow({
    super.key,
    required this.itemPriceController,
    required this.deliveryPriceController,
    required this.isManualDelivery,
  });

  @override
  State<HomePriceRow> createState() => HomePriceRowState();
}

class HomePriceRowState extends State<HomePriceRow> {
  final TextEditingController _totalPriceController = TextEditingController(
    text: "0",
  );

  double _defaultDeliveryFee = 0.0;
  double _maxDeliveryFee = 0.0;
  double _minDeliveryFee = 0.0;

  @override
  void initState() {
    super.initState();
    widget.itemPriceController.addListener(_calculateTotal);
    widget.deliveryPriceController.addListener(_calculateTotal);

    // يفتح صندوق التوصيل فارغاً تماماً في البداية كما طلبت
    widget.deliveryPriceController.text = "";
  }

  @override
  void dispose() {
    widget.itemPriceController.removeListener(_calculateTotal);
    widget.deliveryPriceController.removeListener(_calculateTotal);
    _totalPriceController.dispose();
    super.dispose();
  }

  // احتساب السعر التلقائي بناءً على معادلة الـ 100 متر وتقريبه لأعلى
  void calculateDistanceDeliveryFee() {
    double simulatedDistanceMeters = 1250.0;
    double calculatedFee = 20.0 + (simulatedDistanceMeters / 100.0) * 0.8;

    setState(() {
      _defaultDeliveryFee = calculatedFee
          .ceilToDouble(); // التقريب لأقرب رقم صحيح لأعلى
      _maxDeliveryFee = _defaultDeliveryFee * 1.20; // حد أقصى للزيادة +20%
      _minDeliveryFee = _defaultDeliveryFee * 0.80; // حد أدنى للنقصان -20%

      // تعبئة الحقل أوتوماتيكياً فور الحساب من الخريطة
      widget.deliveryPriceController.text = _defaultDeliveryFee
          .toInt()
          .toString();
    });
  }

  void _calculateTotal() {
    final double itemPrice =
        double.tryParse(widget.itemPriceController.text) ?? 0.0;
    final double deliveryPrice =
        double.tryParse(widget.deliveryPriceController.text) ?? 0.0;
    final double total = itemPrice + deliveryPrice;

    setState(() {
      _totalPriceController.text = total % 1 == 0
          ? total.toInt().toString()
          : total.toStringAsFixed(2);
    });
  }

  void _increaseDeliveryFee() {
    if (widget.deliveryPriceController.text.isEmpty) return;

    double currentFee =
        double.tryParse(widget.deliveryPriceController.text) ??
        _defaultDeliveryFee;

    if (_maxDeliveryFee == 0.0) _updateNegotiationLimits(currentFee);

    if (currentFee + 5.0 <= _maxDeliveryFee) {
      setState(() {
        widget.deliveryPriceController.text = (currentFee + 5.0)
            .toInt()
            .toString();
      });
    } else {
      _showWarning('تم الوصول للحد الأقصى المسموح به للزيادة (20%) ⚠️');
    }
  }

  void _decreaseDeliveryFee() {
    if (widget.deliveryPriceController.text.isEmpty) return;

    double currentFee =
        double.tryParse(widget.deliveryPriceController.text) ??
        _defaultDeliveryFee;

    if (_minDeliveryFee == 0.0) _updateNegotiationLimits(currentFee);

    if (currentFee - 5.0 >= _minDeliveryFee) {
      setState(() {
        widget.deliveryPriceController.text = (currentFee - 5.0)
            .toInt()
            .toString();
      });
    } else {
      _showWarning('تم الوصول للحد الأدنى المسموح به للنقصان (20%) ⚠️');
    }
  }

  void _updateNegotiationLimits(double baseFee) {
    _defaultDeliveryFee = baseFee;
    _maxDeliveryFee = baseFee * 1.20;
    _minDeliveryFee = baseFee * 0.80;
  }

  void _showWarning(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // أ. صندوق سعر الطلبات الصارم
        Expanded(
          child: TextFormField(
            controller: widget.itemPriceController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              labelText: 'سعر الطلبات',
              labelStyle: TextStyle(fontSize: 11),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              suffixText: 'ج',
              suffixStyle: TextStyle(fontSize: 11),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'مطلوب';
              if (double.tryParse(value) == null) return 'أرقام فقط';
              return null;
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
        ),

        // 💡 ب. صندوق سعر التوصيل المطور بفحص الأرقام الصارم والإلزامي
        Expanded(
          child: TextFormField(
            controller: widget.deliveryPriceController,
            readOnly: !widget
                .isManualDelivery, // مقفل بالتتبع التلقائي ومفتوح باليدوي
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: 'التوصيل',
              labelStyle: const TextStyle(fontSize: 11),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 4,
              ),
              border: const OutlineInputBorder(),
              prefixIcon: GestureDetector(
                onTap: _decreaseDeliveryFee,
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 32,
                maxHeight: 32,
              ),
              suffixIcon: GestureDetector(
                onTap: _increaseDeliveryFee,
                child: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 32,
                maxHeight: 32,
              ),
            ),
            // 💡 تحديث شرط الـ validator لضمان قبول الأرقام فقط بشكل قطعي ومنع الحروف
            validator: (value) {
              if (widget.isManualDelivery) {
                if (value == null || value.trim().isEmpty || value == "0") {
                  return 'مطلوب السعر';
                }
                if (double.tryParse(value) == null) {
                  return 'أرقام فقط'; // 💡 يمنع الحروف والرموز تماماً
                }
              }
              return null;
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            '=',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),

        // جـ. صندوق إجمالي التكلفة
        Expanded(
          child: TextFormField(
            controller: _totalPriceController,
            readOnly: true,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              labelText: 'الإجمالي',
              labelStyle: const TextStyle(fontSize: 11),
              isDense: true,
              filled: true,
              fillColor: Colors.green.withValues(alpha: 0.05),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 6,
              ),
              suffixText: 'جنيه',
              suffixStyle: const TextStyle(fontSize: 10),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

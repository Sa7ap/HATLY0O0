import 'package:flutter/material.dart';

class CustomerHomeFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController orderDetailsController;
  final TextEditingController storeNameController;
  final TextEditingController priceController;
  final TextEditingController deliveryFeeController;
  final double? distanceInMeters; // المسافة المستلمة من الـ GPS أو الخريطة

  const CustomerHomeFields({
    super.key,
    required this.formKey,
    required this.orderDetailsController,
    required this.storeNameController,
    required this.priceController,
    required this.deliveryFeeController,
    this.distanceInMeters,
  });

  @override
  State<CustomerHomeFields> createState() => _CustomerHomeFieldsState();
}

class _CustomerHomeFieldsState extends State<CustomerHomeFields> {
  bool _isAnyStore = false;
  double _autoCalculatedFee = 20.0;
  bool _hasCalculatedAutomatically = false;

  @override
  void initState() {
    super.initState();
    _calculateInitialDeliveryFee();
  }

  @override
  void didUpdateWidget(covariant CustomerHomeFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.distanceInMeters != oldWidget.distanceInMeters) {
      _calculateInitialDeliveryFee();
    }
  }

  // 1. دالة الحساب التلقائي مع تقريب الناتج لأعلى رقم صحيح (30.1 تصبح 31)
  void _calculateInitialDeliveryFee() {
    if (widget.distanceInMeters != null && widget.distanceInMeters! > 0) {
      double extraDistanceFee = (widget.distanceInMeters! / 100) * 0.7;
      double total = 20.0 + extraDistanceFee;

      _autoCalculatedFee = total.ceilToDouble(); // التقريب الذكي لأعلى
      widget.deliveryFeeController.text = _autoCalculatedFee.toStringAsFixed(0);
      _hasCalculatedAutomatically = true;
    } else {
      _hasCalculatedAutomatically = false;
      if (widget.deliveryFeeController.text.isEmpty) {
        widget.deliveryFeeController.text = "20";
      }
    }
  }

  // 2. دالة التحكم بالأزرار (+ و -) بقيمة 5 جنيه وشروط النسبة المئوية والحد الأدنى
  void _adjustFee(bool isIncrement) {
    double currentFee =
        double.tryParse(widget.deliveryFeeController.text) ?? 20.0;
    double newFee = isIncrement ? (currentFee + 5) : (currentFee - 5);

    if (newFee < 20.0) return; // شرط الحد الأدنى الصارم

    if (_hasCalculatedAutomatically) {
      double maxAllowed = _autoCalculatedFee * 1.20; // زيادة 20% كحد أقصى
      double minAllowed = _autoCalculatedFee * 0.80; // نقصان 20% كحد أدنى

      if (newFee > maxAllowed || newFee < minAllowed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'التعديل المسموح به هو 20% فقط صعوداً أو هبوطاً من الحسبة التلقائية',
            ),
            duration: Duration(seconds: 1),
          ),
        );
        return;
      }
    }

    setState(() {
      widget.deliveryFeeController.text = newFee.toStringAsFixed(0);
    });
  }

  // يتبع في الجزء الثاني كود دالة الـ build وتصميم الواجهة...
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. حقل تفاصيل الطلب الحر (إجباري)
          const Text(
            'ماذا تريد أن نطلب لك؟',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.orderDetailsController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'اكتب تفاصيل طلبك بدقة (مثال: وجبة عداء معينة، أغراض من السوبرماركت)...',
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء كتابة تفاصيل الطلب أولاً';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // 2. حقل اختيار المتجر المرن (محدد أو مفتوح للمندوب بناءً على نموذج عملك الحر)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'مكان الشراء (المتجر)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _isAnyStore = !_isAnyStore;
                    if (_isAnyStore) {
                      widget.storeNameController.text =
                          "أي متجر متاح (يختاره المندوب)";
                    } else {
                      widget.storeNameController.clear();
                    }
                  });
                },
                icon: Icon(
                  _isAnyStore
                      ? Icons.check_circle
                      : Icons.add_location_alt_outlined,
                  size: 16,
                  color: Colors.deepOrange,
                ),
                label: Text(
                  _isAnyStore ? 'متجر حر' : 'شراء من أي مكان',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.storeNameController,
            enabled: !_isAnyStore,
            decoration: InputDecoration(
              hintText: _isAnyStore
                  ? 'سيقوم المندوب بالشراء من أقرب مكان متاح'
                  : 'اكتب اسم محل أو ماركت معين (اختياري)...',
              filled: true,
              fillColor: _isAnyStore
                  ? Colors.orange.withValues(alpha: 0.05)
                  : Colors.grey.withValues(alpha: 0.05),
              prefixIcon: Icon(
                Icons.storefront_rounded,
                color: _isAnyStore ? Colors.orange : Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: _isAnyStore
                    ? const BorderSide(color: Colors.orange, width: 1)
                    : BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 3. صف حقول الأسعار الذكية والتحكم بـ (+ و -)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // حقل السعر التقديري للأغراض يكتبه العميل بحرية
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'السعر التقديري للطلب',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: widget.priceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '0.00',
                        filled: true,
                        fillColor: Colors.grey.withValues(alpha: 0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // حقل تكلفة التوصيل الذكي المحاط بأزرار التحكم الفورية
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'رسوم التوصيل (ج.م)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // زر النقصان (-) بمقدار 5 جنيه شريطة ألا يقل عن 20 جنيه
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline_rounded,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () => _adjustFee(false),
                          ),

                          // حقل عرض وسعر التوصيل
                          Expanded(
                            child: TextFormField(
                              controller: widget.deliveryFeeController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              enabled: !_hasCalculatedAutomatically, // مغلق للكتابة اليدوية إذا تم الحساب من الخريطة، ويعدل بالأزرار فقط
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'مطلوب';
                                }
                                double? parsed = double.tryParse(value);
                                if (parsed == null) return 'رقم غير صحيح';
                                if (parsed < 20.0) return 'الحد الأدنى 20 ج.م';
                                return null;
                              },
                            ),
                          ),

                          // زر الزيادة (+) بمقدار 5 جنيه شريطة ألا يتجاوز سقف 20%
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.green,
                            ),
                            onPressed: () => _adjustFee(true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

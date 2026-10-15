// lib/customer_home_dialogs.dart
import 'package:flutter/material.dart';

class CustomerHomeDialogs {
  // أ. نافذة خيارات مكان الاستلام
  static void showPickupDialog({
    required BuildContext context,
    required Function(bool anywhere, String text) onSelect,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('خيارات مكان الاستلام 🏪', textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.location_on_outlined, color: Colors.deepOrange),
                title: const Text('موقعي الحالي عبر الـ GPS'),
                onTap: () {
                  onSelect(false, "موقعي الحالي عبر الـ GPS 📍");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.my_location, color: Colors.deepOrange),
                title: const Text('تحديد الموقع من الخريطة'),
                onTap: () {
                  onSelect(false, "الموقع المحدد من الخريطة 🎯");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.storefront, color: Colors.deepOrange),
                title: const Text('من أي مكان (يترك للمندوب)'),
                onTap: () {
                  onSelect(true, "الشراء من أي مكان متاح 🛒");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ب. نافذة خيارات مكان التسليم
  static void showDeliveryDialog({
    required BuildContext context,
    required Function(String text) onSelect,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('خيارات مكان التسليم 📍', textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.location_on_outlined, color: Colors.deepOrange),
                title: const Text('توصيل إلى موقعي الحالي عبر الـ GPS'),
                onTap: () {
                  onSelect("موقعي الحالي عبر الـ GPS 📍");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.my_location, color: Colors.deepOrange),
                title: const Text('تحديد موقع التسليم من الخريطة'),
                onTap: () {
                  onSelect("موقع منزلي من الخريطة 🎯");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class RegisterRolePage extends StatefulWidget {
  const RegisterRolePage({super.key});

  @override
  State<RegisterRolePage> createState() => _RegisterRolePageState();
}

class _RegisterRolePageState extends State<RegisterRolePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedRole = 'customer'; // القيمة الافتراضية للعميل

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'الاسم الكامل'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'رقم الهاتف (مع رمز الدولة)',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text(
              'سجل حسابك كـ:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // خيارات اختيار الدور (Dropdown or Radio buttons)
            DropdownButton<String>(
              value: _selectedRole,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'customer',
                  child: Text('عميل (طلب خدمات)'),
                ),
                DropdownMenuItem(
                  value: 'driver',
                  child: Text('مندوب توصيل (كابتن)'),
                ),
                DropdownMenuItem(
                  value: 'merchant',
                  child: Text('تاجر (صاحب متجر/مطعم)'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                // هنا نقوم باستدعاء الـ Bloc لإرسال الـ OTP
              },
              child: const Text(
                'إرسال رمز التحقق SMS',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

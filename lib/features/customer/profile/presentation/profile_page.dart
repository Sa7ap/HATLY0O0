import 'package:flutter/material.dart';

import '../../customer_orders/presentation/order_history_page.dart';
import '../../customer_orders/presentation/app_settings_page.dart'; // استدعاء شاشة الإعدادات الجديدة هنا
import 'saved_addresses_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'حسابي الشخصي 🧑‍💼',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false, // شاشة رئيسية في الـ BottomNav
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // بطاقة بيانات العميل الافتراضية الأنيقة لعام 2026
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.01),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFFFE0B2),
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.deepOrange,
                      size: 36,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'عمرو عبد الحكيم 👑',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '+20 1000000000',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 1. زر الانتقال لإدارة العناوين الجغرافية
            _buildProfileTileItem(
              context: context,
              icon: Icons.location_on_rounded,
              iconColor: Colors.green,
              title: 'العناوين الجغرافية المسجلة 📍',
              subtitle: 'إدارة عناوين المنزل، العمل، وتحديد موقعك الحركي',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedAddressesPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // 2. زر الانتقال لأرشيف الفواتير وسجل العمليات
            _buildProfileTileItem(
              context: context,
              icon: Icons.receipt_long_rounded,
              iconColor: Colors.blue,
              title: 'أرشيف سجل الطلبات والفواتير 📄',
              subtitle: 'مراجعة كافة الفواتير القديمة وتقييمات الكباتن',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // 3. زر التحكم الجديد المضاف: التوجيه الحركي الفوري لواجهة إعدادات المنصة والثيم
            _buildProfileTileItem(
              context: context,
              icon: Icons.settings_suggest_rounded,
              iconColor: Colors.blueGrey,
              title: 'إعدادات التطبيق والمظهر ⚙️',
              subtitle:
                  'التحكم باللغات، تفعيل الوضع المظلم، ونغمات الإشعارات حياً',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppSettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ودجت بناء وتنسيق أزرار القائمة الرأسية بنقاء بصري تفاعلي ممتاز
  Widget _buildProfileTileItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.06)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontFamily: 'Cairo',
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}

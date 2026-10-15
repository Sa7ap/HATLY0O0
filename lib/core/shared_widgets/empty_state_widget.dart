import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    // تصحيح: استخدام ودجت Padding بشكل خارجي بدلاً من تمريرها بداخل الـ Center
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: Colors.grey.withValues(alpha: 0.4)),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign:
                  TextAlign.center, // تصحيح تمرير المحاذاة النصية بشكل سليم
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign:
                  TextAlign.center, // تصحيح تمرير المحاذاة النصية بشكل سليم
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

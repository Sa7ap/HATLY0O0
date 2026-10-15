import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final bool isDarkMode; // تفعيل الوضع المظلم لحماية العين
  final String selectedLanguage; // اللغة المعتمدة للتطبيق (مثال: 'ar' أو 'en')
  final bool
  isNotificationsOn; // تشغيل أو إيقاف نغمات التنبيهات الفورية الفائقة

  const SettingsEntity({
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.isNotificationsOn,
  });

  @override
  List<Object?> get props => [isDarkMode, selectedLanguage, isNotificationsOn];
}

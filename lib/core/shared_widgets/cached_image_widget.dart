// الجزء 1 من 1: كود ملف lib/core/shared_widgets/cached_image_widget.dart
// تم تصحيح مسار الاستدعاء في السطر 4 ليطابق الهيكل البنيوي الفعلي لمشروعك تماماً

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_theme.dart'; // تم ضبط المسار هندسياً بالخروج خطوة واحدة فقط

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final defaultRadius = borderRadius ?? BorderRadius.circular(12);

    return ClipRRect(
      borderRadius: defaultRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppTheme.lightOrange,
          highlightColor: Colors.white,
          child: Container(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            color: AppTheme.lightOrange,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          color: Colors.grey.shade100,
          child: const Icon(
            Icons.fastfood_rounded,
            color: AppTheme.primaryOrange,
            size: 28,
          ),
        ),
      ),
    );
  }
}

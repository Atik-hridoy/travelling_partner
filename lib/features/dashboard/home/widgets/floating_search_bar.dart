import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class FloatingSearchBar extends StatelessWidget {
  const FloatingSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/search'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: VoyentaColors.primary.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: VoyentaColors.primary, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search anything... flights, hotels, or AI ideas',
                style: VoyentaTypography.bodyMd.copyWith(
                  color: VoyentaColors.onSurfaceVariant.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ),
            Icon(Icons.mic, color: VoyentaColors.onSurfaceVariant.withOpacity(0.6), size: 20),
          ],
        ),
      ),
    );
  }
}

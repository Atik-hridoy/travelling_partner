import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class NotificationsHeader extends StatelessWidget {
  final VoidCallback onClearAll;

  const NotificationsHeader({
    super.key,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: VoyentaColors.surface.withValues(alpha: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: VoyentaColors.onSurface),
                onPressed: () => Get.back(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 14),
              Text(
                'Notifications',
                style: VoyentaTypography.displayLgMobile.copyWith(
                  color: VoyentaColors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: onClearAll,
            child: Text(
              'Clear All',
              style: VoyentaTypography.bodyMd.copyWith(
                color: VoyentaColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

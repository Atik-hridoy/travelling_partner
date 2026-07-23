import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../notifications_controller.dart';

class TripUpdatesSection extends GetView<NotificationsController> {
  const TripUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TRIP UPDATES',
          style: VoyentaTypography.labelCaps.copyWith(
            color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3,
          ),
        ),
        const SizedBox(height: 12),

        // Trip Update 1 (Hotel Check-in)
        Obx(() {
          return _buildSimpleCard(
            icon: Icons.hotel_rounded,
            iconBg: VoyentaColors.secondaryContainer,
            iconColor: VoyentaColors.primary,
            title: 'Hotel Check-in: Aman Kyoto is ready for you.',
            subtitle: 'Tap to see your digital key',
            hasUnreadDot: !controller.isTrip1Read.value,
            onTap: () => controller.markTrip1Read(),
          );
        }),

        const SizedBox(height: 10),

        // Trip Update 2 (Flight Gate)
        _buildSimpleCard(
          icon: Icons.flight_takeoff_rounded,
          iconBg: VoyentaColors.errorContainer,
          iconColor: VoyentaColors.error,
          title: 'Flight LH402: Gate changed to A12.',
          subtitle: 'Boarding in 45 minutes',
        ),
      ],
    );
  }

  Widget _buildSimpleCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool hasUnreadDot = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: VoyentaColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: VoyentaColors.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (hasUnreadDot)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: VoyentaColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

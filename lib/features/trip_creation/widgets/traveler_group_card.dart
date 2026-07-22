import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';

class TravelerGroupCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const TravelerGroupCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Obx(() {
      String selectedTitle = '';
      if (controller.adults.value == 1 && controller.children.value == 0) {
        selectedTitle = 'Solo';
      } else if (controller.adults.value == 2 && controller.children.value == 0) {
        selectedTitle = 'Couple';
      } else if (controller.adults.value >= 2 && controller.children.value > 0) {
        selectedTitle = 'Family';
      } else if (controller.adults.value > 2 && controller.children.value == 0) {
        selectedTitle = 'Friends';
      }

      bool isSelected = selectedTitle == title;

      return GestureDetector(
        onTap: () {
          if (title == 'Solo') {
            controller.adults.value = 1;
            controller.children.value = 0;
          } else if (title == 'Couple') {
            controller.adults.value = 2;
            controller.children.value = 0;
          } else if (title == 'Family') {
            controller.adults.value = 2;
            controller.children.value = 2;
          } else if (title == 'Friends') {
            controller.adults.value = 4;
            controller.children.value = 0;
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? VoyentaColors.primaryContainer.withValues(alpha: 0.2) : VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? VoyentaColors.primary : VoyentaColors.outlineVariant.withValues(alpha: 0.3),
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: VoyentaColors.primary.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected ? VoyentaColors.primaryContainer : VoyentaColors.primaryContainer.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: VoyentaColors.primary),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: VoyentaTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

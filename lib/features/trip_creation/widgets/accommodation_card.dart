import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';

class AccommodationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String imageUrl;

  const AccommodationCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Obx(() {
      final isSelected = controller.accommodation.value == title;
      return GestureDetector(
        onTap: () => controller.accommodation.value = title,
        child: Container(
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(32),
            border: isSelected ? Border.all(color: VoyentaColors.primary, width: 4) : Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Container(
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: isSelected ? Stack(
                  children: [
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text('SELECTED', style: VoyentaTypography.labelCaps.copyWith(color: Colors.white, fontSize: 10)),
                      ),
                    )
                  ],
                ) : null,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: VoyentaColors.primary),
                        const SizedBox(width: 8),
                        Text(title, style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(description, style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

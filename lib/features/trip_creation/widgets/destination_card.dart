import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';

class DestinationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double height;
  final bool isPopular;

  const DestinationCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.height = 200,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Obx(() {
      final isSelected = controller.destination.value == title;
      return GestureDetector(
        onTap: () => controller.destination.value = title,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: isSelected ? Border.all(color: VoyentaColors.primary, width: 4) : null,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.4),
                BlendMode.darken,
              ),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isPopular)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: VoyentaColors.primary.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Popular',
                          style: VoyentaTypography.labelCaps.copyWith(color: Colors.white),
                        ),
                      ),
                    Text(
                      title,
                      style: (isPopular ? VoyentaTypography.displayLgMobile : VoyentaTypography.headlineMd)
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: VoyentaTypography.bodyMd.copyWith(color: Colors.white.withValues(alpha: 0.9)),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected ? VoyentaColors.primary : Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: isSelected ? VoyentaColors.primary : Colors.white.withValues(alpha: 0.5)),
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

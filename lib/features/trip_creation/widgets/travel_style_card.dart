import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';

class TravelStyleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double height;

  const TravelStyleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Obx(() {
      final isSelected = controller.travelStyle.value == title;
      
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            controller.travelStyle.value = '';
          } else {
            controller.travelStyle.value = title;
          }
        },
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: isSelected ? Border.all(color: VoyentaColors.primary, width: 4) : null,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: VoyentaTypography.headlineMd.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: VoyentaTypography.bodyMd.copyWith(color: Colors.white.withValues(alpha: 0.8), fontSize: 13),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: VoyentaColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 20),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

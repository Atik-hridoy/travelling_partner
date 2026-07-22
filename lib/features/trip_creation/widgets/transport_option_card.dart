import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';

class TransportOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDashed;

  const TransportOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Obx(() {
      final isSelected = controller.transportation.contains(title);
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            controller.transportation.remove(title);
          } else {
            controller.transportation.clear();
            controller.transportation.add(title);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? VoyentaColors.primaryContainer.withValues(alpha: 0.1) : VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? VoyentaColors.primary : VoyentaColors.outlineVariant.withValues(alpha: isDashed ? 1 : 0.3),
              width: isSelected ? 2 : 1,
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
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isSelected ? VoyentaColors.primary : (isDashed ? VoyentaColors.surfaceContainer : VoyentaColors.primaryContainer.withValues(alpha: 0.1)),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: isSelected ? VoyentaColors.onPrimary : (isDashed ? VoyentaColors.outline : VoyentaColors.primary)),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (!isDashed) ...[
                          const Icon(Icons.schedule, size: 16, color: VoyentaColors.onSurfaceVariant),
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(subtitle, style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant, fontSize: 14)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? VoyentaColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? VoyentaColors.primary : VoyentaColors.outlineVariant),
                ),
                child: isSelected ? const Icon(Icons.check, color: VoyentaColors.onPrimary, size: 16) : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}

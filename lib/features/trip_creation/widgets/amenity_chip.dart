import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class AmenityChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final RxList<String> amenities;

  const AmenityChip({
    super.key,
    required this.label,
    required this.icon,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = amenities.contains(label);
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            amenities.remove(label);
          } else {
            amenities.add(label);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? VoyentaColors.primaryContainer.withValues(alpha: 0.2) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? VoyentaColors.primary.withValues(alpha: 0.4) : VoyentaColors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? VoyentaColors.primary : VoyentaColors.onSurfaceVariant, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: VoyentaTypography.bodyMd.copyWith(
                  color: isSelected ? VoyentaColors.primary : VoyentaColors.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

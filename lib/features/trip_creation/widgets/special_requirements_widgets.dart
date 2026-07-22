import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class SpecialRequirementsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget content;

  const SpecialRequirementsSection({super.key, required this.title, required this.icon, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: VoyentaColors.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: VoyentaColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }
}

class SpecialRequirementChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final RxList<String> selection;

  const SpecialRequirementChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selection,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = selection.contains(label);
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            selection.remove(label);
          } else {
            selection.add(label);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? VoyentaColors.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? VoyentaColors.primaryContainer : VoyentaColors.outlineVariant,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? VoyentaColors.onPrimaryContainer : VoyentaColors.onSurface, size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: isSelected ? VoyentaColors.onPrimaryContainer : VoyentaColors.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

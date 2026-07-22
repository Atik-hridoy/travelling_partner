import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class TravelStyleSelector extends StatelessWidget {
  final List<String> allStyles;
  final Set<String> selectedStyles;
  final ValueChanged<String> onToggleStyle;

  const TravelStyleSelector({
    super.key,
    required this.allStyles,
    required this.selectedStyles,
    required this.onToggleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Travel Style',
              style: VoyentaTypography.headlineMd.copyWith(
                color: VoyentaColors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: VoyentaTypography.labelCaps.copyWith(
                  color: VoyentaColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...allStyles.map((style) {
              final isSelected = selectedStyles.contains(style);
              return GestureDetector(
                onTap: () => onToggleStyle(style),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? VoyentaColors.primary : VoyentaColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: VoyentaColors.primary.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    style,
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: isSelected ? Colors.white : VoyentaColors.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              );
            }),

            // Add Chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: VoyentaColors.outlineVariant,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, size: 16, color: VoyentaColors.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    'Add',
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

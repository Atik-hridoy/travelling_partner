import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class KnowBeforeYouGo extends StatelessWidget {
  final Map<String, dynamic> place;

  const KnowBeforeYouGo({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> gridItems = place['knowBeforeGo'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Know Before You Go',
            style: VoyentaTypography.headlineMd.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: VoyentaColors.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: gridItems.map((item) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: VoyentaColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
                      const SizedBox(height: 6),
                      Text(
                        (item['label'] as String).toUpperCase(),
                        style: VoyentaTypography.labelCaps.copyWith(
                          color: VoyentaColors.outline,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['value'] as String,
                        style: VoyentaTypography.bodyMd.copyWith(
                          fontWeight: FontWeight.bold,
                          color: VoyentaColors.onSurface,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

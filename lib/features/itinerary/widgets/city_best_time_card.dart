import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class CityBestTimeCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CityBestTimeCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> times = data['bestTimes'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month, color: VoyentaColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Best Time to Visit',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...times.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['label'] as String,
                      style: const TextStyle(
                        color: VoyentaColors.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      item['value'] as String,
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: VoyentaColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          Text(
            data['bestTimeDesc'] as String,
            style: VoyentaTypography.bodyMd.copyWith(
              color: VoyentaColors.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

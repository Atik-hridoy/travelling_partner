import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class CityQuickStatsGrid extends StatelessWidget {
  final Map<String, dynamic> data;

  const CityQuickStatsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Safety Score
        Expanded(
          child: Container(
            height: 110,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: VoyentaColors.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.health_and_safety, color: Colors.white70, size: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SAFETY SCORE',
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: Colors.white70,
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          data['safetyScore'].toString().split('/')[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '/5',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Budget
        Expanded(
          child: Container(
            height: 110,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: VoyentaColors.tertiaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.payments, color: VoyentaColors.onTertiaryContainer, size: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BUDGET',
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: VoyentaColors.onTertiaryContainer.withOpacity(0.8),
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data['budgetValue'] as String,
                      style: TextStyle(
                        color: VoyentaColors.onTertiaryContainer,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class CityThingsToKnowCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CityThingsToKnowCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.checklist, color: VoyentaColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Things to Know',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildChecklistSection(
                  'CUSTOMS',
                  data['customs'] as List<dynamic>,
                  Icons.check_circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildChecklistSection(
                  'PRACTICAL',
                  data['practical'] as List<dynamic>,
                  Icons.payments,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildChecklistSection(
                  'COMMUTE',
                  data['commute'] as List<dynamic>,
                  Icons.directions_bus,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistSection(String title, List<dynamic> items, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: VoyentaTypography.labelCaps.copyWith(
            color: VoyentaColors.primary,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((text) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: VoyentaColors.primary, size: 12),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    text as String,
                    style: const TextStyle(
                      color: VoyentaColors.onSurfaceVariant,
                      fontSize: 10,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class CityAISummaryCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CityAISummaryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoyentaColors.primaryContainer.withOpacity(0.1),
                ),
                child: const Center(
                  child: Icon(Icons.auto_awesome, color: VoyentaColors.primary, size: 18),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['conciergeTitle'] as String,
                    style: VoyentaTypography.headlineMd.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: VoyentaColors.primary,
                    ),
                  ),
                  Text(
                    data['conciergeSub'] as String,
                    style: VoyentaTypography.labelCaps.copyWith(
                      fontSize: 7,
                      color: VoyentaColors.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data['conciergeDesc'] as String,
            style: VoyentaTypography.bodyMd.copyWith(
              color: VoyentaColors.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

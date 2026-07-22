import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SafetyScoreCard extends StatelessWidget {
  const SafetyScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VoyentaColors.inverseSurface,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Safety Score',
                style: VoyentaTypography.bodyLg.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '9.4',
                style: VoyentaTypography.displayLgMobile.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: VoyentaColors.tertiaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Your current neighborhood is rated highly safe with low incidence of minor theft and excellent street lighting.',
            style: VoyentaTypography.bodyMd.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

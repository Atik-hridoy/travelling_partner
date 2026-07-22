import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/glass_card.dart';

class ContinuePlanningSection extends StatelessWidget {
  const ContinuePlanningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Continue Planning',
              style: VoyentaTypography.headlineMd.copyWith(
                fontWeight: FontWeight.w800,
                color: VoyentaColors.onSurface,
                fontSize: 18,
              ),
            ),
            Text(
              'View All',
              style: VoyentaTypography.bodyMd.copyWith(
                color: VoyentaColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Get.toNamed('/kyoto_details'),
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            borderRadius: 24,
            child: Row(
              children: [
                // Network Kyoto Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDYvfpOSIOt3jtbI2ka9Qy9-FlpZZy8ivEqJoiP3NIq80gCD4NHdTEnmEGG3Hs6Fb-BNeq4S0Ehrp59YCZ1ftqU3maxQ9ExlFwpcoQ7RaO33W0d4wxfKcj-7_AdR9BINtJR2F2CngSoSQtzpvJ2RLyOlBtAh5USVuYcAqfKpy7nr2Dkj4Vz500Gq9fQkAM_da2P6sT9q3SR81vwOsawthaM7vWcUmM-GSFZPDZnQ9SHHCcFZCNKh7JSaLb2DoIkNVUGrgH2mkH7uBMJ',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flight_takeoff, color: VoyentaColors.primary, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'OCT 12 - OCT 19',
                            style: VoyentaTypography.labelCaps.copyWith(
                              color: VoyentaColors.primary,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Spring in Kyoto, Japan',
                        style: VoyentaTypography.bodyMd.copyWith(
                          fontWeight: FontWeight.bold,
                          color: VoyentaColors.onSurface,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '5 items left in your bucket list. Need help with dining reservations?',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: VoyentaTypography.bodyMd.copyWith(
                          color: VoyentaColors.onSurfaceVariant.withOpacity(0.8),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                          value: 0.65,
                          minHeight: 6,
                          backgroundColor: VoyentaColors.surfaceContainerHigh,
                          valueColor: AlwaysStoppedAnimation<Color>(VoyentaColors.primary),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '65% COMPLETED',
                            style: VoyentaTypography.labelCaps.copyWith(
                              color: VoyentaColors.onSurfaceVariant,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            'AI SYNCED',
                            style: VoyentaTypography.labelCaps.copyWith(
                              color: VoyentaColors.primary,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

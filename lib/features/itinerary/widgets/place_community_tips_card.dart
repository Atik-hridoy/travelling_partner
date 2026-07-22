import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class PlaceCommunityTipsCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PlaceCommunityTipsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> tips = data['communityTips'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.verified_user, color: VoyentaColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Community Tips',
                    style: VoyentaTypography.headlineMd.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: VoyentaColors.primary,
                    ),
                  ),
                ],
              ),
              Text(
                'View All',
                style: VoyentaTypography.labelCaps.copyWith(
                  fontSize: 9,
                  color: VoyentaColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: tips.map((tip) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: VoyentaColors.primary.withOpacity(0.05)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: VoyentaColors.primaryContainer.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Icon(tip['icon'] as IconData, color: VoyentaColors.primary, size: 16),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip['title'] as String,
                            style: const TextStyle(
                              color: VoyentaColors.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tip['desc'] as String,
                            style: const TextStyle(
                              color: VoyentaColors.onSurfaceVariant,
                              fontSize: 10.5,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

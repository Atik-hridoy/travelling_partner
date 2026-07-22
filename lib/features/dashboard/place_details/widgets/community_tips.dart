import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class CommunityTips extends StatelessWidget {
  final Map<String, dynamic> place;

  const CommunityTips({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> tips = place['tips'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Community Tips',
            style: VoyentaTypography.headlineMd.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: VoyentaColors.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: tips.map((tip) {
              final isPrimaryColor = tip['userInitials'] == 'MS';
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPrimaryColor ? VoyentaColors.primaryContainer : VoyentaColors.secondaryContainer,
                          ),
                          child: Center(
                            child: Text(
                              tip['userInitials'] as String,
                              style: TextStyle(
                                color: isPrimaryColor ? VoyentaColors.primary : VoyentaColors.onSecondaryContainer,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tip['username'] as String,
                          style: VoyentaTypography.labelCaps.copyWith(
                            color: VoyentaColors.onSurface,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tip['desc'] as String,
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: VoyentaColors.onSurfaceVariant,
                        fontSize: 12.5,
                        height: 1.4,
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

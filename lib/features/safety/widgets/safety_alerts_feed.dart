import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SafetyAlertsFeed extends StatelessWidget {
  const SafetyAlertsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainer,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Safety Alerts',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: VoyentaColors.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: VoyentaColors.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '2 ACTIVE',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.onTertiaryContainer,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Alert Item 1: Heavy Rain
          AlertFeedItem(
            icon: Icons.cyclone,
            iconColor: VoyentaColors.tertiary,
            bgColor: VoyentaColors.tertiaryContainer.withOpacity(0.12),
            title: 'Weather Warning: Heavy Rain',
            time: 'Just now',
            desc: 'Severe thunderstorms and heavy rainfall expected between 18:00 and 22:00. Avoid riverside areas and outdoor activities.',
          ),
          const SizedBox(height: 12),
          // Alert Item 2: Congestion alert
          AlertFeedItem(
            icon: Icons.info_outline,
            iconColor: VoyentaColors.primary,
            bgColor: VoyentaColors.primaryContainer.withOpacity(0.08),
            title: 'Local Festival: Congestion Alert',
            time: '2h ago',
            desc: 'High pedestrian density reported near Shibuya Crossing due to the Tanabata parade. Expect 30-minute delays.',
          ),
        ],
      ),
    );
  }
}

class AlertFeedItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String time;
  final String desc;

  const AlertFeedItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    required this.time,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: VoyentaTypography.bodyMd.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: VoyentaColors.onSurface,
                      ),
                    ),
                    Text(
                      time,
                      style: VoyentaTypography.monoTechnical.copyWith(
                        fontSize: 10,
                        color: VoyentaColors.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: VoyentaTypography.bodyMd.copyWith(
                    fontSize: 11,
                    height: 1.35,
                    color: VoyentaColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

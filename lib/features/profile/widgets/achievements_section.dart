import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class AchievementsSection extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;

  const AchievementsSection({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Unlocked achievements
        ...achievements.map((a) {
          final isGold = a['color'] == 'gold';
          final isPrimary = a['color'] == 'primary';

          Color bgColor;
          Color iconColor;
          if (isGold) {
            bgColor = const Color(0xFFC9A74D);
            iconColor = Colors.white;
          } else if (isPrimary) {
            bgColor = const Color(0xFFCFBCFF); // primary-fixed-dim
            iconColor = VoyentaColors.primary;
          } else {
            bgColor = VoyentaColors.secondaryContainer;
            iconColor = VoyentaColors.secondary;
          }

          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isGold
                      ? const Color(0xFFC9A74D).withOpacity(0.2)
                      : Colors.white.withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: isGold ? null : bgColor,
                      gradient: isGold
                          ? const LinearGradient(
                              colors: [Color(0xFFE7C365), Color(0xFFC9A74D)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      shape: BoxShape.circle,
                      boxShadow: isGold
                          ? [
                              BoxShadow(
                                color: const Color(0xFFC9A74D).withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(a['icon'] as IconData, color: iconColor, size: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    a['label'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: VoyentaTypography.bodyMd.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: VoyentaColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

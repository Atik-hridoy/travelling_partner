import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SocialCommunitySection extends StatelessWidget {
  const SocialCommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SOCIAL & COMMUNITY',
          style: VoyentaTypography.labelCaps.copyWith(
            color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSocialCard(
                avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
                iconBadge: Icons.favorite_rounded,
                name: 'Julian D.',
                text: 'liked your Kyoto story.',
                time: '4m ago',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSocialCard(
                iconBadge: Icons.auto_fix_high_rounded,
                badgeColor: VoyentaColors.tertiaryContainer,
                name: 'New template',
                text: 'available for "Hidden Gems".',
                time: '1d ago',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialCard({
    String? avatarUrl,
    IconData? iconBadge,
    Color? badgeColor,
    required String name,
    required String text,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: VoyentaColors.outlineVariant.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          if (avatarUrl != null)
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(avatarUrl),
            )
          else if (iconBadge != null)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: badgeColor ?? VoyentaColors.tertiaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(iconBadge, color: VoyentaColors.onTertiaryContainer, size: 20),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: '$name ',
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: VoyentaColors.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: text,
                        style: VoyentaTypography.bodyMd.copyWith(
                          color: VoyentaColors.onSurfaceVariant,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.5),
                    fontSize: 10,
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

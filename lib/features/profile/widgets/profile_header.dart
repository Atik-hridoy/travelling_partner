import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../../core/routes/app_routes.dart';

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final String avatarPath = (user['avatar'] ?? user['avatarUrl'] ?? user['imageUrl']) as String? ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400';
    final bool isLocalFile = avatarPath.isNotEmpty && !avatarPath.startsWith('http') && File(avatarPath).existsSync();

    return Column(
      children: [
        // Avatar + Badge
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.primary.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: isLocalFile
                      ? Image.file(
                          File(avatarPath),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          avatarPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: VoyentaColors.surfaceContainerHigh,
                              child: Center(
                                child: Text(
                                  'JD',
                                  style: VoyentaTypography.headlineMd.copyWith(
                                    color: VoyentaColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
              // Gold Member Badge
              Positioned(
                bottom: -8,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE7C365), Color(0xFFC9A74D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC9A74D).withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        (user['memberBadge'] as String?) ?? 'GOLD VOYAGER',
                        style: VoyentaTypography.labelCaps.copyWith(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Name + Tagline
        Center(
          child: Column(
            children: [
              Text(
                (user['name'] as String?) ?? 'Julian D.',
                style: VoyentaTypography.displayLgMobile.copyWith(
                  fontWeight: FontWeight.w800,
                  color: VoyentaColors.onSurface,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                (user['tagline'] as String?) ?? (user['bio'] as String?) ?? 'Curating the Unseen',
                style: VoyentaTypography.bodyMd.copyWith(
                  color: VoyentaColors.onSurfaceVariant,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              // Location + Website
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined, size: 14, color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.7)),
                  const SizedBox(width: 4),
                  Text(
                    (user['location'] as String?) ?? 'Zurich, Switzerland',
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.8),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.link, size: 14, color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.7)),
                  const SizedBox(width: 4),
                  Text(
                    (user['website'] as String?) ?? 'voyanta.travel/julian_d',
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.EDIT_PROFILE);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VoyentaColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: VoyentaColors.primary.withValues(alpha: 0.3),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: VoyentaColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(Icons.share, color: VoyentaColors.onSurfaceVariant, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class LiveStoriesCarousel extends StatelessWidget {
  final List<Map<String, String>> stories;

  const LiveStoriesCarousel({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 440,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          final isLive = story['isLive'] == 'true';
          final userAvatar = story['userAvatar'] ?? '';

          return Container(
            width: 260,
            margin: const EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Story Image
                  Image.network(
                    story['img']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: VoyentaColors.surfaceContainerHigh,
                        child: const Icon(Icons.image_not_supported, color: VoyentaColors.outline, size: 36),
                      );
                    },
                  ),
                  // Gradient overlay shader
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.15),
                          Colors.black.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Live indicator top right
                  if (isLive)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: VoyentaColors.rose,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'LIVE',
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
                  // Bottom Content Info
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (userAvatar.isNotEmpty)
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: VoyentaColors.primary,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage(userAvatar),
                                  backgroundColor: Colors.grey[300],
                                ),
                              )
                            else
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white24,
                                ),
                                child: const Icon(Icons.person, color: Colors.white, size: 16),
                              ),
                            const SizedBox(width: 8),
                            Text(
                              story['user']!,
                              style: VoyentaTypography.bodyMd.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          story['title']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: VoyentaTypography.headlineMd.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Save to Trip button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.bookmark_add_outlined, color: VoyentaColors.primary, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                'Save to Trip',
                                style: VoyentaTypography.bodyMd.copyWith(
                                  color: VoyentaColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

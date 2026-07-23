import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/routes/app_routes.dart';

class MapTrendingCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> nearbyPlaces;
  final bool isLoading;

  const MapTrendingCarousel({
    super.key, 
    required this.nearbyPlaces,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 85,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DISCOVER',
                      style: VoyentaTypography.labelCaps.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: VoyentaColors.primary.withOpacity(0.8),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Trending Nearby',
                      style: VoyentaTypography.headlineMd.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: VoyentaColors.onSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'See All',
                      style: VoyentaTypography.labelCaps.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: VoyentaColors.primary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(Icons.chevron_right, size: 16, color: VoyentaColors.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Carousel
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: nearbyPlaces.length,
              itemBuilder: (context, index) {
                final place = nearbyPlaces[index];
                final tags = (place['tags'] as List<dynamic>?) ?? [];
                final isDark = index == 0;

                return GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.SHISENDO_DETAILS),
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: isDark ? 16 : 20, sigmaY: isDark ? 16 : 20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.black.withOpacity(0.2)
                                : VoyentaColors.surface.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(isDark ? 0.2 : 0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          place['title']!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: VoyentaTypography.headlineMd.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: VoyentaColors.onSurface,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.near_me, size: 12, color: VoyentaColors.onSurfaceVariant),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                place['dist']!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: VoyentaTypography.bodyMd.copyWith(
                                                  color: VoyentaColors.onSurfaceVariant,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Match Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: VoyentaColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.auto_awesome, size: 14, color: VoyentaColors.primary),
                                        const SizedBox(width: 4),
                                        Text(
                                          place['match'] ?? 'Nearby',
                                          style: VoyentaTypography.labelCaps.copyWith(
                                            color: VoyentaColors.primary,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Tags
                              Row(
                                children: tags.map((tag) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      (tag as String).toUpperCase(),
                                      style: VoyentaTypography.labelCaps.copyWith(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: VoyentaColors.onSurface,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

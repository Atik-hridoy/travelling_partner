import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/mock/mock_data.dart';

class TrendingPlacesSection extends StatelessWidget {
  const TrendingPlacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> spots = MockData.trendingSpots;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Places',
          style: VoyentaTypography.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: VoyentaColors.onSurface,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: spots.length,
            itemBuilder: (context, index) {
              final spot = spots[index];
              return GestureDetector(
                onTap: () => Get.toNamed('/place_details'),
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image
                      Image.network(
                        spot['img']!,
                        fit: BoxFit.cover,
                      ),
                      // Gradient shadow
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Star rate badge top left
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: VoyentaColors.primary, size: 12),
                              const SizedBox(width: 3),
                              Text(
                                spot['rate']!,
                                style: VoyentaTypography.labelCaps.copyWith(
                                  color: VoyentaColors.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Details bottom overlay
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              spot['title']!,
                              style: VoyentaTypography.bodyMd.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              spot['sub']!,
                              style: VoyentaTypography.bodyMd.copyWith(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'AI MATCH',
                                  style: VoyentaTypography.labelCaps.copyWith(
                                    color: Colors.white70,
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  spot['match']!,
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
            );
            },
          ),
        ),
      ],
    );
  }
}

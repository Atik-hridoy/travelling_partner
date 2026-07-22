import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/mock/mock_data.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> destinations = MockData.searchTrendingDestinations;
    final largeItem = destinations.firstWhere((item) => item['isLarge'] == true);
    final List<Map<String, dynamic>> smallerItems =
        destinations.where((item) => item['isLarge'] != true).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Destinations',
              style: VoyentaTypography.headlineMd.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: VoyentaColors.onSurface,
              ),
            ),
            Row(
              children: [
                _buildCircularChevron(Icons.chevron_left),
                const SizedBox(width: 8),
                _buildCircularChevron(Icons.chevron_right),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Main Feature Card (Large)
        GestureDetector(
          onTap: () => Get.toNamed('/kyoto_details'),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: NetworkImage(largeItem['img'] as String),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: VoyentaColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        largeItem['badge'] as String,
                        style: VoyentaTypography.labelCaps.copyWith(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      largeItem['country'] as String,
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: Colors.white70,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  largeItem['title'] as String,
                  style: VoyentaTypography.headlineMd.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      largeItem['desc'] as String,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
        ),
        const SizedBox(height: 12),

        // Smaller Bento Items (2 Column Row)
        Row(
          children: smallerItems.map((item) {
            final hasRating = item['rating'] != null;

            return Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed('/kyoto_details'),
                child: Container(
                  height: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(item['img'] as String),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        item['country'] as String,
                        style: VoyentaTypography.labelCaps.copyWith(
                          color: Colors.white70,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['title'] as String,
                        style: VoyentaTypography.headlineMd.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      hasRating
                          ? Row(
                              children: [
                                const Icon(Icons.star, color: VoyentaColors.tertiary, size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  item['rating'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                const Icon(Icons.trending_up, color: Colors.white70, size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  item['trendBadge'] as String,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCircularChevron(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Icon(icon, color: VoyentaColors.outline, size: 16),
    );
  }
}

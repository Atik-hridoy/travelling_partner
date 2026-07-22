import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class TrendingSection extends StatelessWidget {
  final Map<String, dynamic> place;

  const TrendingSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> trending = place['trending'];
    final largeItem = trending.firstWhere((item) => item['isLarge'] == true);
    final List<dynamic> smallerItems = trending.where((item) => item['isLarge'] != true).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "What's Trending Here",
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.onSurface,
                ),
              ),
              Text(
                'View All',
                style: VoyentaTypography.labelCaps.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Featured Card (Large)
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(largeItem['img']),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
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
                  const SizedBox(height: 6),
                  Text(
                    largeItem['title'] as String,
                    style: VoyentaTypography.headlineMd.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    largeItem['sub'] as String,
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Smaller Bento Items (2 Column Row)
          Row(
            children: smallerItems.map((item) {
              return Expanded(
                child: Container(
                  height: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(item['img']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        item['title'] as String,
                        style: VoyentaTypography.bodyMd.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/mock/mock_data.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> searches = MockData.recentSearches;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Searches',
              style: VoyentaTypography.headlineMd.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: VoyentaColors.onSurface,
              ),
            ),
            Text(
              'CLEAR ALL',
              style: VoyentaTypography.labelCaps.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: VoyentaColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: searches.map((item) {
            final isKyoto = item['title'].toString().contains('Kyoto');
            final isSantorini = item['title'].toString().contains('Santorini');

            return GestureDetector(
              onTap: () {
                if (isSantorini) {
                  // Direct to Place Details for Santorini
                  Get.toNamed('/place_details');
                } else if (isKyoto) {
                  // Direct to Kyoto Details
                  Get.toNamed('/kyoto_details');
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item['img'] as String,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 48,
                            height: 48,
                            color: VoyentaColors.surfaceContainerHigh,
                            child: const Icon(Icons.image_not_supported, color: VoyentaColors.outline, size: 20),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: VoyentaTypography.bodyMd.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: VoyentaColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['subtitle'] as String,
                            style: VoyentaTypography.labelCaps.copyWith(
                              fontSize: 8,
                              color: VoyentaColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.history, color: VoyentaColors.outline, size: 20),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

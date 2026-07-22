import 'package:flutter/material.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/mock/mock_data.dart';

class CuratedCollections extends StatelessWidget {
  const CuratedCollections({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> collections = MockData.searchCollections;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Curated Collections',
          style: VoyentaTypography.headlineMd.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black, // fallback
          ),
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: collections.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: item['color'] as Color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(item['icon'] as IconData, color: item['textColor'] as Color, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: VoyentaTypography.headlineMd.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: item['textColor'] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['desc'] as String,
                    style: TextStyle(
                      color: (item['textColor'] as Color).withOpacity(0.7),
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'EXPLORE ${item['guidesCount']} GUIDES',
                        style: VoyentaTypography.labelCaps.copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: item['textColor'] as Color,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right, color: item['textColor'] as Color, size: 16),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

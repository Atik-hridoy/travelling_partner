import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class HighlightsSection extends StatelessWidget {
  final Map<String, dynamic> place;

  const HighlightsSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> highlights = place['highlights'];

    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: highlights.length,
        itemBuilder: (context, index) {
          final item = highlights[index];
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: VoyentaColors.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(item['icon'] as IconData, color: VoyentaColors.onSecondaryContainer, size: 16),
                const SizedBox(width: 6),
                Text(
                  item['label'] as String,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.onSecondaryContainer,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

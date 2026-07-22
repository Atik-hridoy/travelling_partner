import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SearchHeroSection extends StatelessWidget {
  const SearchHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Travel Questions?',
            style: VoyentaTypography.displayLgMobile.copyWith(
              color: VoyentaColors.onSurface,
              fontWeight: FontWeight.w800,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Ask the global community of local experts and seasoned travelers.',
            textAlign: TextAlign.center,
            style: VoyentaTypography.bodyMd.copyWith(
              color: VoyentaColors.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          // Search box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Icon(Icons.quiz_outlined, color: VoyentaColors.primary, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Search questions like 'Best jazz bars in Tokyo'...",
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withOpacity(0.6),
                      fontSize: 13,
                    ),
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

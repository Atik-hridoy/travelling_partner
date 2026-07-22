import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class LiveStoriesHeader extends StatelessWidget {
  const LiveStoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LIVE STORIES',
              style: VoyentaTypography.labelCaps.copyWith(
                color: VoyentaColors.primary,
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Curated Travel Stories',
              style: VoyentaTypography.headlineMd.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: VoyentaColors.onSurface,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'VIEW ALL',
              style: VoyentaTypography.labelCaps.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: VoyentaColors.primary,
              ),
            ),
            const Icon(Icons.chevron_right, size: 14, color: VoyentaColors.primary),
          ],
        ),
      ],
    );
  }
}

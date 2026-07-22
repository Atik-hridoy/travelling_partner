import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class InsiderAccessHeader extends StatelessWidget {
  const InsiderAccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INSIDER ACCESS',
          style: VoyentaTypography.labelCaps.copyWith(
            color: VoyentaColors.tertiary,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Hidden Gems & Local Guides',
          style: VoyentaTypography.headlineMd.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: VoyentaColors.onSurface,
          ),
        ),
      ],
    );
  }
}

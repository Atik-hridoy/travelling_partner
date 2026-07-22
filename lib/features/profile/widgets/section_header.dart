import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String action;

  const SectionHeader({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: VoyentaTypography.headlineMd.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: VoyentaColors.onSurface,
          ),
        ),
        Row(
          children: [
            Text(
              action,
              style: VoyentaTypography.bodyMd.copyWith(
                color: VoyentaColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_forward, size: 14, color: VoyentaColors.primary),
          ],
        ),
      ],
    );
  }
}

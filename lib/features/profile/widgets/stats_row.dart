import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class StatsRow extends StatelessWidget {
  final List<Map<String, String>> stats;

  const StatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats.asMap().entries.map((entry) {
        final index = entry.key;
        final stat = entry.value;
        final isHighlighted = index == 1;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index < stats.length - 1 ? 12 : 0,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? VoyentaColors.primary.withOpacity(0.05)
                  : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: isHighlighted
                    ? VoyentaColors.primary.withOpacity(0.1)
                    : Colors.white.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: VoyentaColors.primary.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  stat['value']!,
                  style: VoyentaTypography.displayLgMobile.copyWith(
                    color: VoyentaColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stat['label']!.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.onSurfaceVariant,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

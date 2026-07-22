import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import 'weather_widget.dart';

class AppBarHeader extends StatelessWidget {
  final ValueChanged<WeatherType>? onWeatherChanged;

  const AppBarHeader({
    super.key,
    this.onWeatherChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: VoyentaColors.primary, size: 24),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURRENT LOCATION',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                    fontSize: 9,
                  ),
                ),
                Text(
                  'San Francisco, CA',
                  style: VoyentaTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.bold,
                    color: VoyentaColors.onSurface,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Centered App Title
        Text(
          'Voyanta',
          style: VoyentaTypography.displayLgMobile.copyWith(
            color: VoyentaColors.primary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        // Weather Widget with Animated Entrance & Effects
        WeatherWidget(
          onWeatherChanged: onWeatherChanged,
        ),
      ],
    );
  }
}

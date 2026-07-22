import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/services/location_weather_service.dart';
import 'weather_widget.dart';

class AppBarHeader extends StatefulWidget {
  final ValueChanged<WeatherType>? onWeatherChanged;

  const AppBarHeader({
    super.key,
    this.onWeatherChanged,
  });

  @override
  State<AppBarHeader> createState() => _AppBarHeaderState();
}

class _AppBarHeaderState extends State<AppBarHeader> {
  String _locationName = 'Locating...';
  String _temperature = '--';
  String _condition = 'Clear';
  WeatherType _weatherType = WeatherType.sunny;

  @override
  void initState() {
    super.initState();
    _loadRealLocationAndWeather();
  }

  Future<void> _loadRealLocationAndWeather() async {
    final data = await LocationWeatherService.fetchLiveWeatherAndLocation();
    if (mounted) {
      setState(() {
        _locationName = data.locationName;
        _temperature = data.temperature;
        _condition = data.conditionName;
        _weatherType = data.weatherType;
      });
      widget.onWeatherChanged?.call(data.weatherType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Real Device Location Display
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
                  _locationName,
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

        // App Branding
        Text(
          'Voyanta',
          style: VoyentaTypography.displayLgMobile.copyWith(
            color: VoyentaColors.primary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),

        // Real Weather Display (Tapping test demo disabled)
        WeatherWidget(
          temperature: _temperature,
          conditionName: _condition,
          initialType: _weatherType,
        ),
      ],
    );
  }
}

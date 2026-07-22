import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'widgets/app_bar_header.dart';
import 'widgets/floating_search_bar.dart';
import 'widgets/ai_hero_section.dart';
import 'widgets/continue_planning_section.dart';
import 'widgets/trending_places_section.dart';
import 'widgets/hidden_gems_section.dart';
import 'widgets/weather_widget.dart';
import 'widgets/weather_overlay_effect.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  WeatherType _currentWeatherType = WeatherType.cloudy;
  int _overlayKey = 0;

  void _triggerWeatherOverlay(WeatherType type) {
    setState(() {
      _currentWeatherType = type;
      _overlayKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 16.0,
                bottom: 120.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header (Location, Title, Weather Widget)
                  AppBarHeader(
                    onWeatherChanged: _triggerWeatherOverlay,
                  ),
                  const SizedBox(height: 24),

                  // 2. Centered Floating Search Bar
                  const FloatingSearchBar(),
                  const SizedBox(height: 24),

                  // 3. AI Hero Section: Plan My Day
                  const AIHeroSection(),
                  const SizedBox(height: 28),

                  // 4. Continue Planning
                  const ContinuePlanningSection(),
                  const SizedBox(height: 28),

                  // 5. Trending Places Carousel
                  const TrendingPlacesSection(),
                  const SizedBox(height: 28),

                  // 6. Hidden Gems Section
                  const HiddenGemsSection(),
                ],
              ),
            ),
          ),
          // 7. Full Home View Weather Overlay Effect (Runs for 4 seconds on entry/weather change)
          Positioned.fill(
            child: WeatherOverlayEffect(
              key: ValueKey(_overlayKey),
              weatherType: _currentWeatherType,
              displayDuration: const Duration(seconds: 4),
            ),
          ),
        ],
      ),
    );
  }
}

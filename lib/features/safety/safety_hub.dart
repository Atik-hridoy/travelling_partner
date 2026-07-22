import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'safety_controller.dart';
import 'widgets/sos_button_grid.dart';
import 'widgets/safety_alerts_feed.dart';
import 'widgets/location_map_card.dart';
import 'widgets/embassy_info_card.dart';
import 'widgets/safety_score_card.dart';

class SafetyHub extends GetView<SafetyController> {
  const SafetyHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 120.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header title
              Row(
                children: [
                  const Icon(Icons.emergency_share_outlined, color: VoyentaColors.rose, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    'SOS & Emergency Hub',
                    style: VoyentaTypography.displayLgMobile.copyWith(
                      fontWeight: FontWeight.w800,
                      color: VoyentaColors.rose,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Help is a tap away. Use the controls below for immediate assistance. Your precise location is being shared with responders.',
                style: VoyentaTypography.bodyMd.copyWith(
                  color: VoyentaColors.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),

              // SOS Call Buttons row
              const SosButtonGrid(),
              const SizedBox(height: 28),

              // Safety Alerts Feed
              const SafetyAlertsFeed(),
              const SizedBox(height: 28),

              // Map Context Area
              const LocationMapCard(),
              const SizedBox(height: 20),

              // Embassy Info Card
              const EmbassyInfoCard(),
              const SizedBox(height: 20),

              // Safety Score Card
              const SafetyScoreCard(),
            ],
          ),
        ),
      ),
    );
  }
}

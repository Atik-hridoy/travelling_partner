import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import 'notifications_controller.dart';
import 'widgets/notifications_header.dart';
import 'widgets/nova_ai_insights_section.dart';
import 'widgets/trip_updates_section.dart';
import 'widgets/social_community_section.dart';
import 'widgets/destination_context_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<NotificationsController>()
        ? Get.find<NotificationsController>()
        : Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header Bar
            NotificationsHeader(onClearAll: controller.clearAll),

            // 2. Scrollable Body
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nova AI Insights
                    NovaAiInsightsSection(),

                    SizedBox(height: 28),

                    // Trip Updates
                    TripUpdatesSection(),

                    SizedBox(height: 28),

                    // Social & Community
                    SocialCommunitySection(),

                    SizedBox(height: 28),

                    // Destination Context Banner
                    DestinationContextCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

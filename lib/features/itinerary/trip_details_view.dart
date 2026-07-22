import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'trip_planner_controller.dart';
import 'widgets/create_new_trip_tab.dart';
import 'widgets/trip_hero_card.dart';
import 'widgets/trip_horizontal_nav.dart';
import 'widgets/trip_dashboard_cards.dart';
import 'widgets/trip_dashboard_sidebar.dart';
import 'widgets/trip_live_tab.dart';
import 'widgets/trip_ai_tab.dart';
import 'widgets/trip_itinerary_tab.dart';

class TripDetailsView extends GetView<TripPlannerController> {
  const TripDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      appBar: AppBar(
        backgroundColor: VoyentaColors.surface.withOpacity(0.8),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Voyanta',
          style: VoyentaTypography.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: VoyentaColors.primary,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: VoyentaColors.primary),
            onPressed: () {
              Get.to(() => const Scaffold(body: CreateNewTripTab()));
            },
            tooltip: 'Create New Trip',
          ),
          IconButton(
            icon: const Icon(Icons.search, color: VoyentaColors.onSurfaceVariant),
            onPressed: () {},
          ),
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 16, left: 8),
            decoration: const BoxDecoration(
              color: VoyentaColors.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'JD',
                style: VoyentaTypography.bodyMd.copyWith(
                  color: VoyentaColors.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const TripAiTab(),
            );
          },
          backgroundColor: VoyentaColors.primary,
          elevation: 8,
          child: const Icon(Icons.auto_awesome, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 16.0,
          bottom: 120.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TripHeroCard(),
            const SizedBox(height: 24),
            const TripHorizontalNav(),
            const SizedBox(height: 24),

            Obx(() {
              if (controller.selectedTab.value == 1) {
                return const TripItineraryTab();
              }
              if (controller.selectedTab.value == 2) {
                return const TripLiveTab();
              }

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          TripUpcomingActivityCard(),
                          SizedBox(height: 24),
                          TripBentoGrid(),
                          SizedBox(height: 24),
                          TripAiRecommendation(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          TripQuickActions(),
                          SizedBox(height: 24),
                          TripActiveBookings(),
                          SizedBox(height: 24),
                          TripPackingProgress(),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    TripUpcomingActivityCard(),
                    SizedBox(height: 24),
                    TripBentoGrid(),
                    SizedBox(height: 24),
                    TripAiRecommendation(),
                    SizedBox(height: 24),
                    TripQuickActions(),
                    SizedBox(height: 24),
                    TripActiveBookings(),
                    SizedBox(height: 24),
                    TripPackingProgress(),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import 'controllers/dashboard_controller.dart';
import 'home/home_dashboard.dart';
import '../map/map_experience.dart';
import '../itinerary/trip_planner.dart';
import '../notifications/notifications_view.dart';
import '../community/community_stories.dart';
import '../profile/profile_view.dart';
import 'widgets/dashboard_bottom_nav.dart';

class DashboardShell extends GetView<DashboardController> {
  const DashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeDashboard(),
      const MapExperience(),
      const TripPlanner(),
      const NotificationsView(),
      const CommunityStories(),
      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: Stack(
        children: [
          // Dynamic Page Content
          Obx(() {
            return IndexedStack(
              index: controller.selectedIndex.value,
              children: pages,
            );
          }),

          // Floating Glassmorphic Navigation Bar
          const DashboardBottomNav(),
        ],
      ),
    );
  }
}

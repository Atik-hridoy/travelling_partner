import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../trip_planner_controller.dart';

class TripHorizontalNav extends GetView<TripPlannerController> {
  const TripHorizontalNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
        children: [
          _buildNavButton('Dashboard', 0),
          _buildNavButton('Itinerary', 1),
          _buildLiveButton(2),
        ],
      )),
    );
  }

  Widget _buildNavButton(String title, int index) {
    final isSelected = controller.selectedTab.value == index;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () => controller.selectTab(index),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? VoyentaColors.primary : VoyentaColors.surfaceContainer,
          foregroundColor: isSelected ? VoyentaColors.onPrimary : VoyentaColors.onSurfaceVariant,
          elevation: isSelected ? 2 : 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildLiveButton(int index) {
    final isSelected = controller.selectedTab.value == index;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () => controller.selectTab(index),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? VoyentaColors.primary : VoyentaColors.surfaceContainer,
          foregroundColor: isSelected ? VoyentaColors.onPrimary : VoyentaColors.onSurfaceVariant,
          elevation: isSelected ? 2 : 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: VoyentaColors.error, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            const Text('Live', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

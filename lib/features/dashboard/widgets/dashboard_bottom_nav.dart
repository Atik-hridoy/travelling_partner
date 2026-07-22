import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBottomNav extends GetView<DashboardController> {
  const DashboardBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
        child: GlassCard(
          borderRadius: 32.0,
          bgOpacity: 0.85,
          blur: 16.0,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
              _buildNavItem(1, Icons.explore_outlined, Icons.explore, 'Explore'),
              _buildNavItem(2, Icons.calendar_today_outlined, Icons.calendar_today, 'Planner'),
              _buildNavItem(3, Icons.group_outlined, Icons.group, 'Community'),
              _buildNavItem(4, Icons.person_outlined, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlineIcon, IconData filledIcon, String label) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      final activeColor = VoyentaColors.primary;
      
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.changeTabIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: isSelected ? activeColor.withOpacity(0.06) : Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? filledIcon : outlineIcon,
                color: isSelected ? activeColor : VoyentaColors.onSurfaceVariant.withOpacity(0.6),
                size: 24,
              ),
              const SizedBox(height: 4),
              // Indicator dot
              if (isSelected)
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeColor,
                  ),
                )
              else
                const SizedBox(height: 4),
            ],
          ),
        ),
      );
    });
  }
}

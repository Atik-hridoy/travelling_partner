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
        padding: const EdgeInsets.only(bottom: 20.0, left: 12.0, right: 12.0),
        child: GlassCard(
          borderRadius: 32.0,
          bgOpacity: 0.88,
          blur: 16.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, 'Home'),
              _buildNavItem(1, Icons.explore_outlined, Icons.explore_rounded, 'Explore'),
              _buildNavItem(2, Icons.calendar_today_outlined, Icons.calendar_today_rounded, 'Planner'),
              _buildNavItem(3, Icons.notifications_none_rounded, Icons.notifications_rounded, 'Alerts', hasBadge: true),
              _buildNavItem(4, Icons.group_outlined, Icons.group_rounded, 'Community'),
              _buildNavItem(5, Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData outlineIcon,
    IconData filledIcon,
    String label, {
    bool hasBadge = false,
  }) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      final activeColor = VoyentaColors.primary;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.changeTabIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: isSelected ? activeColor.withValues(alpha: 0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isSelected ? filledIcon : outlineIcon,
                    color: isSelected ? activeColor : VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                    size: 22,
                  ),
                  if (hasBadge)
                    Positioned(
                      right: -3,
                      top: -3,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: VoyentaColors.rose,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 3),
              // Indicator dot or label
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

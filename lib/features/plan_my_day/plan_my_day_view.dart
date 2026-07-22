import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../navigation/premium_navigation_view.dart';
import 'plan_my_day_controller.dart';
import 'widgets/itinerary_timeline_item.dart';

class PlanMyDayView extends GetView<PlanMyDayController> {
  const PlanMyDayView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlanMyDayController());

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: Stack(
        children: [
          // Main Scrollable Area
          CustomScrollView(
            slivers: [
              // 1. Top Glassmorphic App Bar
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: VoyentaColors.background.withValues(alpha: 0.85),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: VoyentaColors.primary, size: 20),
                  onPressed: () => Get.back(),
                ),
                title: Row(
                  children: [
                    Text(
                      'VOYANTA',
                      style: VoyentaTypography.displayLgMobile.copyWith(
                        color: VoyentaColors.primary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: VoyentaColors.primaryContainer.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'NOVA AI ACTIVE',
                              style: VoyentaTypography.labelCaps.copyWith(
                                color: VoyentaColors.primary,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: VoyentaColors.primary.withValues(alpha: 0.2),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.person, size: 20, color: VoyentaColors.primary);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 2. Body Content
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Section
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: VoyentaColors.primaryContainer.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.auto_awesome_rounded,
                                  size: 14,
                                  color: VoyentaColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'NOVA INTELLIGENCE',
                                  style: VoyentaTypography.labelCaps.copyWith(
                                    color: VoyentaColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your Perfect Day in SF',
                            style: VoyentaTypography.displayLgMobile.copyWith(
                              color: VoyentaColors.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Based on your love for minimalist architecture and hidden gems.',
                            style: VoyentaTypography.bodyMd.copyWith(
                              color: VoyentaColors.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Itinerary Timeline List
                          Obx(() {
                            final items = controller.itineraryItems;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return ItineraryTimelineItem(
                                  item: items[index],
                                  isActive: controller.activeNodeIndex.value == index,
                                  isLast: index == items.length - 1,
                                  onTap: () => controller.setActiveNode(index),
                                );
                              },
                            );
                          }),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 3. Floating Bottom Action Button (Start Navigating)
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Center(
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.primary.withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final activeItem = controller.itineraryItems[controller.activeNodeIndex.value];
                    Get.to(
                      () => PremiumNavigationView(
                        destinationTitle: activeItem.title,
                        destinationImageUrl: activeItem.imageUrl,
                        distanceText: '12 min • ${activeItem.distance}',
                      ),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 400),
                    );
                  },
                  icon: const Icon(Icons.near_me_rounded, size: 20),
                  label: const Text(
                    'Start Navigating',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VoyentaColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

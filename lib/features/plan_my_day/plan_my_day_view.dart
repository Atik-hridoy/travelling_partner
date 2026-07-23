import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../navigation/premium_navigation_view.dart';
import '../profile/profile_controller.dart';
import 'plan_my_day_controller.dart';
import 'widgets/itinerary_timeline_item.dart';

class PlanMyDayView extends GetView<PlanMyDayController> {
  const PlanMyDayView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(PlanMyDayController());

    // Grab user avatar from ProfileController if available
    String avatarUrl = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400';
    if (Get.isRegistered<ProfileController>()) {
      final profile = Get.find<ProfileController>().user.value;
      final url = profile['avatarUrl'] as String? ?? profile['avatar'] as String? ?? '';
      if (url.isNotEmpty && url.startsWith('http')) avatarUrl = url;
    }

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: Stack(
        children: [
          // ── Main Scroll ──────────────────────────────────────────────────
          CustomScrollView(
            slivers: [
              // 1. App Bar
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: VoyentaColors.background.withValues(alpha: 0.92),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: VoyentaColors.primary, size: 20),
                  onPressed: () => Get.back(),
                ),
                title: Text(
                  'VOYANTA',
                  style: VoyentaTypography.displayLgMobile.copyWith(
                    color: VoyentaColors.primary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    fontSize: 20,
                  ),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: VoyentaColors.primaryContainer
                                  .withValues(alpha: 0.15),
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
                                avatarUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.person,
                                      size: 20, color: VoyentaColors.primary);
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

              // 2. Body
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Obx(() {
                        // ── Loading State ──────────────────────────────
                        if (ctrl.isLoading.value) {
                          return const _PlanShimmerLoader();
                        }

                        // ── Loaded State ───────────────────────────────
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // NOVA / GEMINI badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: ctrl.isGeminiPowered.value
                                    ? const Color(0xFF4285F4).withValues(alpha: 0.1)
                                    : VoyentaColors.primaryContainer
                                        .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: ctrl.isGeminiPowered.value
                                      ? const Color(0xFF4285F4).withValues(alpha: 0.3)
                                      : VoyentaColors.primary.withValues(alpha: 0.15),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    ctrl.isGeminiPowered.value
                                        ? Icons.stars_rounded
                                        : Icons.auto_awesome_rounded,
                                    size: 14,
                                    color: ctrl.isGeminiPowered.value
                                        ? const Color(0xFF4285F4)
                                        : VoyentaColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    ctrl.isGeminiPowered.value
                                        ? 'GROQ AI GENERATED'
                                        : 'NOVA INTELLIGENCE',

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

                            // Dynamic city title
                            Text(
                              'Your Perfect Day in ${ctrl.cityName.value}',
                              style: VoyentaTypography.displayLgMobile.copyWith(
                                color: VoyentaColors.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // AI curation tagline from Firebase
                            Text(
                              ctrl.cityTagline.value,
                              style: VoyentaTypography.bodyMd.copyWith(
                                color: VoyentaColors.onSurfaceVariant,
                                fontSize: 13.5,
                                height: 1.5,
                              ),
                            ),

                            // Travel styles chips (if any)
                            if (ctrl.userTravelStyles.isNotEmpty) ...[
                              const SizedBox(height: 14),
                              Wrap(
                                spacing: 8,
                                children: ctrl.userTravelStyles.map((style) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: VoyentaColors.primary
                                          .withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: VoyentaColors.primary
                                            .withValues(alpha: 0.2),
                                      ),
                                    ),
                                    child: Text(
                                      style,
                                      style:
                                          VoyentaTypography.bodyMd.copyWith(
                                        color: VoyentaColors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],

                            const SizedBox(height: 28),

                            // Itinerary Timeline
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ctrl.itineraryItems.length,
                              itemBuilder: (context, index) {
                                return ItineraryTimelineItem(
                                  item: ctrl.itineraryItems[index],
                                  isActive:
                                      ctrl.activeNodeIndex.value == index,
                                  isLast:
                                      index == ctrl.itineraryItems.length - 1,
                                  onTap: () => ctrl.setActiveNode(index),
                                );
                              },
                            ),

                            const SizedBox(height: 100),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 3. Floating Bottom CTA
          Obx(() {
            if (ctrl.isLoading.value || ctrl.itineraryItems.isEmpty) {
              return const SizedBox.shrink();
            }
            return Positioned(
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
                      final activeItem =
                          ctrl.itineraryItems[ctrl.activeNodeIndex.value];
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
            );
          }),
        ],
      ),
    );
  }
}

// ── Shimmer Loader while Firebase + Wiki data loads ──────────────────────────
class _PlanShimmerLoader extends StatefulWidget {
  const _PlanShimmerLoader();

  @override
  State<_PlanShimmerLoader> createState() => _PlanShimmerLoaderState();
}

class _PlanShimmerLoaderState extends State<_PlanShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _anim = Tween<double>(begin: -2, end: 3).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge shimmer
            _shimmerBox(width: 160, height: 28, radius: 20),
            const SizedBox(height: 14),
            // Title shimmer
            _shimmerBox(width: double.infinity, height: 34, radius: 10),
            const SizedBox(height: 8),
            _shimmerBox(width: 220, height: 34, radius: 10),
            const SizedBox(height: 10),
            // Tagline shimmer
            _shimmerBox(width: double.infinity, height: 14, radius: 6),
            const SizedBox(height: 6),
            _shimmerBox(width: double.infinity, height: 14, radius: 6),
            const SizedBox(height: 6),
            _shimmerBox(width: 180, height: 14, radius: 6),
            const SizedBox(height: 28),
            // Timeline cards
            for (int i = 0; i < 3; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBox(width: 40, height: 40, radius: 20),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerBox(width: double.infinity, height: 160, radius: 16),
                        const SizedBox(height: 10),
                        _shimmerBox(width: 140, height: 12, radius: 6),
                        const SizedBox(height: 6),
                        _shimmerBox(width: double.infinity, height: 18, radius: 6),
                        const SizedBox(height: 6),
                        _shimmerBox(width: double.infinity, height: 14, radius: 6),
                        const SizedBox(height: 6),
                        _shimmerBox(width: 200, height: 14, radius: 6),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
            ],
          ],
        );
      },
    );
  }

  Widget _shimmerBox(
      {required double width, required double height, required double radius}) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = width == double.infinity ? constraints.maxWidth : width;
      return Container(
        width: w,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.0, 0.5, 1.0],
            colors: [
              VoyentaColors.outlineVariant.withValues(alpha: 0.15),
              VoyentaColors.outlineVariant.withValues(alpha: 0.35),
              VoyentaColors.outlineVariant.withValues(alpha: 0.15),
            ],
            transform: _SlideTransform(slide: _anim.value),
          ),
        ),
      );
    });
  }
}

class _SlideTransform extends GradientTransform {
  final double slide;
  const _SlideTransform({required this.slide});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slide, 0, 0);
  }
}

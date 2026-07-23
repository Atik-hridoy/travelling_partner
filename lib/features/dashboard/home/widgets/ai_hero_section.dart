import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/routes/app_routes.dart';
import '../../controllers/home_controller.dart';

class AIHeroSection extends StatelessWidget {
  const AIHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: VoyentaColors.primaryContainer,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: VoyentaColors.primary.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                const SizedBox(width: 6),
                Text(
                  'THE INVISIBLE CONCIERGE',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            return Text(
              'Ready to explore ${homeCtrl.currentLocation.value}?',
              style: VoyentaTypography.displayLgMobile.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 26,
              ),
            );
          }),
          const SizedBox(height: 10),
          Obx(() {
            if (homeCtrl.isWikiLoading.value) {
              return const _ShimmerSkeletonLoader();
            }

            return Text(
              homeCtrl.locationSummary.value,
              style: VoyentaTypography.bodyMd.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14,
                height: 1.45,
              ),
            );
          }),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.PLAN_MY_DAY);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_awesome, color: VoyentaColors.primary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Plan My Day',
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: VoyentaColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated shimmer skeleton — shown while Wikipedia summary loads
class _ShimmerSkeletonLoader extends StatefulWidget {
  const _ShimmerSkeletonLoader();

  @override
  State<_ShimmerSkeletonLoader> createState() => _ShimmerSkeletonLoaderState();
}

class _ShimmerSkeletonLoaderState extends State<_ShimmerSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerLine(widthFactor: 1.0),
            const SizedBox(height: 8),
            _buildShimmerLine(widthFactor: 1.0),
            const SizedBox(height: 8),
            _buildShimmerLine(widthFactor: 0.6),
          ],
        );
      },
    );
  }

  Widget _buildShimmerLine({required double widthFactor}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth * widthFactor;
        return Container(
          width: width,
          height: 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.0, 0.5, 1.0],
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.25),
                Colors.white.withValues(alpha: 0.08),
              ],
              transform: _SlidingGradientTransform(slidePercent: _animation.value),
            ),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;
  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}

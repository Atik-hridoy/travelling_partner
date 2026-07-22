import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/traveler_group_card.dart';
import '../widgets/traveler_counter.dart';

class TravelersStep extends GetView<TripWizardController> {
  const TravelersStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Traveler Profile',
            style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            'Tell the Invisible Concierge about your group to tailor activities, accommodations, and pace.',
            style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
          ),
          const SizedBox(height: 40),

          // Group Type Selection
          Row(
            children: const [
              Expanded(child: TravelerGroupCard(icon: Icons.person, title: 'Solo')),
              SizedBox(width: 12),
              Expanded(child: TravelerGroupCard(icon: Icons.favorite, title: 'Couple')),
              SizedBox(width: 12),
              Expanded(child: TravelerGroupCard(icon: Icons.family_restroom, title: 'Family')),
              SizedBox(width: 12),
              Expanded(child: TravelerGroupCard(icon: Icons.group, title: 'Friends')),
            ],
          ),
          const SizedBox(height: 40),

          // Detailed Selectors
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              children: [
                TravelerCounter(title: 'Adults', subtitle: 'Ages 13 and above', icon: Icons.person, count: controller.adults),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: VoyentaColors.surfaceContainerHigh),
                ),
                TravelerCounter(title: 'Children', subtitle: 'Ages 2 to 12', icon: Icons.child_care, count: controller.children),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: VoyentaColors.surfaceContainerHigh),
                ),
                TravelerCounter(title: 'Pets', subtitle: 'Dog, Cat, or service animals', icon: Icons.pets, count: 0.obs), // Mock pets state
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Illustration Area
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, size: 40, color: VoyentaColors.primary.withValues(alpha: 0.3)),
                  const SizedBox(height: 8),
                  Text(
                    'OPTIMIZING FOR YOUR GROUP DYNAMICS',
                    style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

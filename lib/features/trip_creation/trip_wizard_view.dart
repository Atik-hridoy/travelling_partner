import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'trip_wizard_controller.dart';
import 'steps/destination_step.dart';
import 'steps/travel_dates_step.dart';
import 'steps/travelers_step.dart';
import 'steps/budget_step.dart';
import 'steps/transportation_step.dart';
import 'steps/travel_style_step.dart';
import 'steps/accommodation_step.dart';
import 'steps/interests_step.dart';
import 'steps/special_requirements_step.dart';
import 'steps/ai_planning_step.dart';
import 'steps/trip_preview_step.dart';
import 'steps/success_step.dart';

class TripWizardView extends StatelessWidget {
  const TripWizardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Put controller in dependency tree
    final controller = Get.put(TripWizardController());

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      appBar: AppBar(
        backgroundColor: VoyentaColors.surface,
        elevation: 0,
        leading: BackButton(
          color: VoyentaColors.onSurface,
          onPressed: () {
            if (controller.currentPage.value > 0) {
              controller.previousPage();
            } else {
              Get.back();
            }
          },
        ),
        title: Obx(() => LinearProgressIndicator(
              value: (controller.currentPage.value + 1) / 12,
              backgroundColor: VoyentaColors.surfaceContainerHigh,
              valueColor: const AlwaysStoppedAnimation<Color>(VoyentaColors.primary),
              borderRadius: BorderRadius.circular(4),
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping
              children: const [
                DestinationStep(),
                TravelDatesStep(),
                TravelersStep(),
                BudgetStep(),
                TransportationStep(),
                TravelStyleStep(),
                AccommodationStep(),
                InterestsStep(),
                SpecialRequirementsStep(),
                AiPlanningStep(),
                TripPreviewStep(),
                SuccessStep(),
              ],
            ),
          ),
          // Bottom Navigation
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Obx(() {
                if (controller.currentPage.value >= 9) {
                  return const SizedBox.shrink(); // Hide bottom nav for AI Planning, Preview, Success
                }
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: controller.nextPage,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: VoyentaColors.primary,
                          side: const BorderSide(color: VoyentaColors.primary),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: Text('Skip', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.primary)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: VoyentaColors.primary,
                          foregroundColor: VoyentaColors.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          elevation: 4,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Continue', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onPrimary)),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

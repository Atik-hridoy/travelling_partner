import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/travel_dates_widgets.dart';

class TravelDatesStep extends GetView<TripWizardController> {
  const TravelDatesStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: VoyentaColors.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: VoyentaColors.primary.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today, color: VoyentaColors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'SELECTED DURATION',
                  style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final start = controller.startDate.value;
            final end = controller.endDate.value;
            int days = 0;
            if (start != null && end != null) {
              days = end.difference(start).inDays + 1;
            } else if (start != null) {
              days = 1;
            }
            String dest = controller.destination.value;
            if (dest.isEmpty) dest = 'Destination';
            
            return RichText(
              text: TextSpan(
                style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.onSurface),
                children: [
                  TextSpan(text: days > 0 ? '$days Days in ' : 'Select Dates for '),
                  TextSpan(
                    text: dest,
                    style: const TextStyle(color: VoyentaColors.primary),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          Text(
            "The Gion Matsuri festival peaks during your stay. We've optimized your schedule for maximum cultural immersion.",
            style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
          ),
          const SizedBox(height: 40),

          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: VoyentaColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Obx(() => FunctionalCalendar(
                      startDate: controller.startDate.value,
                      endDate: controller.endDate.value,
                      onDateRangeSelected: (start, end) {
                        controller.startDate.value = start;
                        controller.endDate.value = end;
                      },
                    )),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(flex: 1, child: const TravelDatesInsights()),
              ],
            )
          else ...[
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: VoyentaColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Obx(() => FunctionalCalendar(
                startDate: controller.startDate.value,
                endDate: controller.endDate.value,
                onDateRangeSelected: (start, end) {
                  controller.startDate.value = start;
                  controller.endDate.value = end;
                },
              )),
            ),
            const SizedBox(height: 32),
            const TravelDatesInsights(),
          ]
        ],
      ),
    );
  }
}

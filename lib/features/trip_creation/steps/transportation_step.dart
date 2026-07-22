import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/transport_option_card.dart';

class TransportationStep extends GetView<TripWizardController> {
  const TransportationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'How should we get there?',
            style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            'AI estimates are based on current traffic and seasonal schedules for your selected route.',
            style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
          ),
          const SizedBox(height: 40),

          // Options List
          const TransportOptionCard(title: 'Flight', subtitle: 'Estimated 2h 45m', icon: Icons.flight),
          const SizedBox(height: 12),
          const TransportOptionCard(title: 'Train', subtitle: 'Estimated 4h 15m', icon: Icons.train),
          const SizedBox(height: 12),
          const TransportOptionCard(title: 'Bus', subtitle: 'Estimated 6h 30m', icon: Icons.directions_bus),
          const SizedBox(height: 12),
          const TransportOptionCard(title: 'Car Rental', subtitle: 'Estimated 5h 00m', icon: Icons.car_rental),
          const SizedBox(height: 12),
          const TransportOptionCard(title: 'Walking', subtitle: 'Estimated 48h+ (Not Recommended)', icon: Icons.directions_walk),
          const SizedBox(height: 24),
          const TransportOptionCard(title: 'No Preference', subtitle: 'AI will find the best value for you', icon: Icons.shuffle, isDashed: true),
          
          const SizedBox(height: 40),
          
          // AI Recommendation
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: VoyentaColors.primary.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: VoyentaColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.auto_awesome, color: VoyentaColors.onPrimary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Concierge Recommendation', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.primary)),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant),
                          children: const [
                            TextSpan(text: 'Based on your carbon footprint goals and trip duration, the '),
                            TextSpan(text: 'Train', style: TextStyle(fontWeight: FontWeight.bold, color: VoyentaColors.primary)),
                            TextSpan(text: ' offers the best balance of speed and sustainability. It arrives in the city center, saving you time on transfers.'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

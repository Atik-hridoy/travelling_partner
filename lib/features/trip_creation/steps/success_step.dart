import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';

class SuccessStep extends GetView<TripWizardController> {
  const SuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Celebratory State
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: VoyentaColors.primaryContainer,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: VoyentaColors.primary.withValues(alpha:0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                )
              ],
            ),
            child: const Icon(Icons.check, color: VoyentaColors.onPrimaryContainer, size: 64),
          ),
          const SizedBox(height: 32),
          Text(
            'Your Adventure is Ready!',
            style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Your bespoke Kyoto itinerary has been synchronized with the Invisible Concierge. Your journey begins soon.',
            style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),

          // Trip Summary Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerLowest.withValues(alpha:0.8),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withValues(alpha:0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: const DecorationImage(
                      image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBaCkHvPHsOWm_3K1jpzUx1FkAvxm_YmpykzJjE4Q37D55ym2W-bMdWtk3o2nQ58g-Z6agCM88VFkQw2krNW3ldNazFVfLxTkdi_lakbQKZVnB5plYlYkjYO5PRr-A9SKCA7FMOrTeF6hvgHPIA_sPPfLXPEk7yfx8IzqRIrP1iwE0HYPs5vTvJF3T7cmDZ7GNqkRZhbPtOO_96csQnvYpD-5UwaVAn8FGDJhnc8UKLp893dkZUpWQB9bLkQpBbY-SNReyYDnfo3bOm'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha:0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('KYOTO, JAPAN', style: VoyentaTypography.labelCaps.copyWith(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Autumn Zen Exploration', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
                    const SizedBox(height: 4),
                    Text('Oct 12 — Oct 19, 2024', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(color: VoyentaColors.secondaryContainer, shape: BoxShape.circle),
                                child: const Icon(Icons.hotel, color: VoyentaColors.onSecondaryContainer, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stay', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                                  Text('Aman Kyoto', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(color: VoyentaColors.tertiaryContainer, shape: BoxShape.circle),
                                child: const Icon(Icons.restaurant, color: VoyentaColors.onTertiaryContainer, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dining', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                                  Text('14 Curation', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Primary Actions
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Return to dashboard
                Get.offAllNamed('/dashboard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: VoyentaColors.primary,
                foregroundColor: VoyentaColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 4,
              ),
              child: Text('Go to Dashboard', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onPrimary)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: VoyentaColors.onSurfaceVariant),
                  label: Text('Share', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: VoyentaColors.outlineVariant.withValues(alpha:0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, color: VoyentaColors.onSurfaceVariant),
                  label: Text('Offline', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: VoyentaColors.outlineVariant.withValues(alpha:0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import 'timeline_node.dart';

class TripPreviewHero extends StatelessWidget {
  const TripPreviewHero({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: const DecorationImage(
          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCJXCWA84VP8Eyx1T28PedjYLoYoV6vi_y5CeFaEMH32q9mAqtNsQU-yFp7LIYv_que7WO-_fvbbT5xElX9tI_0ZNbTr1qCOt2skuL7I28DgpWHlkV0syJX2-M4DiTodD31f0C4tx27dH8mpoCuMbgP7thjmhDwhBTDrMOiWwgCLlIG48lwoClMDyvhdWGvvni471LV7c4XXXoce-oAjtVXdXq4JVlnlNILZQRU6ZJ7MqHAuWtIFyUK57hdseev1K730iIxwz5gp9Dt'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            right: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('PREVIEW MODE', style: VoyentaTypography.labelCaps.copyWith(color: Colors.white, fontSize: 10)),
                ),
                const SizedBox(height: 16),
                Obx(() => Text(
                  controller.destination.value.isNotEmpty ? '${controller.destination.value} Eternal' : 'Kyoto Eternal', 
                  style: VoyentaTypography.displayLgMobile.copyWith(color: Colors.white)
                )),
                const SizedBox(height: 8),
                Text(
                  'A masterfully curated 7-day journey through the heart of Japanese tradition, optimized for comfort and hidden cultural discoveries.',
                  style: VoyentaTypography.bodyLg.copyWith(color: Colors.white.withValues(alpha: 0.8)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TripPreviewStatsGrid extends StatelessWidget {
  const TripPreviewStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWide = MediaQuery.of(context).size.width > 600;
    return Flex(
      direction: isWide ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: isWide ? 2 : 0,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: VoyentaColors.primaryContainer,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MATCH ACCURACY', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onPrimaryContainer.withValues(alpha: 0.8))),
                      const SizedBox(height: 8),
                      Text('98% Match', style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.onPrimaryContainer, fontSize: 32)),
                      const SizedBox(height: 8),
                      Text(
                        'Perfectly aligned with your preference for slow travel and architectural heritage.',
                        style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onPrimaryContainer.withValues(alpha: 0.9)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: VoyentaColors.onPrimaryContainer, width: 4),
                  ),
                  child: const Icon(Icons.verified, size: 48, color: VoyentaColors.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ),
        if (isWide) const SizedBox(width: 24) else const SizedBox(height: 24),
        Expanded(
          flex: isWide ? 1 : 0,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_today, color: VoyentaColors.primary, size: 28),
                const SizedBox(height: 16),
                Text('DURATION', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text('7 Days', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
                const SizedBox(height: 8),
                Text('Oct 12 — Oct 19', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
              ],
            ),
          ),
        ),
        if (isWide) const SizedBox(width: 24) else const SizedBox(height: 24),
        Expanded(
          flex: isWide ? 1 : 0,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.payments, color: VoyentaColors.primary, size: 28),
                const SizedBox(height: 16),
                Text('BUDGET', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text('Comfort', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
                const SizedBox(height: 8),
                Text('Est. \$3,200 — \$4,500', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TripPreviewLeftContent extends StatelessWidget {
  const TripPreviewLeftContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.stars, color: VoyentaColors.primary),
            const SizedBox(width: 12),
            Text('Trip Highlights', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: VoyentaColors.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.explore, color: VoyentaColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ACTIVITIES', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                          Text('12 Curated Experiences', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: VoyentaColors.tertiaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.diamond, color: VoyentaColors.onTertiaryContainer),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('EXCLUSIVES', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                          Text('4 Hidden Gems', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: const [
              TimelineNode(
                title: 'Day 1: Arrival & Zen Immersion',
                description: 'Check-in at Ritz-Carlton Kyoto followed by a private evening meditation at a 14th-century Zen temple.',
                icon: Icons.flight_land,
                tags: ['Luxury Stay', 'Private Guide'],
              ),
              TimelineNode(
                title: 'Day 4: The Forgotten Valley',
                description: 'A trek to a secluded forest shrine rarely visited by tourists, featuring a private tea ceremony by the waterfall.',
                icon: Icons.auto_awesome,
                isGem: true,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TripPreviewRightContent extends StatelessWidget {
  const TripPreviewRightContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 40,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trip Passport', style: VoyentaTypography.headlineMd),
                  Icon(Icons.qr_code_2, color: VoyentaColors.primary.withValues(alpha: 0.4), size: 32),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PRIMARY DESTINATION', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: VoyentaColors.primary),
                        const SizedBox(width: 12),
                        Obx(() => Text(
                          controller.destination.value.isNotEmpty ? controller.destination.value : 'Kyoto, Japan', 
                          style: VoyentaTypography.bodyLg.copyWith(fontWeight: FontWeight.bold)
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const TripPreviewPassportRow(label: 'Vibe', value: 'Zen & Luxury'),
              const TripPreviewPassportRow(label: 'Pace', value: 'Immersive'),
              const TripPreviewPassportRow(label: 'Travelers', value: '2 Adults'),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.shield, color: VoyentaColors.primary, size: 16),
                  const SizedBox(width: 8),
                  Text('Safety Score: Excellent', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.95,
                  child: Container(
                    decoration: BoxDecoration(
                      color: VoyentaColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: VoyentaColors.primary.withValues(alpha: 0.1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: VoyentaColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.smart_toy, color: VoyentaColors.onPrimaryContainer, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '"I\'ve optimized this route to avoid the midday crowds at Fushimi Inari. You\'ll have 40% more quiet time."',
                  style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant, fontSize: 14),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class TripPreviewPassportRow extends StatelessWidget {
  final String label;
  final String value;

  const TripPreviewPassportRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
          Text(value, style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onSurface)),
        ],
      ),
    );
  }
}

class TripPreviewBottomNav extends StatelessWidget {
  const TripPreviewBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2))),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -10),
            )
          ],
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 600;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isWide)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('ESTIMATED TOTAL', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                        Text('\$3,840.00', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.primary)),
                      ],
                    ),
                  Expanded(
                    flex: isWide ? 0 : 1,
                    child: Row(
                      mainAxisAlignment: isWide ? MainAxisAlignment.end : MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: isWide ? 0 : 1,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: VoyentaColors.primary,
                              side: const BorderSide(color: VoyentaColors.primary),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            child: const Text('Customize Trip'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: isWide ? 0 : 1,
                          child: ElevatedButton(
                            onPressed: () => controller.nextPage(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: VoyentaColors.primary,
                              foregroundColor: VoyentaColors.onPrimary,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              elevation: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Create Trip', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onPrimary)),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

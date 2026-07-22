import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../trip_wizard_controller.dart';
import '../widgets/trip_preview_widgets.dart';

class TripPreviewStep extends GetView<TripWizardController> {
  const TripPreviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 180),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TripPreviewHero(),
                    const SizedBox(height: 24),
                    const TripPreviewStatsGrid(),
                    const SizedBox(height: 32),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 800) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Expanded(flex: 2, child: TripPreviewLeftContent()),
                              SizedBox(width: 32),
                              Expanded(flex: 1, child: TripPreviewRightContent()),
                            ],
                          );
                        }
                        return Column(
                          children: const [
                            TripPreviewLeftContent(),
                            SizedBox(height: 32),
                            TripPreviewRightContent(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const TripPreviewBottomNav(),
      ],
    );
  }
}

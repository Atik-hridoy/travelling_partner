import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/ai_planning_widgets.dart';

class AiPlanningStep extends StatefulWidget {
  const AiPlanningStep({super.key});

  @override
  State<AiPlanningStep> createState() => _AiPlanningStepState();
}

class _AiPlanningStepState extends State<AiPlanningStep> {
  double _progress = 42.0;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _startProgress();
  }
  
  void _startProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_progress < 98) {
        setState(() {
          _progress += (DateTime.now().millisecondsSinceEpoch % 5) * 0.5;
          if (_progress > 98) _progress = 98;
        });
      }
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    
    return Stack(
      children: [
        // Main Content
        Positioned.fill(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Headline
                const SizedBox(height: 16),
                Text(
                  'Nova is creating your trip...',
                  style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.primary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Crafting a bespoke journey tailored to your preferences.',
                  style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Task List
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.08),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      )
                    ],
                  ),
                  child: Column(
                    children: const [
                      AiPlanningTaskItem(label: 'Checking weather forecasts...', icon: Icons.cloud, status: AiTaskStatus.completed),
                      SizedBox(height: 24),
                      AiPlanningTaskItem(label: 'Finding hidden gems...', icon: Icons.explore, status: AiTaskStatus.inProgress),
                      SizedBox(height: 24),
                      AiPlanningTaskItem(label: 'Optimizing routes...', icon: Icons.route, status: AiTaskStatus.pending),
                      SizedBox(height: 24),
                      AiPlanningTaskItem(label: 'Sourcing local dining...', icon: Icons.restaurant, status: AiTaskStatus.pending),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Contextual Tip
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: VoyentaColors.secondaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: VoyentaColors.secondaryContainer),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb, color: VoyentaColors.secondary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSecondaryContainer, fontSize: 14),
                            children: const [
                              TextSpan(text: 'Nova Tip: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: "Pack light! We've noticed your route includes several walkable cobblestone districts in the evening."),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        
        // Bottom Navigation Shell
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 32),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CURRENT STEP', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.primary.withValues(alpha: 0.8))),
                          const SizedBox(height: 4),
                          Text('Curating Experiences', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onSurface)),
                        ],
                      ),
                    ),
                    Text('${_progress.toInt()}%', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Progress Bar
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: VoyentaColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _progress / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: VoyentaColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Footer Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.hourglass_top, size: 16, color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6)),
                        const SizedBox(width: 4),
                        Text('Est. Time: 45s', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6))),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => controller.nextPage(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VoyentaColors.primary,
                        foregroundColor: VoyentaColors.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        elevation: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Skip', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onPrimary)),
                          const SizedBox(width: 8),
                          const Icon(Icons.fast_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

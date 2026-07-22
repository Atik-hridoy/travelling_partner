import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../trip_planner_controller.dart';

class TripItineraryTab extends GetView<TripPlannerController> {
  const TripItineraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDaySelector(),
        const SizedBox(height: 24),
        _buildTimeline(),
      ],
    );
  }

  Widget _buildDaySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
        children: [
          _buildDayButton(1, 'Day 1'),
          _buildDayButton(2, 'Day 2'),
          _buildDayButton(3, 'Day 3'),
          _buildDayButton(4, 'Day 4'),
          _buildDayButton(5, 'Day 5'),
        ],
      )),
    );
  }

  Widget _buildDayButton(int dayIndex, String label) {
    final isSelected = controller.selectedDay.value == dayIndex;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => controller.selectDay(dayIndex),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? VoyentaColors.primary : VoyentaColors.surfaceContainer,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? VoyentaColors.onPrimary : VoyentaColors.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Stack(
      children: [
        // Spine Line
        Positioned(
          top: 0,
          bottom: 0,
          left: 10,
          child: CustomPaint(
            size: const Size(2, double.infinity),
            painter: DottedLinePainter(color: VoyentaColors.outlineVariant),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildActivityCard(
              title: 'Fushimi Inari Shrine',
              time: '08:00 AM — 10:30 AM',
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuD1AOlfoG7XFRiLVfsWjhZ2JVDC0KrS9htdAmTxfCOm4LHq36rI_Ke3INSMHRebhdMpV2WUWWTPGzHchw7qabJqROaSfUBS0i6otWir00KkHUXU_v781UEftUXZY3v8xX6WOB5nXWU02rssaBJMhIjm74jg78fa9kwr0en71h89osNlRS4-oQmymYT8FtQ_4FLM05HydNxJlsTJ2UhvbQSRJpDy8hVeSU9soMrtQC14yDATJioZsotdHSr8b733hBIRDzZDhnlaNS6J',
              isAiOptimized: true,
              tag: 'Sightseeing',
              description:
                  'Hike through thousands of vibrant vermilion torii gates. Early start recommended to avoid the midday crowds and capture the best light.',
              cost: 'Free',
              walking: '3.2 km',
              crowds: 'Low',
              crowdsColor: VoyentaColors.tertiary,
              nodeColor: VoyentaColors.primary,
              hasTip: true,
            ),
            const SizedBox(height: 32),
            _buildActivityCard(
              title: 'Kiyomizu-dera Temple',
              time: '11:30 AM — 01:00 PM',
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuA56sMZvTeHKFO1EIali_KhSRxlhb4SwGnTF04jxtUALm-E6QeRKXwK-d5By-JD9ft7JCTCTXR96U6aCXSsleQq8wWD8zsjx-A-GnHPFPUGWD6wGKBsF_euRglMiCZnh_yPG6xE9InkS4hHb6wAQNbZqCnrTtba6hamqDymJT2EeSPJ-E_NOeYJH6jV2VZYqzxffQNN0PqU7VVEpCT6xGDxSTYwAlRa5W2Lp6TBSKBP6mhQp5ep4PTFSg7iaXBsW8E_FHeAOi9eUj8N',
              isAiOptimized: false,
              tag: 'Cultural Heritage',
              description:
                  'Iconic wooden temple offering sweeping views of the city. We\'ve scheduled this post-lunch to capture the high-angle sun.',
              cost: '¥400',
              walking: '1.8 km',
              crowds: 'High',
              crowdsColor: VoyentaColors.error,
              nodeColor: VoyentaColors.outlineVariant,
              hasTip: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String time,
    required String imageUrl,
    required bool isAiOptimized,
    required String tag,
    required String description,
    required String cost,
    required String walking,
    required String crowds,
    required Color crowdsColor,
    required Color nodeColor,
    required bool hasTip,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Timeline Node
          Positioned(
            left: -27,
            top: 24,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: nodeColor,
                shape: BoxShape.circle,
                border: Border.all(color: VoyentaColors.surface, width: 3),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                ],
              ),
            ),
          ),
          // Content Card
          Container(
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceBright.withOpacity(0.8),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Header
                SizedBox(
                  height: 200,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.darken,
                        color: Colors.black26, // equivalent to the gradient somewhat
                      ),
                      if (isAiOptimized)
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: VoyentaColors.primary.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.auto_awesome, color: VoyentaColors.onPrimary, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  'AI OPTIMIZED',
                                  style: VoyentaTypography.labelCaps.copyWith(
                                    color: VoyentaColors.onPrimary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black87, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                time,
                                style: VoyentaTypography.monoTechnical.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                title,
                                style: VoyentaTypography.headlineMd.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Body
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: VoyentaColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              tag.toUpperCase(),
                              style: VoyentaTypography.labelCaps.copyWith(
                                color: VoyentaColors.primary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.drag_indicator, size: 16, color: VoyentaColors.onSurfaceVariant),
                              const SizedBox(width: 4),
                              Text(
                                'Reorder',
                                style: VoyentaTypography.bodyMd.copyWith(
                                  color: VoyentaColors.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: VoyentaTypography.bodyMd.copyWith(
                          color: VoyentaColors.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Micro Data Grid
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
                            bottom: BorderSide(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _buildMicroData('COST', cost, VoyentaColors.onSurface)),
                            Container(width: 1, height: 40, color: VoyentaColors.outlineVariant.withOpacity(0.2)),
                            Expanded(child: _buildMicroData('WALKING', walking, VoyentaColors.onSurface)),
                            Container(width: 1, height: 40, color: VoyentaColors.outlineVariant.withOpacity(0.2)),
                            Expanded(child: _buildMicroData('CROWDS', crowds, crowdsColor)),
                          ],
                        ),
                      ),
                      if (hasTip) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: VoyentaColors.secondaryContainer.withOpacity(0.3),
                            border: Border.all(color: VoyentaColors.secondaryContainer.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.tips_and_updates, color: VoyentaColors.secondary, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Local Concierge Tip',
                                      style: VoyentaTypography.bodyMd.copyWith(
                                        color: VoyentaColors.secondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'The best matcha soft serve is at the small stall exactly halfway up the mountain path.',
                                      style: VoyentaTypography.bodyMd.copyWith(
                                        color: VoyentaColors.onSecondaryContainer.withOpacity(0.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicroData(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.outline, fontSize: 10),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: VoyentaTypography.bodyMd.copyWith(color: valueColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.round;

    double dashHeight = 4, dashSpace = 4;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width / 2, startY), Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

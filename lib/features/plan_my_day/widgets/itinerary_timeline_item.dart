import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../plan_my_day_controller.dart';

class ItineraryTimelineItem extends StatelessWidget {
  final PlanMyDayItem item;
  final bool isActive;
  final bool isLast;
  final VoidCallback onTap;

  const ItineraryTimelineItem({
    super.key,
    required this.item,
    required this.isActive,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Timeline Spine Line
        if (!isLast)
          Positioned(
            left: 19,
            top: 40,
            bottom: -24,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    VoyentaColors.primary,
                    VoyentaColors.outlineVariant.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),

        // Content Row (Timeline Node + Card)
        Padding(
          padding: const EdgeInsets.only(bottom: 28.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Icon Node
              GestureDetector(
                onTap: onTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: VoyentaColors.primary,
                      width: 2,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: VoyentaColors.primary.withValues(alpha: 0.15),
                              spreadRadius: 4,
                              blurRadius: 8,
                            ),
                            BoxShadow(
                              color: VoyentaColors.primary.withValues(alpha: 0.08),
                              spreadRadius: 8,
                              blurRadius: 16,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Icon(
                    item.icon,
                    size: 18,
                    color: VoyentaColors.primary,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Main Glassmorphic Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: VoyentaColors.outlineVariant.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: VoyentaColors.primary.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Layout: Responsive image top on small screens, side on wider
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 500;
                          final imageWidget = ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              item.imageUrl,
                              width: isWide ? 160 : double.infinity,
                              height: isWide ? 120 : 160,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: isWide ? 160 : double.infinity,
                                  height: isWide ? 120 : 160,
                                  color: VoyentaColors.primaryContainer.withValues(alpha: 0.2),
                                  child: const Icon(Icons.photo, color: VoyentaColors.primary),
                                );
                              },
                            ),
                          );

                          final detailsWidget = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Time Tag & Distance
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.timeTag,
                                    style: VoyentaTypography.labelCaps.copyWith(
                                      color: VoyentaColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  Text(
                                    item.distance,
                                    style: VoyentaTypography.bodyMd.copyWith(
                                      color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Title
                              Text(
                                item.title,
                                style: VoyentaTypography.headlineMd.copyWith(
                                  color: VoyentaColors.onSurface,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Description
                              Text(
                                item.description,
                                style: VoyentaTypography.bodyMd.copyWith(
                                  color: VoyentaColors.onSurfaceVariant,
                                  fontSize: 13,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          );

                          if (isWide) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imageWidget,
                                const SizedBox(width: 16),
                                Expanded(child: detailsWidget),
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imageWidget,
                                const SizedBox(height: 12),
                                detailsWidget,
                              ],
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 14),

                      // Nova Insight Lightbulb Quote Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: VoyentaColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                          border: Border(
                            left: BorderSide(
                              color: VoyentaColors.primary.withValues(alpha: 0.5),
                              width: 4,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.lightbulb_rounded,
                              color: VoyentaColors.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '"${item.novaInsight}"',
                                style: VoyentaTypography.bodyMd.copyWith(
                                  color: VoyentaColors.onSurface,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12.5,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

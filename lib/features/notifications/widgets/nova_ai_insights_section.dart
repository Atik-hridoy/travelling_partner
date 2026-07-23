import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../notifications_controller.dart';

class NovaAiInsightsSection extends GetView<NotificationsController> {
  const NovaAiInsightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'NOVA AI INSIGHTS',
              style: VoyentaTypography.labelCaps.copyWith(
                color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.7),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: VoyentaColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'PROACTIVE',
                style: VoyentaTypography.labelCaps.copyWith(
                  color: VoyentaColors.primary,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Insight Card 1 (Flight Update)
        Obx(() {
          if (controller.isCard1Dismissed.value) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              _buildGlassCard(
                onTap: () => controller.markCard1Read(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: VoyentaColors.voyagerGradient,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: VoyentaColors.voyagerGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: VoyentaColors.primary.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Flight Update • Kyoto',
                                style: VoyentaTypography.bodyMd.copyWith(
                                  color: VoyentaColors.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Obx(() {
                                if (!controller.isCard1Read.value) {
                                  return Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: VoyentaColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                            ],
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: 'Your flight to Kyoto is currently boarding. Nova suggests taking the ',
                              style: VoyentaTypography.bodyMd.copyWith(
                                color: VoyentaColors.onSurfaceVariant,
                                fontSize: 13.5,
                                height: 1.45,
                              ),
                              children: [
                                TextSpan(
                                  text: 'West exit',
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    color: VoyentaColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.5,
                                  ),
                                ),
                                const TextSpan(text: ' for a 15% faster route to the shuttle.'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: VoyentaColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('View Route', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 10),
                              OutlinedButton(
                                onPressed: () => controller.dismissCard1(),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: VoyentaColors.onSurfaceVariant,
                                  side: BorderSide(color: VoyentaColors.outlineVariant.withValues(alpha: 0.5)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Dismiss', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
          );
        }),

        // Insight Card 2 (Weather Alert)
        _buildGlassCard(
          onTap: () => controller.markCard2Read(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 90,
                decoration: BoxDecoration(
                  gradient: VoyentaColors.voyagerGradient,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: VoyentaColors.voyagerGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.cloudy_snowing, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weather Alert • Oia',
                          style: VoyentaTypography.bodyMd.copyWith(
                            color: VoyentaColors.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Obx(() {
                          if (!controller.isCard2Read.value) {
                            return Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: VoyentaColors.primary,
                                shape: BoxShape.circle,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                      ],
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        text: 'Weather alert: Light rain expected in Oia this evening. I\'ve updated your dinner reservation to the ',
                        style: VoyentaTypography.bodyMd.copyWith(
                          color: VoyentaColors.onSurfaceVariant,
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: 'indoor terrace',
                            style: VoyentaTypography.bodyMd.copyWith(
                              color: VoyentaColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.5,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '2 hours ago',
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F378A).withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

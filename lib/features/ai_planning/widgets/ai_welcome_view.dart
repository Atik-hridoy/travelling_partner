import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../ai_planning_controller.dart';

class AiWelcomeView extends StatelessWidget {
  final AiPlanningController controller;

  const AiWelcomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF7F2FF),
                Color(0xFFFDF8FD),
                Color(0xFFEEE8FF),
              ],
            ),
          ),
        ),

        // Decorative floating circles
        Positioned(
          top: Get.height * 0.08,
          left: -60,
          child: _buildDecorCircle(220, VoyentaColors.primaryFixed.withValues(alpha: 0.5)),
        ),
        Positioned(
          top: Get.height * 0.2,
          right: -40,
          child: _buildDecorCircle(160, VoyentaColors.tertiaryFixed.withValues(alpha: 0.4)),
        ),
        Positioned(
          bottom: Get.height * 0.25,
          left: -30,
          child: _buildDecorCircle(120, VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
        ),

        // Main Content
        SafeArea(
          child: Column(
            children: [
              const Spacer(),

              // Nova Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: VoyentaColors.primary.withValues(alpha: 0.15),
                          blurRadius: 40,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 56,
                      color: VoyentaColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Text(
                      "Hi! I'm Nova ✨",
                      textAlign: TextAlign.center,
                      style: VoyentaTypography.headlineLg.copyWith(
                        color: VoyentaColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Tell me where you'd like to go, and I'll build the perfect trip for you.",
                      textAlign: TextAlign.center,
                      style: VoyentaTypography.bodyLg.copyWith(
                        color: VoyentaColors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Destination quick chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildChip('🗾 Japan'),
                    _buildChip('🌴 Bali'),
                    _buildChip('🏔️ Switzerland'),
                    _buildChip('🏖️ Thailand'),
                    _buildChip('🍕 Italy'),
                  ],
                ),
              ),

              const Spacer(),

              // Input bar at the bottom
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: VoyentaColors.primary.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: VoyentaColors.primary.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.textController,
                              style: VoyentaTypography.bodyMd.copyWith(
                                color: VoyentaColors.onSurface,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Where do you want to go?',
                                hintStyle: VoyentaTypography.bodyMd.copyWith(
                                  color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              onSubmitted: (val) {
                                if (val.trim().isNotEmpty) {
                                  controller.sendMessage(val.trim());
                                }
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final text = controller.textController.text.trim();
                              if (text.isNotEmpty) {
                                controller.sendMessage(text);
                              }
                            },
                            child: Container(
                              width: 46,
                              height: 46,
                              decoration: const BoxDecoration(
                                color: VoyentaColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom nav safe area padding
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDecorCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildChip(String label) {
    return GestureDetector(
      onTap: () {
        // Directly send as a message — starts the chat flow immediately
        controller.sendMessage("I want to visit ${label.replaceAll(RegExp(r'[^\x00-\x7F]+'), '').trim()}");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: VoyentaColors.primary.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: VoyentaColors.primary.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: VoyentaTypography.bodyMd.copyWith(
                color: VoyentaColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'ai_planning_controller.dart';
import 'widgets/ai_welcome_view.dart';
import 'widgets/ai_origin_selector.dart';
import 'widgets/ai_date_selector.dart';
import 'widgets/ai_traveler_budget_selector.dart';
import 'widgets/ai_style_selector.dart';

class AiPlanningView extends StatelessWidget {
  const AiPlanningView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AiPlanningController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: VoyentaColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: VoyentaColors.surface.withValues(alpha: 0.7),
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: VoyentaColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Nova',
                        style: VoyentaTypography.headlineLgMobile.copyWith(
                          color: VoyentaColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: VoyentaColors.onSurfaceVariant),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isWelcomeState.value) {
          return AiWelcomeView(controller: controller);
        }
        return Stack(
          children: [
            // Darker background for chat
            Container(color: VoyentaColors.surface),
            
            SizedBox.expand(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 64),
                  
                  // Progress Indicator (reads currentStep.value — tracked by outer Obx)
                  _buildProgressIndicator(controller.currentStep.value),

                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 160),
                        itemCount: controller.messages.length + (controller.isTyping.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == controller.messages.length) {
                            return _buildTypingIndicator();
                          }
                          return _buildChatBubble(controller.messages[index], controller);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Bottom floating area
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInputArea(controller),
                  _buildBottomNavBar(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    if (currentStep < 1) return const SizedBox.shrink();
    int displayStep = currentStep.clamp(1, 4);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text(
            'Step $displayStep of 4 • Journey Setup',
            style: VoyentaTypography.labelSm.copyWith(
              color: VoyentaColors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(4, (index) {
              final isActive = index < displayStep;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < 3 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: isActive ? VoyentaColors.primary : VoyentaColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(AiChatMessage message, AiPlanningController controller) {
    return Column(
      crossAxisAlignment:
          message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!message.isUser)
              Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.only(right: 8, bottom: 16),
                decoration: BoxDecoration(
                  color: VoyentaColors.primaryFixed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.smart_toy, size: 18, color: VoyentaColors.primary),
              ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                constraints: BoxConstraints(maxWidth: Get.width * 0.75),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(message.isUser ? 20 : 4),
                    bottomRight: Radius.circular(message.isUser ? 4 : 20),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? VoyentaColors.primary
                            : Colors.white.withValues(alpha: 0.7),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        boxShadow: [
                          if (!message.isUser)
                            BoxShadow(
                              color: VoyentaColors.primary.withValues(alpha: 0.05),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                        ],
                      ),
                      child: Text(
                        message.text,
                        style: VoyentaTypography.bodyLg.copyWith(
                          color: message.isUser ? Colors.white : VoyentaColors.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!message.isUser && message.interactionType != AiInteractionType.none)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildInteractionWidget(message.interactionType, controller),
          ),
      ],
    );
  }

  Widget _buildInteractionWidget(AiInteractionType type, AiPlanningController controller) {
    switch (type) {
      case AiInteractionType.originSelect:
        return AiOriginSelector(
          onSelected: (val) => controller.handleWidgetInteraction(val),
        );
      case AiInteractionType.dateSelect:
        return AiDateSelector(
          onSelected: (val) => controller.handleWidgetInteraction(val),
        );
      case AiInteractionType.travelerBudget:
        return AiTravelerBudgetSelector(
          onSelected: (val) => controller.handleWidgetInteraction(val),
        );
      case AiInteractionType.styleInterests:
        return AiStyleSelector(
          onSelected: (val) => controller.handleWidgetInteraction(val),
        );
      case AiInteractionType.none:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTypingIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.only(right: 8, bottom: 16),
          decoration: BoxDecoration(
            color: VoyentaColors.primaryFixed,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.smart_toy, size: 18, color: VoyentaColors.primary),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(20),
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDot(),
              const SizedBox(width: 4),
              _buildDot(),
              const SizedBox(width: 4),
              _buildDot(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: VoyentaColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInputArea(AiPlanningController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              border: Border.all(color: VoyentaColors.primary.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: VoyentaColors.primary.withValues(alpha: 0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurface),
                    decoration: InputDecoration(
                      hintText: 'Tell Nova your preferences...',
                      hintStyle: VoyentaTypography.bodyMd.copyWith(
                        color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: controller.sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic, color: VoyentaColors.primary),
                  onPressed: () {
                    // TODO: Trigger waveform animation
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: VoyentaColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    onPressed: () => controller.sendMessage(controller.textController.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: VoyentaColors.surface.withValues(alpha: 0.7),
            border: Border(top: BorderSide(color: VoyentaColors.outlineVariant.withValues(alpha: 0.1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.arrow_back, 'Back', false, () => Get.back()),
              _buildNavItem(Icons.horizontal_rule, 'Progress', false, () {}),
              _buildNavItem(Icons.arrow_forward, 'Next', true, () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isPrimary, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isPrimary ? VoyentaColors.primary : VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: VoyentaTypography.labelSm.copyWith(
              color: isPrimary ? VoyentaColors.primary : VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
              fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

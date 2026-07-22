import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/glass_card.dart';
import '../ai_assistant_controller.dart';

class InputPanel extends StatelessWidget {
  final AIAssistantController controller;

  const InputPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        borderRadius: 28,
        bgOpacity: 0.95,
        borderColor: VoyentaColors.outlineVariant.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.textController,
                style: VoyentaTypography.bodyMd.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Ask Voyanta anything...',
                  hintStyle: VoyentaTypography.bodyMd.copyWith(
                    color: VoyentaColors.onSurfaceVariant.withOpacity(0.5),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (text) => controller.sendMessage(text),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: VoyentaColors.voyagerGradient,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 18),
                onPressed: () => controller.sendMessage(controller.textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

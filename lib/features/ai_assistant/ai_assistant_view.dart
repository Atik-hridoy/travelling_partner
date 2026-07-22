import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import 'ai_assistant_controller.dart';
import 'widgets/ai_assistant_top_app_bar.dart';
import 'widgets/message_row.dart';
import 'widgets/prompt_suggestions.dart';
import 'widgets/input_panel.dart';

class AIAssistantView extends GetView<AIAssistantController> {
  const AIAssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top App Bar
            const AIAssistantTopAppBar(),

            // 2. Chat Feed Area
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return MessageRow(message: message);
                  },
                );
              }),
            ),

            // 3. Floating Prompt suggestions
            PromptSuggestions(controller: controller),

            // 4. Input Text Panel
            InputPanel(controller: controller),
            const SizedBox(height: 100), // Navigation shell buffer
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../ai_assistant_controller.dart';

class PromptSuggestions extends StatelessWidget {
  final AIAssistantController controller;

  const PromptSuggestions({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: controller.suggestions.length,
        itemBuilder: (context, index) {
          final sugg = controller.suggestions[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ActionChip(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: VoyentaColors.outlineVariant.withOpacity(0.5)),
              ),
              label: Text(
                sugg,
                style: VoyentaTypography.bodyMd.copyWith(
                  fontSize: 11,
                  color: VoyentaColors.primary,
                ),
              ),
              onPressed: () => controller.sendSuggestion(sugg),
            ),
          );
        },
      ),
    );
  }
}

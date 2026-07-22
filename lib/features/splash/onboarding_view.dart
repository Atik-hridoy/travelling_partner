import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import 'onboarding_controller.dart';
import 'widgets/welcome_step.dart';
import 'widgets/interests_step.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: controller.currentStep.value == 0
              ? WelcomeStep(controller: controller)
              : InterestsStep(controller: controller),
        );
      }),
    );
  }
}

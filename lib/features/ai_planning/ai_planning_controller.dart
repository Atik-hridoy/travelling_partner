import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../itinerary/trip_planner.dart';
import '../itinerary/trip_planner_controller.dart';

enum AiInteractionType {
  none,
  originSelect,
  dateSelect,
  travelerBudget,
  styleInterests,
}

class AiChatMessage {
  final String text;
  final bool isUser;
  final AiInteractionType interactionType;

  AiChatMessage({
    required this.text,
    required this.isUser,
    this.interactionType = AiInteractionType.none,
  });
}

class AiPlanningController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<AiChatMessage> messages = <AiChatMessage>[].obs;
  final RxBool isTyping = false.obs;
  final RxBool isWelcomeState = true.obs;
  // Public RxInt — view can observe it directly
  final RxInt currentStep = 0.obs;

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    if (isWelcomeState.value) {
      isWelcomeState.value = false;
      currentStep.value = 1;
    }

    messages.add(AiChatMessage(text: text, isUser: true));
    textController.clear();

    _scrollToBottom();
    _handleNextStep();
  }

  void handleWidgetInteraction(String responseText) {
    messages.add(AiChatMessage(text: responseText, isUser: true));
    _scrollToBottom();
    _handleNextStep();
  }

  void _handleNextStep() async {
    isTyping.value = true;
    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 1500));
    isTyping.value = false;

    switch (currentStep.value) {
      case 1:
        messages.add(AiChatMessage(
          text: "Amazing choice! Before we continue... Where will you be traveling from?",
          isUser: false,
          interactionType: AiInteractionType.originSelect,
        ));
        currentStep.value++;
        break;
      case 2:
        messages.add(AiChatMessage(
          text: "Got it! When are you planning to go?",
          isUser: false,
          interactionType: AiInteractionType.dateSelect,
        ));
        currentStep.value++;
        break;
      case 3:
        messages.add(AiChatMessage(
          text: "Who is coming along on this adventure, and what's your budget style?",
          isUser: false,
          interactionType: AiInteractionType.travelerBudget,
        ));
        currentStep.value++;
        break;
      case 4:
        messages.add(AiChatMessage(
          text: "Almost done! What kind of vibes and interests are you looking for?",
          isUser: false,
          interactionType: AiInteractionType.styleInterests,
        ));
        currentStep.value++;
        break;
      default:
        messages.add(AiChatMessage(
          text: "I'm putting together an incredible itinerary for you! I'll generate a fully planned trip dashboard in just a moment...",
          isUser: false,
        ));

        Future.delayed(const Duration(seconds: 2), () {
          Get.put(TripPlannerController());
          Get.off(() => const TripPlanner(), transition: Transition.fadeIn);
        });
        break;
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

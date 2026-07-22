import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/mock/mock_data.dart';

class TimelineStop {
  final String time;
  final String category;
  final String title;
  final String desc;
  final String imgUrl;
  final String? rating;
  final IconData icon;

  TimelineStop({
    required this.time,
    required this.category,
    required this.title,
    required this.desc,
    required this.imgUrl,
    this.rating,
    required this.icon,
  });
}

class MessageModel {
  final String text;
  final bool isUser;
  final DateTime time;
  final String? title;
  final List<TimelineStop>? timelineStops;

  MessageModel({
    required this.text,
    required this.isUser,
    required this.time,
    this.title,
    this.timelineStops,
  });
}

class AIAssistantController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  var messages = <MessageModel>[].obs;
  final List<String> suggestions = MockData.aiSuggestions;

  @override
  void onInit() {
    super.onInit();
    messages.assignAll(MockData.getAiAssistantInitialMessages());
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    messages.add(
      MessageModel(
        text: text,
        isUser: true,
        time: DateTime.now(),
      ),
    );
    textController.clear();
    _scrollToBottom();

    // Trigger mock AI response
    Future.delayed(const Duration(milliseconds: 1500), () {
      _mockResponse(text);
    });
  }

  void sendSuggestion(String suggestion) {
    sendMessage(suggestion);
  }

  void _mockResponse(String userText) {
    String reply = "Analyzing your request... ";
    final query = userText.toLowerCase();
    
    if (query.contains('crowd') || query.contains('optimize')) {
      reply = "Crowd prediction models show low density at Shisendo Temple right now. I have optimized your itinerary: visiting Shisendo Temple first, then Kyoto Craft Coffee.";
    } else if (query.contains('safety') || query.contains('scam')) {
      reply = "Safety ratings for Kyoto Station remain Excellent (87/100). Be cautious of unregistered private taxi operations around the east gates.";
    } else if (query.contains('cafe')) {
      reply = "I found 'Kissa Kojo' located 150m from your current position. It is highly rated (9.8 index) and very quiet right now.";
    } else {
      reply = "I've logged your request for Kyoto. Let me know if you would like me to adjust your timeline nodes or pull up safety metrics.";
    }

    messages.add(
      MessageModel(
        text: reply,
        isUser: false,
        time: DateTime.now(),
      ),
    );
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

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

import 'package:get/get.dart';
import '../../features/ai_assistant/ai_assistant_controller.dart';

class AIAssistantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AIAssistantController>(() => AIAssistantController());
  }
}

import 'package:get/get.dart';
import '../../features/safety/safety_controller.dart';

class SafetyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SafetyController>(() => SafetyController());
  }
}

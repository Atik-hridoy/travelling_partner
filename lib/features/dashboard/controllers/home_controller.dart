import 'package:get/get.dart';

class HomeController extends GetxController {
  var isFlightExpanded = false.obs;
  var notificationCount = 2.obs;

  void toggleFlightExpansion() {
    isFlightExpanded.value = !isFlightExpanded.value;
  }
}

import 'dart:async';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startNavigationTimer();
  }

  void _startNavigationTimer() {
    Timer(const Duration(milliseconds: 2500), () {
      Get.offNamed('/onboarding');
    });
  }
}

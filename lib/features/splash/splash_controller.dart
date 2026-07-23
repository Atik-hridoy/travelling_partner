import 'dart:async';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_logger.dart';
import '../auth/auth_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _startNavigationTimer();
  }

  void _startNavigationTimer() {
    Timer(const Duration(milliseconds: 2200), () {
      final user = AuthService.currentUser;

      if (user != null) {
        AppLogger.success(
          'Active session detected for UID: "${user.uid}". Bypassing Sign In -> Dashboard.',
          tag: 'AUTO_LOGIN',
        );
        Get.offNamed(AppRoutes.DASHBOARD);
      } else {
        AppLogger.info(
          'No active session found. Navigating to Onboarding.',
          tag: 'SESSION_CHECK',
        );
        Get.offNamed(AppRoutes.ONBOARDING);
      }
    });
  }
}

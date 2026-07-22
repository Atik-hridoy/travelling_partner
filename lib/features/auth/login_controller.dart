import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/colors.dart';
import 'auth_service.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Sign in existing user via Firebase Authentication
  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      _showError('Invalid Email', 'Please enter a valid email address.');
      return;
    }

    if (password.isEmpty) {
      _showError('Password Required', 'Please enter your password.');
      return;
    }

    try {
      isLoading.value = true;

      // 1. Firebase Sign In
      await AuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      isLoading.value = false;

      // 2. Navigate to Dashboard
      Get.offAllNamed(AppRoutes.DASHBOARD);
      Get.snackbar(
        'Welcome Back! 👋',
        'Logged in successfully!',
        backgroundColor: VoyentaColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    } catch (e) {
      isLoading.value = false;
      _showError('Sign In Failed', e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim());
    }
  }

  void signInWithGoogle() {
    Get.offAllNamed(AppRoutes.DASHBOARD);
  }

  void signInWithApple() {
    Get.offAllNamed(AppRoutes.DASHBOARD);
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: VoyentaColors.rose,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

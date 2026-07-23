import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_logger.dart';
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

    AppLogger.info('User tapped Sign In button.', tag: 'UI_ACTION');

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
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = e.message ?? e.toString();
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'Incorrect email or password. Please check your credentials.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Email/Password sign-in is not enabled in Firebase Console -> Authentication -> Sign-in method.';
      }
      _showError('Sign In Failed (${e.code})', message);
    } catch (e) {
      isLoading.value = false;
      _showError('Sign In Error', e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim());
    }
  }

  void signInWithGoogle() {
    Get.offAllNamed(AppRoutes.DASHBOARD);
  }

  void signInWithApple() {
    Get.offAllNamed(AppRoutes.DASHBOARD);
  }

  void _showError(String title, String message) {
    AppLogger.error(title, message);
    Get.snackbar(
      title,
      message,
      backgroundColor: VoyentaColors.rose,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
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

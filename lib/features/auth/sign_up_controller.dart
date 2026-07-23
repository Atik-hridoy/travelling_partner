import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_logger.dart';
import '../../core/theme/colors.dart';
import 'auth_service.dart';

class SignUpController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var isTermsAccepted = false.obs;
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void toggleTerms(bool? val) {
    isTermsAccepted.value = val ?? false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Traceable Create Account Action with console logs & error diagnostics
  Future<void> createAccount() async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    AppLogger.info('User tapped Create Account button.', tag: 'UI_ACTION');

    if (name.isEmpty) {
      _showError('Full Name Required', 'Please enter your full name.');
      return;
    }

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      _showError('Invalid Email', 'Please enter a valid email address.');
      return;
    }

    if (password.length < 6) {
      _showError('Weak Password', 'Password must be at least 6 characters long.');
      return;
    }

    if (!isTermsAccepted.value) {
      _showError('Terms Required', 'Please accept the Terms of Service to continue.');
      return;
    }

    try {
      isLoading.value = true;

      // Call AuthService
      await AuthService.signUpWithEmailAndPassword(
        fullName: name,
        email: email,
        password: password,
      );

      isLoading.value = false;

      // Navigate to Dashboard
      Get.offAllNamed(AppRoutes.DASHBOARD);
      Get.snackbar(
        'Welcome to Voyanta! 🎉',
        'Account created and profile saved in Firebase!',
        backgroundColor: VoyentaColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = e.message ?? e.toString();
      if (e.code == 'operation-not-allowed') {
        message = 'Email/Password sign-in is not enabled in Firebase Console -> Authentication -> Sign-in method.';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already registered. Please sign in instead.';
      }
      _showError('Sign Up Failed (${e.code})', message);
    } catch (e) {
      isLoading.value = false;
      _showError('Sign Up Error', e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim());
    }
  }

  void signUpWithGoogle() {
    createAccount();
  }

  void signUpWithApple() {
    createAccount();
  }

  void _showError(String title, String message) {
    AppLogger.error(title, message);
    Get.snackbar(
      title,
      message,
      backgroundColor: VoyentaColors.rose,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

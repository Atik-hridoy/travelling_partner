import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
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

  /// Create user in Firebase Authentication and save details to Cloud Firestore
  Future<void> createAccount() async {
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

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

      // 1. Sign up user via Firebase Auth & save to Firestore
      await AuthService.signUpWithEmailAndPassword(
        fullName: name,
        email: email,
        password: password,
      );

      isLoading.value = false;

      // 2. Navigate to Dashboard
      Get.offAllNamed(AppRoutes.DASHBOARD);
      Get.snackbar(
        'Welcome to Voyanta! 🎉',
        'Account created successfully in Firebase!',
        backgroundColor: VoyentaColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    } catch (e) {
      isLoading.value = false;
      _showError('Sign Up Failed', e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim());
    }
  }

  void signUpWithGoogle() {
    createAccount();
  }

  void signUpWithApple() {
    createAccount();
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
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

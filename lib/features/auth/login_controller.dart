import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/colors.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController(text: 'julian.d@voyanta.io');
    passwordController = TextEditingController(text: '••••••••');
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signIn() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 800), () {
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.DASHBOARD);
      Get.snackbar(
        'Welcome Back!',
        'Logged in successfully as ${emailController.text}',
        backgroundColor: VoyentaColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    });
  }

  void signInWithGoogle() {
    signIn();
  }

  void signInWithApple() {
    signIn();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

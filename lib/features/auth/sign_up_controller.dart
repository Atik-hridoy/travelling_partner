import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/colors.dart';

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

  void createAccount() {
    if (!isTermsAccepted.value) {
      Get.snackbar(
        'Terms & Conditions',
        'Please agree to the Terms of Service to continue.',
        backgroundColor: VoyentaColors.rose,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
      return;
    }

    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 800), () {
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.DASHBOARD);
      Get.snackbar(
        'Account Created!',
        'Welcome to Voyanta, ${fullNameController.text.isNotEmpty ? fullNameController.text : "Explorer"}!',
        backgroundColor: VoyentaColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    });
  }

  void signUpWithGoogle() {
    createAccount();
  }

  void signUpWithApple() {
    createAccount();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

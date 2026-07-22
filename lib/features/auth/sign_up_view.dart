import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<SignUpController>()
        ? Get.find<SignUpController>()
        : Get.put(SignUpController());

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FF),
      body: Stack(
        children: [
          // 1. Atmospheric Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFDF7FF),
                    Color(0xFFF2ECF4),
                    Color(0xFFE1D4FD),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // Floating Ambient Orbs
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VoyentaColors.primary.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: -140,
            left: -100,
            child: Container(
              width: 420,
              height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VoyentaColors.tertiary.withValues(alpha: 0.15),
              ),
            ),
          ),

          // Backdrop Blur Layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: const SizedBox.expand(),
            ),
          ),

          // 2. Main Scrollable Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Brand Mark
                      Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: VoyentaColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: VoyentaColors.primary.withValues(alpha: 0.25),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.explore_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'VOYANTA',
                            style: VoyentaTypography.labelCaps.copyWith(
                              color: VoyentaColors.primary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3.0,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Glass Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                          child: Container(
                            padding: const EdgeInsets.all(28.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.72),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4F378A).withValues(alpha: 0.08),
                                  blurRadius: 40,
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title Header
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Create Your Journey',
                                        textAlign: TextAlign.center,
                                        style: VoyentaTypography.displayLgMobile.copyWith(
                                          color: VoyentaColors.onSurface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Your personalized AI travel concierge awaits.',
                                        textAlign: TextAlign.center,
                                        style: VoyentaTypography.bodyMd.copyWith(
                                          color: VoyentaColors.onSurfaceVariant,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // Input Fields
                                _buildInputPill(
                                  icon: Icons.person_outline_rounded,
                                  hintText: 'Full Name',
                                  controller: controller.fullNameController,
                                ),

                                const SizedBox(height: 14),

                                _buildInputPill(
                                  icon: Icons.mail_outline_rounded,
                                  hintText: 'Email Address',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller.emailController,
                                ),

                                const SizedBox(height: 14),

                                Obx(
                                  () => _buildInputPill(
                                    icon: Icons.lock_outline_rounded,
                                    hintText: 'Password',
                                    obscureText: !controller.isPasswordVisible.value,
                                    controller: controller.passwordController,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility_rounded
                                            : Icons.visibility_off_rounded,
                                        color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                                        size: 20,
                                      ),
                                      onPressed: controller.togglePasswordVisibility,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 18),

                                // Terms & Conditions Checkbox
                                Row(
                                  children: [
                                    Obx(
                                      () => SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          value: controller.isTermsAccepted.value,
                                          onChanged: controller.toggleTerms,
                                          activeColor: VoyentaColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'I agree to the ',
                                          style: VoyentaTypography.bodyMd.copyWith(
                                            color: VoyentaColors.onSurfaceVariant,
                                            fontSize: 13,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Terms of Service',
                                              style: VoyentaTypography.bodyMd.copyWith(
                                                color: VoyentaColors.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // Create Account Action Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: Obx(
                                    () => ElevatedButton(
                                      onPressed: controller.isLoading.value
                                          ? null
                                          : controller.createAccount,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: VoyentaColors.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 6,
                                        shadowColor: VoyentaColors.primary.withValues(alpha: 0.3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: controller.isLoading.value
                                          ? const SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Create Account',
                                                  style: VoyentaTypography.bodyMd.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: VoyentaColors.outlineVariant.withValues(alpha: 0.4),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Text(
                                        'OR CONTINUE WITH',
                                        style: VoyentaTypography.labelCaps.copyWith(
                                          color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.5),
                                          fontSize: 9,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: VoyentaColors.outlineVariant.withValues(alpha: 0.4),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // Social Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildSocialButton(
                                        label: 'Google',
                                        icon: Icons.g_mobiledata_rounded,
                                        onTap: controller.signUpWithGoogle,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildSocialButton(
                                        label: 'Apple',
                                        icon: Icons.apple_rounded,
                                        onTap: controller.signUpWithApple,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Footer Sign In Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: VoyentaTypography.bodyMd.copyWith(
                              color: VoyentaColors.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Text(
                              'Sign In',
                              style: VoyentaTypography.bodyMd.copyWith(
                                color: VoyentaColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputPill({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: VoyentaColors.outlineVariant.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.7), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: VoyentaTypography.bodyMd.copyWith(
                color: VoyentaColors.onSurface,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.45),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          ?suffixIcon,
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: VoyentaColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: VoyentaColors.onSurface),
            const SizedBox(width: 8),
            Text(
              label,
              style: VoyentaTypography.bodyMd.copyWith(
                color: VoyentaColors.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

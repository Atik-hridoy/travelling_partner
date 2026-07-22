import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<LoginController>()
        ? Get.find<LoginController>()
        : Get.put(LoginController());

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FF),
      body: Stack(
        children: [
          // 1. Ambient Gradient Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE9DDFF),
                    Color(0xFFFDF7FF),
                    Color(0xFFFFDF93),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // Ambient Blur Blobs
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VoyentaColors.primary.withValues(alpha: 0.15),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -50,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VoyentaColors.tertiary.withValues(alpha: 0.18),
              ),
            ),
          ),

          // Backdrop Blur Layer for ambient elements
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: const SizedBox.expand(),
            ),
          ),

          // 2. Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Header Logo Area
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: VoyentaColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: VoyentaColors.primary.withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.explore_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'VOYANTA',
                            style: VoyentaTypography.displayLgMobile.copyWith(
                              color: VoyentaColors.primary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Glass Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            padding: const EdgeInsets.all(28.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.72),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1F1635).withValues(alpha: 0.08),
                                  blurRadius: 36,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Headline
                                Text(
                                  'Welcome Back',
                                  style: VoyentaTypography.displayLgMobile.copyWith(
                                    color: VoyentaColors.onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Your journey continues here.',
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    color: VoyentaColors.onSurfaceVariant,
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // Form Fields
                                _buildFieldLabel('EMAIL ADDRESS'),
                                const SizedBox(height: 6),
                                _buildTextField(
                                  controller: controller.emailController,
                                  hintText: 'name@luxury.com',
                                  keyboardType: TextInputType.emailAddress,
                                ),

                                const SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildFieldLabel('PASSWORD'),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: VoyentaTypography.bodyMd.copyWith(
                                          color: VoyentaColors.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Obx(
                                  () => _buildTextField(
                                    controller: controller.passwordController,
                                    hintText: '••••••••',
                                    obscureText: !controller.isPasswordVisible.value,
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

                                const SizedBox(height: 24),

                                // Sign In Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: Obx(
                                    () => ElevatedButton(
                                      onPressed: controller.isLoading.value
                                          ? null
                                          : controller.signIn,
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
                                          : Text(
                                              'Sign In',
                                              style: VoyentaTypography.bodyMd.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
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
                                        onTap: controller.signInWithGoogle,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: _buildSocialButton(
                                        label: 'Apple',
                                        icon: Icons.apple_rounded,
                                        onTap: controller.signInWithApple,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Footer Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: VoyentaTypography.bodyMd.copyWith(
                              color: VoyentaColors.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: controller.signIn,
                            child: Text(
                              'Sign Up',
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

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: VoyentaTypography.labelCaps.copyWith(
        color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.8),
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: VoyentaColors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
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
            color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.4),
            fontSize: 14,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
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
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(18),
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

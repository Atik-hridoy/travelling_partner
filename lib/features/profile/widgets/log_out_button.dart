import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../auth/auth_service.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: VoyentaColors.errorContainer.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: () async {
            await AuthService.signOut();
            Get.offAllNamed(AppRoutes.LOGIN);
            Get.snackbar(
              'Signed Out',
              'You have been logged out safely.',
              backgroundColor: VoyentaColors.primary,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(16),
              borderRadius: 16,
            );
          },
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: VoyentaColors.error, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Log Out',
                  style: VoyentaTypography.bodyMd.copyWith(
                    color: VoyentaColors.error,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class DangerZoneSection extends StatelessWidget {
  final VoidCallback? onSignOut;
  final VoidCallback? onDeleteAccount;

  const DangerZoneSection({
    super.key,
    this.onSignOut,
    this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: TextButton(
            onPressed: onSignOut ?? () => Get.back(),
            style: TextButton.styleFrom(
              foregroundColor: VoyentaColors.rose,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Sign Out',
              style: VoyentaTypography.bodyMd.copyWith(
                color: VoyentaColors.rose,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: onDeleteAccount ?? () {},
            child: Text(
              'DELETE ACCOUNT',
              style: VoyentaTypography.labelCaps.copyWith(
                color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.4),
                fontSize: 10,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

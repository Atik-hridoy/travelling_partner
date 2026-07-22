import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'edit_profile_controller.dart';
import 'widgets/edit_photo_header.dart';
import 'widgets/edit_form_fields.dart';
import 'widgets/travel_style_selector.dart';
import 'widgets/account_info_section.dart';
import 'widgets/danger_zone_section.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<EditProfileController>()
        ? Get.find<EditProfileController>()
        : Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      appBar: AppBar(
        backgroundColor: VoyentaColors.surface.withValues(alpha: 0.8),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                foregroundColor: VoyentaColors.primary,
              ),
              child: Text(
                'Cancel',
                style: VoyentaTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.w600,
                  color: VoyentaColors.primary,
                ),
              ),
            ),
            Text(
              'Edit Profile',
              style: VoyentaTypography.headlineMd.copyWith(
                color: VoyentaColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ElevatedButton(
              onPressed: controller.saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: VoyentaColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo Header
            EditPhotoHeader(
              imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
              onChangePhoto: () {},
            ),

            const SizedBox(height: 32),

            // Form Fields
            EditFormFields(
              nameController: controller.nameController,
              bioController: controller.bioController,
              locationController: controller.locationController,
              websiteController: controller.websiteController,
            ),

            const SizedBox(height: 32),

            // Travel Style Preferences
            Obx(
              () => TravelStyleSelector(
                allStyles: controller.allStyles,
                selectedStyles: controller.selectedStyles,
                onToggleStyle: controller.toggleStyle,
              ),
            ),

            const SizedBox(height: 36),

            // Account Info Card
            const AccountInfoSection(),

            const SizedBox(height: 40),

            // Danger Zone (Sign Out / Delete)
            const DangerZoneSection(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import 'profile_controller.dart';

class EditProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController locationController;
  late TextEditingController websiteController;

  final selectedStyles = <String>{'Minimalist', 'Luxury'}.obs;
  final allStyles = ['Minimalist', 'Luxury', 'Hidden Gems', 'Architecture'].obs;

  @override
  void onInit() {
    super.onInit();
    final profileCtrl = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    final user = profileCtrl.user.value;

    nameController = TextEditingController(text: (user['name'] as String?) ?? 'Julian D.');
    bioController = TextEditingController(text: (user['bio'] as String?) ?? 'Curating the Unseen');
    locationController = TextEditingController(text: (user['location'] as String?) ?? 'Zurich, Switzerland');
    websiteController = TextEditingController(text: (user['website'] as String?) ?? 'voyanta.travel/julian_d');
  }

  void toggleStyle(String style) {
    if (selectedStyles.contains(style)) {
      selectedStyles.remove(style);
    } else {
      selectedStyles.add(style);
    }
  }

  void saveProfile() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().updateUserProfile(
        name: nameController.text,
        bio: bioController.text,
        location: locationController.text,
        website: websiteController.text,
      );
    }

    Get.back();
    Get.snackbar(
      'Profile Saved',
      'Your profile changes have been updated successfully.',
      backgroundColor: VoyentaColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    locationController.dispose();
    websiteController.dispose();
    super.onClose();
  }
}

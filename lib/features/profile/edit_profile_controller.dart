import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/location_weather_service.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../auth/auth_service.dart';
import 'profile_controller.dart';

class EditProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController locationController;
  late TextEditingController websiteController;

  final isDetectingLocation = false.obs;
  final selectedImagePath = ''.obs;

  final selectedStyles = <String>{}.obs;
  final allStyles = ['Minimalist', 'Luxury', 'Hidden Gems', 'Architecture'].obs;

  final ImagePicker _picker = ImagePicker();

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

    // Load saved travel styles dynamically
    if (user['travelStyles'] != null) {
      final List<dynamic> saved = user['travelStyles'];
      selectedStyles.addAll(saved.map((s) => s.toString()));
    } else {
      selectedStyles.addAll({'Minimalist', 'Luxury'});
    }
  }

  void showPhotoSourcePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Profile Photo',
              style: VoyentaTypography.headlineMd.copyWith(
                color: VoyentaColors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: VoyentaColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.photo_library_rounded, color: VoyentaColors.primary),
              ),
              title: const Text('Choose from Gallery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: VoyentaColors.tertiary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt_rounded, color: VoyentaColors.tertiary),
              ),
              title: const Text('Take Photo with Camera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (file != null) {
        selectedImagePath.value = file.path;
        Get.snackbar(
          'Photo Selected 📸',
          'New profile image ready to save.',
          backgroundColor: VoyentaColors.primary,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 16,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Permission Notice',
        'Could not access gallery/camera. Grant media permission in device settings.',
        backgroundColor: VoyentaColors.tertiary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    }
  }

  Future<void> detectCurrentLocation() async {
    isDetectingLocation.value = true;
    try {
      final data = await LocationWeatherService.fetchLiveWeatherAndLocation();
      locationController.text = data.locationName;

      Get.snackbar(
        'Location Detected 📍',
        'Updated to ${data.locationName}',
        backgroundColor: VoyentaColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    } catch (e) {
      Get.snackbar(
        'Location Notice',
        'Could not fetch live GPS. You can type manually.',
        backgroundColor: VoyentaColors.tertiary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    } finally {
      isDetectingLocation.value = false;
    }
  }

  void toggleStyle(String style) {
    if (selectedStyles.contains(style)) {
      selectedStyles.remove(style);
    } else {
      selectedStyles.add(style);
    }
  }

  void saveProfile() {
    final uid = AuthService.currentUser?.uid ?? 'julian_d';

    if (Get.isRegistered<ProfileController>()) {
      final profileCtrl = Get.find<ProfileController>();
      
      profileCtrl.updateUserProfile(
        name: nameController.text,
        bio: bioController.text,
        location: locationController.text,
        website: websiteController.text,
        avatar: selectedImagePath.value,
        travelStyles: selectedStyles.toList(),
      );
    }

    Get.back();
    Get.snackbar(
      'Firestore Saved 🔥',
      'Location: /users/$uid\nUpdated profile successfully sync’d!',
      backgroundColor: VoyentaColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
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

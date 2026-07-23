import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';

class NotificationsController extends GetxController {
  var isCard1Dismissed = false.obs;
  var isCard1Read = false.obs;
  var isCard2Read = false.obs;
  var isTrip1Read = false.obs;

  void markCard1Read() {
    isCard1Read.value = true;
  }

  void dismissCard1() {
    isCard1Dismissed.value = true;
  }

  void markCard2Read() {
    isCard2Read.value = true;
  }

  void markTrip1Read() {
    isTrip1Read.value = true;
  }

  void clearAll() {
    isCard1Read.value = true;
    isCard2Read.value = true;
    isTrip1Read.value = true;

    Get.snackbar(
      'Cleared All',
      'All notifications marked as read.',
      backgroundColor: VoyentaColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }
}

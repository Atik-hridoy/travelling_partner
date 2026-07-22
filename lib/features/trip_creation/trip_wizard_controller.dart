import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/places_service.dart';

class TripWizardController extends GetxController {
  final pageController = PageController();
  final searchController = TextEditingController();
  final currentPage = 0.obs;
  
  // State variables for the wizard (will be populated as user completes steps)
  final destination = ''.obs;
  final placeSuggestions = <String>[].obs;
  final _placesService = PlacesService();
  final startDate = Rx<DateTime?>(null);
  final endDate = Rx<DateTime?>(null);
  final adults = 1.obs;
  final children = 0.obs;
  final budget = ''.obs;
  final budgetLevel = 1.obs;
  final transportation = <String>[].obs;
  final travelStyle = ''.obs;
  final accommodation = ''.obs;
  final interests = <String>[].obs;
  final specialRequirements = ''.obs;

  void nextPage() {
    if (currentPage.value < 11) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back();
    }
  }

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (currentPage.value != page) {
        currentPage.value = page;
      }
    });

    debounce(destination, (String query) async {
      if (query.length > 2) {
        placeSuggestions.value = await _placesService.getAutocomplete(query);
      } else {
        placeSuggestions.clear();
      }
    }, time: const Duration(milliseconds: 500));
  }

  void selectSuggestion(String suggestion) {
    searchController.text = suggestion;
    destination.value = suggestion;
    placeSuggestions.clear();
  }

  @override
  void onClose() {
    searchController.dispose();
    pageController.dispose();
    super.onClose();
  }
}

import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';

class OnboardingController extends GetxController {
  var currentStep = 0.obs;
  var selectedInterests = <String>[].obs;

  final List<String> interestsList = [
    'Culinary Arts',
    'Historical Heritage',
    'Nature & Parks',
    'Local Nightlife',
    'Wellness & Spas',
    'Modern Architecture',
    'Local Crafts',
    'Hidden Cafes'
  ];

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  void nextStep() {
    if (currentStep.value == 0) {
      currentStep.value = 1;
    } else {
      // Done with step 2 (interests_step), navigate to Login view
      Get.toNamed(AppRoutes.LOGIN);
    }
  }

  void prevStep() {
    if (currentStep.value == 1) {
      currentStep.value = 0;
    }
  }
}

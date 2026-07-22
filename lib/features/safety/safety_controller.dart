import 'package:get/get.dart';

class SafetyController extends GetxController {
  var activeCategory = 'All'.obs;

  final List<String> categories = ['All', 'Scam Alerts', 'Safety Scores', 'Emergency'];

  void setCategory(String category) {
    activeCategory.value = category;
  }
}

import 'package:get/get.dart';

class TripPlannerController extends GetxController {
  var selectedDay = 1.obs;
  var selectedTab = 0.obs;

  void selectDay(int day) {
    selectedDay.value = day;
  }

  void selectTab(int index) {
    selectedTab.value = index;
  }
}

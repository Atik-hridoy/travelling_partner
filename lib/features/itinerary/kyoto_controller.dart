import 'package:get/get.dart';

class KyotoDetailsController extends GetxController {
  var selectedSpot = ''.obs;

  void selectSpot(String name) {
    selectedSpot.value = name;
  }
}

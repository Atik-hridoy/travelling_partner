import 'package:get/get.dart';

class MapController extends GetxController {
  var selectedMarker = ''.obs;
  var isPanelExpanded = false.obs;

  void selectMarker(String name) {
    selectedMarker.value = name;
    isPanelExpanded.value = true;
  }

  void clearSelection() {
    selectedMarker.value = '';
    isPanelExpanded.value = false;
  }
}

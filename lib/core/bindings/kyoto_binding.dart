import 'package:get/get.dart';
import '../../features/itinerary/kyoto_controller.dart';

class KyotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KyotoDetailsController>(() => KyotoDetailsController());
  }
}

import 'package:get/get.dart';
import 'plan_my_day_controller.dart';

class PlanMyDayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanMyDayController>(() => PlanMyDayController());
  }
}

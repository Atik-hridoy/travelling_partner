import 'package:get/get.dart';
import '../../features/dashboard/controllers/dashboard_controller.dart';
import '../../features/dashboard/controllers/home_controller.dart';
import '../../features/map/map_controller.dart';
import '../../features/community/community_controller.dart';
import '../../features/itinerary/trip_planner_controller.dart';
import '../../features/notifications/notifications_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<CommunityController>(() => CommunityController());
    Get.lazyPut<TripPlannerController>(() => TripPlannerController());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}

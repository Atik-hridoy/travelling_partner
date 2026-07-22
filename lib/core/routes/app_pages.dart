import 'package:get/get.dart';
import '../../features/splash/splash_view.dart';
import '../../features/splash/onboarding_view.dart';
import '../../features/dashboard/dashboard_shell.dart';
import '../../features/itinerary/kyoto_details.dart';
import '../../features/itinerary/shisendo_details.dart';
import '../../features/itinerary/trip_planner.dart';
import '../../features/dashboard/place_details/place_details_view.dart';
import '../../features/dashboard/search/search_view.dart';
import '../../features/ai_assistant/ai_assistant_view.dart';
import '../../features/safety/safety_hub.dart';
import '../bindings/splash_binding.dart';
import '../bindings/onboarding_binding.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/ai_assistant_binding.dart';
import '../bindings/safety_binding.dart';
import '../bindings/kyoto_binding.dart';
import '../../features/plan_my_day/plan_my_day_view.dart';
import '../../features/plan_my_day/plan_my_day_binding.dart';
import '../../features/profile/edit_profile_view.dart';
import '../../features/auth/login_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardShell(),
      binding: DashboardBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.KYOTO_DETAILS,
      page: () => const KyotoDetails(),
      binding: KyotoBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.TRIP_PLANNER,
      page: () => const TripPlanner(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.PLACE_DETAILS,
      page: () => const PlaceDetailsView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.AI_ASSISTANT,
      page: () => const AIAssistantView(),
      binding: AIAssistantBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.SAFETY_HUB,
      page: () => const SafetyHub(),
      binding: SafetyBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.SHISENDO_DETAILS,
      page: () => const ShisendoDetails(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.PLAN_MY_DAY,
      page: () => const PlanMyDayView(),
      binding: PlanMyDayBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => const EditProfileView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}

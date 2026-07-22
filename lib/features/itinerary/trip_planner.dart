import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'trip_details_view.dart';
import 'trip_planner_controller.dart';

class TripPlanner extends GetView<TripPlannerController> {
  const TripPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const TripDetailsView();
  }
}

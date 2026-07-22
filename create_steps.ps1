$steps = @(
    "destination_step", "travel_dates_step", "travelers_step", 
    "budget_step", "transportation_step", "travel_style_step", 
    "accommodation_step", "interests_step", "special_requirements_step", 
    "ai_planning_step", "trip_preview_step", "success_step"
)

$classNames = @(
    "DestinationStep", "TravelDatesStep", "TravelersStep",
    "BudgetStep", "TransportationStep", "TravelStyleStep",
    "AccommodationStep", "InterestsStep", "SpecialRequirementsStep",
    "AiPlanningStep", "TripPreviewStep", "SuccessStep"
)

New-Item -ItemType Directory -Force -Path "lib\features\trip_creation\steps"

for ($i = 0; $i -lt $steps.Length; $i++) {
    $step = $steps[$i]
    $className = $classNames[$i]
    $content = @"
import 'package:flutter/material.dart';

class $className extends StatelessWidget {
  const $className({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('$className Placeholder'),
    );
  }
}
"@
    Set-Content -Path "lib\features\trip_creation\steps\$step.dart" -Value $content
}

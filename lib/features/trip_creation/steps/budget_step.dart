import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../trip_wizard_controller.dart';
import '../widgets/budget_step_widgets.dart';

class BudgetStep extends GetView<TripWizardController> {
  const BudgetStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BudgetHeader(),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(child: BudgetLeftColumn()),
                    SizedBox(width: 32),
                    Expanded(child: BudgetRightColumn()),
                  ],
                );
              }
              return Column(
                children: const [
                  BudgetLeftColumn(),
                  SizedBox(height: 32),
                  BudgetRightColumn(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

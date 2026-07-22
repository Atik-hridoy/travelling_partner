import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';

// Constants used in Budget Step
const budgetLevels = ['Budget', 'Comfort', 'Luxury', 'Ultra'];
const budgetPrices = ['\$150 - \$250', '\$350 - \$600', '\$800 - \$1,500', '\$2,000+'];
const budgetStayIcons = [Icons.hotel, Icons.hotel, Icons.diamond, Icons.workspace_premium];
const budgetStayTypes = ['Hostel / 3★', 'Boutique 4★', 'Luxury 5★', 'Exclusive'];
const budgetTransitIcons = [Icons.directions_bus, Icons.directions_car, Icons.local_taxi, Icons.flight];
const budgetTransitTypes = ['Public Transit', 'Private Rides', 'Black Car', 'Helicopter'];
const budgetTotals = ['\$200', '\$550', '\$1200', '\$2500'];
const budgetAcc = ['\$80.00', '\$247.50', '\$600.00', '\$1250.00'];
const budgetDin = ['\$60.00', '\$137.50', '\$300.00', '\$625.00'];
const budgetAct = ['\$40.00', '\$110.00', '\$200.00', '\$375.00'];
const budgetTrans = ['\$20.00', '\$55.00', '\$100.00', '\$250.00'];

class BudgetHeader extends StatelessWidget {
  const BudgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: VoyentaColors.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: VoyentaColors.primaryContainer.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome, color: VoyentaColors.primary, size: 16),
              const SizedBox(width: 8),
              Text(
                'AI Recommendation: Comfort Level',
                style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Set your pace & spend.',
          style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.onSurface),
        ),
        const SizedBox(height: 16),
        Text(
          'Our Invisible Concierge tailors activities to your preferred style. Higher budgets unlock exclusive after-hours access and premium transfers.',
          style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class BudgetLeftColumn extends StatelessWidget {
  const BudgetLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SELECTED LEVEL', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Text(budgetLevels[controller.budgetLevel.value], style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.primary)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('EST. DAILY', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Text(budgetPrices[controller.budgetLevel.value], style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
                    ],
                  ),
                ],
              )),
              const SizedBox(height: 32),
              
              Obx(() => SliderTheme(
                data: SliderThemeData(
                  trackHeight: 8,
                  activeTrackColor: VoyentaColors.primary,
                  inactiveTrackColor: VoyentaColors.surfaceContainerHighest,
                  thumbColor: VoyentaColors.primary,
                  overlayColor: VoyentaColors.primary.withValues(alpha: 0.2),
                  valueIndicatorColor: VoyentaColors.primary,
                  showValueIndicator: ShowValueIndicator.onDrag,
                ),
                child: Slider(
                  value: controller.budgetLevel.value.toDouble(),
                  min: 0,
                  max: 3,
                  divisions: 3,
                  onChanged: (val) {
                    controller.budgetLevel.value = val.toInt();
                  },
                ),
              )),
              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  BudgetSliderLabel(top: 'Budget', bottom: '\$150+'),
                  BudgetSliderLabel(top: 'Comfort', bottom: '\$350+'),
                  BudgetSliderLabel(top: 'Luxury', bottom: '\$800+'),
                  BudgetSliderLabel(top: 'Ultra', bottom: '\$2k+'),
                ],
              ),
              const SizedBox(height: 32),

              Obx(() {
                int level = controller.budgetLevel.value;
                return Row(
                  children: [
                    Expanded(
                      child: BudgetInfoCard(tag: 'STAY', title: budgetStayTypes[level], icon: budgetStayIcons[level]),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BudgetInfoCard(tag: 'TRANSIT', title: budgetTransitTypes[level], icon: budgetTransitIcons[level]),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(child: BudgetActionBtn(icon: Icons.currency_exchange, text: 'Currency: USD')),
            const SizedBox(width: 16),
            Expanded(child: BudgetActionBtn(icon: Icons.receipt_long, text: 'Tax Settings')),
          ],
        )
      ],
    );
  }
}

class BudgetRightColumn extends StatelessWidget {
  const BudgetRightColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TripWizardController>();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.pie_chart, color: VoyentaColors.primary),
                  const SizedBox(width: 8),
                  Text('Daily Allocation', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface)),
                ],
              ),
              const SizedBox(height: 32),
              
              Center(
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: CustomPaint(
                          painter: BudgetPieChartPainter(0.45, 0.25, 0.20, 0.10),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('TOTAL', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant)),
                          Obx(() => Text(budgetTotals[controller.budgetLevel.value], style: VoyentaTypography.headlineMd.copyWith(fontSize: 24, fontWeight: FontWeight.bold))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              Obx(() {
                int level = controller.budgetLevel.value;
                return Column(
                  children: [
                    BudgetBreakdownRow(label: 'Accommodation', value: budgetAcc[level], color: VoyentaColors.primary),
                    const SizedBox(height: 12),
                    BudgetBreakdownRow(label: 'Dining', value: budgetDin[level], color: VoyentaColors.tertiary),
                    const SizedBox(height: 12),
                    BudgetBreakdownRow(label: 'Activities', value: budgetAct[level], color: VoyentaColors.secondary),
                    const SizedBox(height: 12),
                    BudgetBreakdownRow(label: 'Transport', value: budgetTrans[level], color: VoyentaColors.outlineVariant),
                  ],
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: VoyentaColors.tertiaryContainer.withValues(alpha: 0.2), 
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lightbulb, color: VoyentaColors.tertiary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Save up to 15%', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onTertiaryContainer)),
                    const SizedBox(height: 4),
                    Text(
                      'Booking your dining through our AI platform secures early-bird rates at top-rated bistros.',
                      style: VoyentaTypography.bodyMd.copyWith(fontSize: 14, color: VoyentaColors.onTertiaryContainer),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BudgetSliderLabel extends StatelessWidget {
  final String top;
  final String bottom;

  const BudgetSliderLabel({super.key, required this.top, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(top, style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant, fontSize: 10)),
        const SizedBox(height: 4),
        Text(bottom, style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.outline, fontSize: 10)),
      ],
    );
  }
}

class BudgetInfoCard extends StatelessWidget {
  final String tag;
  final String title;
  final IconData icon;

  const BudgetInfoCard({super.key, required this.tag, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: VoyentaColors.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tag, style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.secondary, fontSize: 10)),
                const SizedBox(height: 2),
                Text(title, style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, fontSize: 13, color: VoyentaColors.onSurface)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BudgetActionBtn extends StatelessWidget {
  final IconData icon;
  final String text;

  const BudgetActionBtn({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: VoyentaColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.w600)),
          ),
          const Icon(Icons.chevron_right, color: VoyentaColors.outline),
        ],
      ),
    );
  }
}

class BudgetBreakdownRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const BudgetBreakdownRow({super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(label, style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant, fontSize: 14)),
          ],
        ),
        Text(value, style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurface, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}

class BudgetPieChartPainter extends CustomPainter {
  final double accommodation;
  final double dining;
  final double activities;
  final double transport;

  BudgetPieChartPainter(this.accommodation, this.dining, this.activities, this.transport);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.butt;
    
    paint.color = VoyentaColors.surfaceContainerHigh;
    canvas.drawCircle(rect.center, rect.width / 2, paint);

    double startAngle = -3.14159 / 2;

    void drawSegment(double percentage, Color color) {
      if (percentage <= 0) return;
      final sweepAngle = 2 * 3.14159 * percentage;
      paint.color = color;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }

    drawSegment(accommodation, VoyentaColors.primary);
    drawSegment(dining, VoyentaColors.tertiary);
    drawSegment(activities, VoyentaColors.secondary);
    drawSegment(transport, VoyentaColors.outlineVariant);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

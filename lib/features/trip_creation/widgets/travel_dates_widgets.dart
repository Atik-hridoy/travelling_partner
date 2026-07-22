import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class TravelDatesInsights extends StatelessWidget {
  const TravelDatesInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceContainerHigh.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.wb_sunny, color: VoyentaColors.primary),
                  const SizedBox(width: 8),
                  Text('Seasonal Outlook', style: VoyentaTypography.headlineMd),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Avg. Temperature',
                            style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
                        const Text('22°C / 14°C', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    const Icon(Icons.thermostat, color: VoyentaColors.tertiary, size: 32),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Precipitation',
                            style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
                        const Text('Low (15%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    const Icon(Icons.water_drop, color: Colors.blue, size: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: VoyentaColors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.stars, color: VoyentaColors.onPrimary),
                  const SizedBox(width: 8),
                  Text('KYOTO EVENT ALERT', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onPrimary)),
                ],
              ),
              const SizedBox(height: 12),
              Text('Jidai Matsuri', style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onPrimary)),
              const SizedBox(height: 8),
              Text(
                'The Festival of Ages takes place on October 22nd. Expect grand processions and limited access to some palace grounds.',
                style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onPrimary.withValues(alpha: 0.8)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VoyentaColors.onPrimary,
                    foregroundColor: VoyentaColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View Logistics'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FunctionalCalendar extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime?, DateTime?) onDateRangeSelected;

  const FunctionalCalendar({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onDateRangeSelected,
  });

  @override
  State<FunctionalCalendar> createState() => _FunctionalCalendarState();
}

class _FunctionalCalendarState extends State<FunctionalCalendar> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.startDate != null
        ? DateTime(widget.startDate!.year, widget.startDate!.month)
        : DateTime(DateTime.now().year, DateTime.now().month);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _onDaySelected(DateTime date) {
    if (widget.startDate == null) {
      widget.onDateRangeSelected(date, null);
    } else if (widget.endDate == null) {
      if (date.isBefore(widget.startDate!)) {
        widget.onDateRangeSelected(date, null);
      } else {
        widget.onDateRangeSelected(widget.startDate, date);
      }
    } else {
      widget.onDateRangeSelected(date, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    int firstDayOffset = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7;
    int totalItems = daysInMonth + firstDayOffset;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MMMM yyyy').format(_currentMonth),
              style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface),
            ),
            Row(
              children: [
                IconButton(onPressed: _previousMonth, icon: const Icon(Icons.chevron_left)),
                IconButton(onPressed: _nextMonth, icon: const Icon(Icons.chevron_right)),
              ],
            )
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
              .map((d) => Expanded(
                    child: Text(
                      d,
                      textAlign: TextAlign.center,
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
            mainAxisSpacing: 8,
          ),
          itemCount: totalItems,
          itemBuilder: (context, index) {
            if (index < firstDayOffset) return const SizedBox.shrink();
            
            int day = index - firstDayOffset + 1;
            DateTime currentDate = DateTime(_currentMonth.year, _currentMonth.month, day);
            
            bool isStart = widget.startDate != null && DateUtils.isSameDay(widget.startDate, currentDate);
            bool isEnd = widget.endDate != null && DateUtils.isSameDay(widget.endDate, currentDate);
            bool isMid = widget.startDate != null && widget.endDate != null &&
                currentDate.isAfter(widget.startDate!) && currentDate.isBefore(widget.endDate!);
            bool isSelected = isStart || isMid || isEnd;

            bool hasFestival = currentDate.month == 10 && day == 15;
            bool hasRain = currentDate.month == 10 && day == 17;

            return GestureDetector(
              onTap: () => _onDaySelected(currentDate),
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  color: isMid ? VoyentaColors.primaryContainer.withValues(alpha: 0.3) : Colors.transparent,
                  borderRadius: isStart && isEnd
                      ? BorderRadius.circular(24)
                      : isStart
                          ? const BorderRadius.horizontal(left: Radius.circular(24))
                          : (isEnd ? const BorderRadius.horizontal(right: Radius.circular(24)) : BorderRadius.zero),
                ),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (isStart || isEnd) ? VoyentaColors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '$day',
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: (isStart || isEnd)
                                ? VoyentaColors.onPrimary
                                : (isSelected ? VoyentaColors.primary : VoyentaColors.onSurfaceVariant),
                          ),
                        ),
                        if (hasFestival)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(Icons.celebration, size: 10, color: VoyentaColors.tertiary),
                          ),
                        if (hasRain)
                          const Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(Icons.water_drop, size: 10, color: Colors.blue),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/custom_button.dart';

class AiDateSelector extends StatefulWidget {
  final Function(String) onSelected;

  const AiDateSelector({super.key, required this.onSelected});

  @override
  State<AiDateSelector> createState() => _AiDateSelectorState();
}

class _AiDateSelectorState extends State<AiDateSelector> {
  int? selectedStartDate;
  int? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: VoyentaColors.primary.withValues(alpha: 0.05),
                    blurRadius: 40,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'October 2024',
                              style: VoyentaTypography.titleMd.copyWith(
                                color: VoyentaColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chevron_left, color: VoyentaColors.onSurfaceVariant),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chevron_right, color: VoyentaColors.onSurfaceVariant),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Day headers
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU']
                              .map((day) => Expanded(
                                    child: Text(
                                      day,
                                      textAlign: TextAlign.center,
                                      style: VoyentaTypography.labelSm.copyWith(
                                        color: VoyentaColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 8),
                        // Calendar Grid (Mocked for visual)
                        GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 0,
                          ),
                          itemCount: 31,
                          itemBuilder: (context, index) {
                            final day = index + 1;
                            final isSelected = day == selectedStartDate || day == selectedEndDate;
                            final isInRange = selectedStartDate != null &&
                                selectedEndDate != null &&
                                day > selectedStartDate! &&
                                day < selectedEndDate!;
                            final isEvent = day == 22; // Jidai Matsuri
          
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedStartDate == null || (selectedStartDate != null && selectedEndDate != null)) {
                                    selectedStartDate = day;
                                    selectedEndDate = null;
                                  } else {
                                    if (day > selectedStartDate!) {
                                      selectedEndDate = day;
                                    } else {
                                      selectedStartDate = day;
                                    }
                                  }
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: isInRange && day != selectedStartDate ? 0 : 4,
                                  right: isInRange && day != selectedEndDate ? 0 : 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? VoyentaColors.primary
                                      : isInRange
                                          ? VoyentaColors.primaryFixed
                                          : isEvent
                                              ? VoyentaColors.tertiaryFixed
                                              : Colors.transparent,
                                  borderRadius: isSelected
                                      ? BorderRadius.circular(12)
                                      : isInRange
                                          ? BorderRadius.zero
                                          : BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      day.toString(),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : isInRange || isEvent
                                                ? VoyentaColors.primary
                                                : VoyentaColors.onSurface,
                                        fontWeight: isSelected || isInRange || isEvent
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    if (isEvent)
                                      Positioned(
                                        top: 2,
                                        right: 2,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: VoyentaColors.error,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 1.5),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Dynamic Info Pane
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: VoyentaColors.surfaceContainerHigh.withValues(alpha: 0.5),
                      border: Border(top: BorderSide(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2))),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.1)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.forest, color: VoyentaColors.primary, size: 16),
                                        const SizedBox(width: 4),
                                        Text('SEASON', style: VoyentaTypography.labelSm.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Autumn (Best Time)', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.1)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.group, color: VoyentaColors.secondary, size: 16),
                                        const SizedBox(width: 4),
                                        Text('CROWDS', style: VoyentaTypography.labelSm.copyWith(color: VoyentaColors.secondary, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('High Level', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: VoyentaColors.tertiaryContainer.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: VoyentaColors.tertiaryContainer.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                 padding: const EdgeInsets.only(top: 2.0, right: 8.0),
                                 child: Icon(Icons.event, color: VoyentaColors.tertiaryContainer, size: 20),
                               ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kyoto Jidai Matsuri', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.tertiaryContainer, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 2),
                                    Text('Festival of the Ages happens on Oct 22. Expect parades and high street activity!', style: VoyentaTypography.labelSm.copyWith(color: VoyentaColors.tertiaryContainer.withValues(alpha: 0.8))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: 'Confirm Dates',
                          onPressed: () {
                            if (selectedStartDate != null && selectedEndDate != null) {
                              widget.onSelected("Oct $selectedStartDate - Oct $selectedEndDate");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Quick Selection Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildQuickChip('Flexible Dates'),
              _buildQuickChip('Weekend Trip'),
              _buildQuickChip('1 Week'),
              _buildQuickChip('2 Weeks'),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuickChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        label: Text(label),
        labelStyle: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.w500),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: VoyentaColors.primary),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        onPressed: () => widget.onSelected(label),
      ),
    );
  }
}

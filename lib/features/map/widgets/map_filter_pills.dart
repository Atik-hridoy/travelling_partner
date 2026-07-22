import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class MapFilterPills extends StatelessWidget {
  final List<Map<String, dynamic>> filterPills;

  const MapFilterPills({super.key, required this.filterPills});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      left: 0,
      right: 0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: VoyentaColors.surface.withOpacity(0.4),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white.withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: filterPills.asMap().entries.map((entry) {
                  final index = entry.key;
                  final pill = entry.value;
                  final label = pill['label'] as String;
                  final icon = pill['icon'] as IconData;
                  final isSelected = index == 0;

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: index < filterPills.length - 1 ? 4 : 0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? VoyentaColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: VoyentaColors.primary.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: 16,
                            color: isSelected ? Colors.white : VoyentaColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            label,
                            style: VoyentaTypography.labelCaps.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : VoyentaColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SettingsList extends StatelessWidget {
  final List<Map<String, dynamic>> settings;

  const SettingsList({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: settings.asMap().entries.map((entry) {
          final index = entry.key;
          final setting = entry.value;
          final colorKey = setting['color'] as String;

          Color iconBgColor;
          Color iconColor;
          if (colorKey == 'tertiary') {
            iconBgColor = const Color(0xFFE7C365).withOpacity(0.2);
            iconColor = VoyentaColors.tertiary;
          } else if (colorKey == 'primary') {
            iconBgColor = const Color(0xFFCFBCFF).withOpacity(0.2);
            iconColor = VoyentaColors.primary;
          } else {
            iconBgColor = VoyentaColors.secondaryContainer.withOpacity(0.3);
            iconColor = VoyentaColors.secondary;
          }

          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: index == 0
                      ? const BorderRadius.vertical(top: Radius.circular(28))
                      : index == settings.length - 1
                          ? const BorderRadius.vertical(bottom: Radius.circular(28))
                          : BorderRadius.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(setting['icon'] as IconData, color: iconColor, size: 20),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            setting['title'] as String,
                            style: VoyentaTypography.bodyLg.copyWith(
                              fontWeight: FontWeight.w500,
                              color: VoyentaColors.onSurface,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: VoyentaColors.onSurfaceVariant, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              if (index < settings.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    height: 1,
                    color: VoyentaColors.outlineVariant.withOpacity(0.15),
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

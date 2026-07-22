import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class TimelineNode extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<String> tags;
  final bool isGem;
  final bool isLast;

  const TimelineNode({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.tags = const [],
    this.isGem = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned(
                    top: 40,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: VoyentaColors.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isGem ? VoyentaColors.tertiaryContainer : VoyentaColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(color: (isGem ? VoyentaColors.tertiaryContainer : VoyentaColors.primary).withValues(alpha: 0.3), blurRadius: 8),
                    ],
                  ),
                  child: Icon(icon, color: isGem ? VoyentaColors.onTertiaryContainer : Colors.white, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: VoyentaTypography.headlineMd.copyWith(fontSize: 20, color: VoyentaColors.onSurface)),
                  const SizedBox(height: 8),
                  if (isGem) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: VoyentaColors.tertiaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.workspace_premium, size: 12, color: VoyentaColors.onTertiaryContainer),
                          const SizedBox(width: 4),
                          Text('HIDDEN GEM', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onTertiaryContainer, fontSize: 10)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Text(description, style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant)),
                  if (tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: VoyentaColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(tag, style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
                      )).toList(),
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

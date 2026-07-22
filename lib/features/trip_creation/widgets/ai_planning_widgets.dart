import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

enum AiTaskStatus {
  completed,
  inProgress,
  pending,
}

class AiPlanningTaskItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final AiTaskStatus status;

  const AiPlanningTaskItem({
    super.key,
    required this.label,
    required this.icon,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool isPending = status == AiTaskStatus.pending;
    return Opacity(
      opacity: isPending ? 0.4 : 1.0,
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isPending ? VoyentaColors.surfaceContainerHigh : VoyentaColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPending ? VoyentaColors.onSurfaceVariant : VoyentaColors.onPrimaryContainer,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: VoyentaTypography.bodyMd.copyWith(
                color: isPending ? VoyentaColors.onSurfaceVariant : VoyentaColors.onSurface,
              ),
            ),
          ),
          if (status == AiTaskStatus.completed)
            const Icon(Icons.check_circle, color: VoyentaColors.primary, size: 24)
          else if (status == AiTaskStatus.inProgress)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: VoyentaColors.primary),
            )
          else
            const Icon(Icons.pending, color: VoyentaColors.onSurfaceVariant, size: 24),
        ],
      ),
    );
  }
}

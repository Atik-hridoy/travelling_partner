import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class TravelerCounter extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final RxInt count;

  const TravelerCounter({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: VoyentaColors.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: VoyentaColors.onSurfaceVariant),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: VoyentaTypography.headlineMd.copyWith(fontSize: 18)),
                    Text(subtitle, style: VoyentaTypography.bodyMd.copyWith(fontSize: 14, color: VoyentaColors.outline)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (count.value > 0) count.value--;
              },
              icon: const Icon(Icons.remove),
              style: IconButton.styleFrom(
                side: const BorderSide(color: VoyentaColors.outlineVariant),
              ),
            ),
            const SizedBox(width: 16),
            Obx(() => Text('${count.value}', style: VoyentaTypography.headlineMd)),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () => count.value++,
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                side: const BorderSide(color: VoyentaColors.primary),
                foregroundColor: VoyentaColors.primary,
              ),
            ),
          ],
        )
      ],
    );
  }
}

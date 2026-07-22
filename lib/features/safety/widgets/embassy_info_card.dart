import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class EmbassyInfoCard extends StatelessWidget {
  const EmbassyInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_outlined, color: VoyentaColors.secondary, size: 22),
              const SizedBox(width: 8),
              Text(
                'Embassy Information',
                style: VoyentaTypography.bodyLg.copyWith(
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.primary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'OFFICE OF RESIDENCE',
            style: VoyentaTypography.labelCaps.copyWith(
              color: VoyentaColors.onSurfaceVariant.withOpacity(0.6),
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Embassy of the United States',
            style: VoyentaTypography.bodyMd.copyWith(
              fontWeight: FontWeight.bold,
              color: VoyentaColors.onSurface,
            ),
          ),
          Text(
            '1-10-5 Akasaka, Minato-ku, Tokyo 107-8420',
            style: VoyentaTypography.bodyMd.copyWith(
              color: VoyentaColors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: VoyentaColors.outlineVariant),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '24/7 HELPLINE',
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withOpacity(0.6),
                      fontSize: 8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+81 3-3224-5000',
                    style: VoyentaTypography.monoTechnical.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: VoyentaColors.primary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoyentaColors.primaryContainer.withOpacity(0.12),
                ),
                child: const Icon(Icons.phone, color: VoyentaColors.primary, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

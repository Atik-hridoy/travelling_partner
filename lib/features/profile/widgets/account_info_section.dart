import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Information',
          style: VoyentaTypography.headlineMd.copyWith(
            color: VoyentaColors.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: VoyentaColors.outlineVariant.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              _buildAccountInfoTile(
                icon: Icons.mail_outline_rounded,
                label: 'EMAIL',
                value: 'julian.d@voyanta.io',
              ),
              Divider(height: 1, color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
              _buildAccountInfoTile(
                icon: Icons.call_outlined,
                label: 'PHONE',
                value: '+41 44 123 45 67',
              ),
              Divider(height: 1, color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: VoyentaColors.secondaryContainer.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.share_outlined, color: VoyentaColors.secondary, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CONNECTED ACCOUNTS',
                              style: VoyentaTypography.labelCaps.copyWith(
                                color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                                fontSize: 9,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                _buildAccountBadge('Google', Icons.g_mobiledata_rounded),
                                const SizedBox(width: 10),
                                _buildAccountBadge('Apple', Icons.apple_rounded),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.add_circle_outline, color: VoyentaColors.onSurfaceVariant, size: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountInfoTile({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: VoyentaColors.secondaryContainer.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: VoyentaColors.secondary, size: 20),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6),
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: VoyentaTypography.bodyMd.copyWith(
                      color: VoyentaColors.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.chevron_right_rounded, color: VoyentaColors.onSurfaceVariant, size: 20),
        ],
      ),
    );
  }

  Widget _buildAccountBadge(String name, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: VoyentaColors.onSurface),
        const SizedBox(width: 4),
        Text(
          name,
          style: VoyentaTypography.bodyMd.copyWith(
            color: VoyentaColors.onSurface,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

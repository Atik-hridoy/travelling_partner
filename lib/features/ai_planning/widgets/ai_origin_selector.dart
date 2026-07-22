import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import 'location_permission_modal.dart';

class AiOriginSelector extends StatelessWidget {
  final Function(String) onSelected;

  const AiOriginSelector({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildCard(
                icon: Icons.my_location,
                title: 'Current Location',
                subtitle: 'Use GPS detection',
                onTap: () {
                  // Trigger Location Permission Modal
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (_) => LocationPermissionModal(
                      onAllow: () {
                        Get.back();
                        onSelected('Use GPS detection');
                      },
                      onDecline: () {
                        Get.back();
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCard(
                icon: Icons.home,
                title: 'Choose Home City',
                subtitle: 'Search manually',
                onTap: () => onSelected('Search manually for my home city'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCard(
                icon: Icons.flight_land,
                title: "I'm Already There",
                subtitle: 'Skip travel details',
                onTap: () => onSelected("I'm already there!"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildSuggestedChip('London, UK'),
            _buildSuggestedChip('New York, USA'),
          ],
        )
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              boxShadow: [
                BoxShadow(
                  color: VoyentaColors.primary.withValues(alpha: 0.05),
                  blurRadius: 40,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: VoyentaColors.primaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: VoyentaColors.primary, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: VoyentaTypography.titleMd.copyWith(
                    color: VoyentaColors.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: VoyentaTypography.labelSm.copyWith(
                    color: VoyentaColors.onSurfaceVariant,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedChip(String label) {
    return ActionChip(
      label: Text(label),
      labelStyle: VoyentaTypography.labelSm.copyWith(color: VoyentaColors.primary),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: VoyentaColors.primary),
      ),
      onPressed: () => onSelected(label),
    );
  }
}

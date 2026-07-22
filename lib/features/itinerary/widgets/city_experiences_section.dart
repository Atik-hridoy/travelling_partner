import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class CityExperiencesSection extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isWide;

  const CityExperiencesSection({super.key, required this.data, required this.isWide});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> list = data['experiences'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Signature Experiences',
                  style: VoyentaTypography.displayLgMobile.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: VoyentaColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Handpicked by our AI curators for a refined Kyoto stay.',
                  style: TextStyle(
                    color: VoyentaColors.onSurfaceVariant,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
            Text(
              'VIEW ALL',
              style: VoyentaTypography.labelCaps.copyWith(
                fontSize: 9,
                color: VoyentaColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        isWide
            ? Row(
                children: list.map((item) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: _buildExperienceCard(item),
                    ),
                  );
                }).toList(),
              )
            : Column(
                children: list.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildExperienceCard(item),
                  );
                }).toList(),
              ),
      ],
    );
  }

  Widget _buildExperienceCard(dynamic item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              item['img'] as String,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: VoyentaColors.surfaceContainerHigh,
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: VoyentaColors.outline, size: 28),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          item['title'] as String,
          style: VoyentaTypography.headlineMd.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: VoyentaColors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          item['desc'] as String,
          style: VoyentaTypography.bodyMd.copyWith(
            color: VoyentaColors.onSurfaceVariant,
            fontSize: 11.5,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

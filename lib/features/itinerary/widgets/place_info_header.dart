import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class PlaceInfoHeader extends StatelessWidget {
  final Map<String, dynamic> data;

  const PlaceInfoHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> tags = data['tags'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: VoyentaColors.tertiary, size: 16),
              const SizedBox(width: 4),
              Text(
                data['rating'] as String,
                style: const TextStyle(
                  color: VoyentaColors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${data['reviewsCount']})',
                style: const TextStyle(
                  color: VoyentaColors.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data['title'] as String,
            style: VoyentaTypography.displayLgMobile.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: VoyentaColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data['desc'] as String,
            style: VoyentaTypography.bodyMd.copyWith(
              color: VoyentaColors.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: tags.map((tag) {
              return Container(
                margin: const EdgeInsets.only(right: 6.0),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: VoyentaColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag as String,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.onSecondaryContainer,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class MapAppBarHeader extends StatelessWidget {
  const MapAppBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: VoyentaColors.surface.withOpacity(0.6),
              border: Border(
                bottom: BorderSide(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: VoyentaColors.primary, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Voyanta',
                      style: VoyentaTypography.headlineMd.copyWith(
                        fontWeight: FontWeight.w800,
                        color: VoyentaColors.primary,
                        fontSize: 22,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                // Glass search button
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: VoyentaColors.surface.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
                      ),
                      child: const Center(
                        child: Icon(Icons.search, color: VoyentaColors.onSurfaceVariant, size: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class PlaceBottomActionBar extends StatelessWidget {
  const PlaceBottomActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            VoyentaColors.background.withOpacity(0),
            VoyentaColors.background.withOpacity(0.95),
            VoyentaColors.background,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                // Navigate action
              },
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: VoyentaColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.navigation, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Navigate',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                // Save action
              },
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.5)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: VoyentaColors.primary, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'Save',
                      style: TextStyle(
                        color: VoyentaColors.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              // Share action
            },
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.5)),
              ),
              child: const Center(
                child: Icon(Icons.share, color: VoyentaColors.primary, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

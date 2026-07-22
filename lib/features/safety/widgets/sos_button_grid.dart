import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class SosButtonGrid extends StatelessWidget {
  const SosButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Call Emergency (Red)
        Expanded(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: VoyentaColors.rose,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: VoyentaColors.rose.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call, color: Colors.white, size: 28),
                SizedBox(height: 8),
                Text(
                  'Call Emergency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Find Nearest Hospital (White)
        Expanded(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.5)),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_hospital, color: VoyentaColors.primary, size: 28),
                SizedBox(height: 8),
                Text(
                  'Find Hospital',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: VoyentaColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Contact Police (White)
        Expanded(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.5)),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_police, color: VoyentaColors.secondary, size: 28),
                SizedBox(height: 8),
                Text(
                  'Contact Police',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: VoyentaColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class ConciergeCard extends StatelessWidget {
  final Map<String, dynamic> place;

  const ConciergeCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoyentaColors.primary,
                ),
                child: const Center(
                  child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place['conciergeTitle'],
                      style: VoyentaTypography.headlineMd.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: VoyentaColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      place['conciergeDesc'],
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: VoyentaColors.onSurfaceVariant,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class AIAssistantTopAppBar extends StatelessWidget {
  const AIAssistantTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: VoyentaColors.outlineVariant.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
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
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: VoyentaColors.onSurfaceVariant),
                onPressed: () {},
              ),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoyentaColors.primaryContainer,
                ),
                child: const Center(
                  child: Text(
                    'JD',
                    style: TextStyle(
                      color: VoyentaColors.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

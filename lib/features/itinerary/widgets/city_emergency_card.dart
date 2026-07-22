import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class CityEmergencyCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CityEmergencyCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> contacts = data['emergencyContacts'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VoyentaColors.errorContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: VoyentaColors.error.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.emergency, color: VoyentaColors.error, size: 20),
              const SizedBox(width: 8),
              Text(
                'Emergency',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...contacts.map((contact) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (contact['label'] as String).toUpperCase(),
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: VoyentaColors.onErrorContainer.withOpacity(0.8),
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    contact['value'] as String,
                    style: const TextStyle(
                      color: VoyentaColors.onErrorContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Trigger emergency call logic
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: VoyentaColors.error,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Text(
                  'CALL EMERGENCY SERVICES',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class PlaceCrowdPredictionCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PlaceCrowdPredictionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> crowd = data['crowdPrediction'];
    final List<dynamic> chartVals = crowd['chartValues'];
    final List<dynamic> chartLabels = crowd['chartLabels'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VoyentaColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics, color: Colors.white70, size: 18),
              const SizedBox(width: 6),
              Text(
                'CROWD PREDICTION',
                style: VoyentaTypography.labelCaps.copyWith(
                  color: Colors.white70,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            crowd['level'] as String,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            crowd['wait'] as String,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          // Chart Mock
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: chartVals.map((val) {
              final double heightPct = val as double;
              final isMiddle = heightPct == 0.2; // Highlight the 12:00 quiet hour

              return Expanded(
                child: Container(
                  height: 60 * heightPct,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    color: isMiddle ? Colors.white : Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                chartLabels[0] as String,
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 8),
              ),
              Text(
                chartLabels[1] as String,
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 8),
              ),
              Text(
                chartLabels[2] as String,
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

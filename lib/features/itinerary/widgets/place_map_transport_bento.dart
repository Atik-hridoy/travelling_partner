import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class PlaceMapTransportBento extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isWide;

  const PlaceMapTransportBento({super.key, required this.data, required this.isWide});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> directions = data['directions'];

    final transportView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(Icons.directions_bus, color: VoyentaColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              'How to Get There',
              style: VoyentaTypography.headlineMd.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: VoyentaColors.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: directions.map((dir) {
            final step = dir['step'] as int;
            final isLast = step == directions.length;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: VoyentaColors.primaryContainer.withOpacity(0.15),
                        ),
                        child: Center(
                          child: Text(
                            step.toString(),
                            style: const TextStyle(
                              color: VoyentaColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: VoyentaColors.outlineVariant.withOpacity(0.3),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dir['title'] as String,
                            style: const TextStyle(
                              color: VoyentaColors.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dir['desc'] as String,
                            style: const TextStyle(
                              color: VoyentaColors.onSurfaceVariant,
                              fontSize: 10.5,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );

    final mapView = AspectRatio(
      aspectRatio: 1.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                data['mapImage'] as String,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: VoyentaColors.primary.withOpacity(0.2),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: VoyentaColors.primary,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
                      ],
                    ),
                    child: const Icon(Icons.temple_buddhist, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: VoyentaColors.error,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      data['traffic'] as String,
                      style: const TextStyle(
                        color: VoyentaColors.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.25)),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: transportView),
                const SizedBox(width: 24),
                Expanded(child: mapView),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                transportView,
                const SizedBox(height: 20),
                mapView,
              ],
            ),
    );
  }
}

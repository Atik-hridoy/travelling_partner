import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class CollectionsBento extends StatelessWidget {
  final List<Map<String, String>> collections;

  const CollectionsBento({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Row(
        children: [
          // Large card
          Expanded(
            flex: 6,
            child: CollectionCard(
              collection: collections[0],
              isLarge: true,
            ),
          ),
          const SizedBox(width: 12),
          // Two small cards stacked
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  child: CollectionCard(collection: collections[1]),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: CollectionCard(collection: collections[2]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CollectionCard extends StatelessWidget {
  final Map<String, String> collection;
  final bool isLarge;

  const CollectionCard({super.key, required this.collection, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            collection['img']!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: VoyentaColors.surfaceContainerHigh,
                child: const Center(
                  child: Icon(Icons.image_not_supported, color: VoyentaColors.outline, size: 32),
                ),
              );
            },
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Labels
          Positioned(
            bottom: isLarge ? 24 : 16,
            left: isLarge ? 24 : 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLarge && collection['count'] != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Text(
                      collection['count']!,
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  collection['title']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isLarge ? 26 : 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

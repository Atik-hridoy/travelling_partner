import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class PlaceHeroGallery extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isWide;

  const PlaceHeroGallery({super.key, required this.data, required this.isWide});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> images = data['galleryImages'];

    return Stack(
      children: [
        SizedBox(
          height: isWide ? 460 : 380,
          child: PageView.builder(
            itemCount: images.length,
            controller: PageController(viewportFraction: isWide ? 0.7 : 0.9, keepPage: true),
            padEnds: false,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 6.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(images[index] as String),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.02),
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // 360 View Badge
        Positioned(
          bottom: 40,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.threed_rotation, color: VoyentaColors.primary, size: 18),
                const SizedBox(width: 6),
                Text(
                  '360 VIEW',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        // AI Match Score Floating Badge
        Positioned(
          bottom: 40,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: VoyentaColors.primary,
                  ),
                  child: Center(
                    child: Text(
                      data['match'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VOYANTA MATCH',
                        style: VoyentaTypography.labelCaps.copyWith(
                          fontSize: 7,
                          color: VoyentaColors.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'AI Recommendation',
                        style: VoyentaTypography.bodyMd.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: VoyentaColors.primary,
                        ),
                      ),
                    ],
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

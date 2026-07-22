import 'package:flutter/material.dart';
import '../../../core/theme/typography.dart';

class CityHeroBanner extends StatelessWidget {
  final Map<String, dynamic> data;

  const CityHeroBanner({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(data['heroImage']),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.85),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  (data['breadcrumbs'] as List)[0],
                  style: VoyentaTypography.labelCaps.copyWith(color: Colors.white70, fontSize: 8),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, color: Colors.white70, size: 10),
                const SizedBox(width: 4),
                Text(
                  (data['breadcrumbs'] as List)[1],
                  style: VoyentaTypography.labelCaps.copyWith(color: Colors.white70, fontSize: 8),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              data['title'],
              style: VoyentaTypography.displayLgMobile.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data['subtitle'],
              style: VoyentaTypography.headlineMd.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 36), // Offset for overlap card
          ],
        ),
      ),
    );
  }
}

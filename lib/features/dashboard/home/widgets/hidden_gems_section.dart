import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../controllers/dashboard_controller.dart';

class HiddenGemsSection extends StatelessWidget {
  const HiddenGemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hidden Gems for You',
          style: VoyentaTypography.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: VoyentaColors.onSurface,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        // Asymmetric row for 2 cards
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rome secret cafe card
            Expanded(
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Backdrop Cafe Image
                      Opacity(
                        opacity: 0.15,
                        child: Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuC_w6hVlLhzYmg0uyhpICBIDvCZ3rL5KLb0p36jESP7q-mFxQ7v9Zz0XVOZRW40aT2LANKw1VYwsGS7ruNjd-04aJYXYG3tSifzRmb9PbDrnRSRf3rcNOCpcVqtXTAWlIP_5-adKgeroa3LL_-RcaGEDzNG7Vj2E0wwAl_JSA2B7l1rlbF3nnoDRnYWzSTmcceSSDYlMK_LGKqiJfba-ee0qcAimdfOcVjv59E2TOzoFRUq_cau8spqSzgKS9gaD9EbrFK9WUyzn9wR',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: VoyentaColors.secondaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'SECRET CAFE',
                                    style: VoyentaTypography.labelCaps.copyWith(
                                      color: VoyentaColors.onSecondaryContainer,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.favorite, color: VoyentaColors.primary, size: 18),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Antica Bottega',
                                  style: VoyentaTypography.headlineMd.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: VoyentaColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Hidden behind a florist in Rome. Our AI detected you\'ll love their 1940s jazz vinyl.',
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    fontSize: 10,
                                    height: 1.35,
                                    color: VoyentaColors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Liked by 12 friends',
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: VoyentaColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Copenhagen generate map card
            Expanded(
              child: Container(
                height: 220,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: VoyentaColors.inverseSurface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.explore, size: 36, color: VoyentaColors.onPrimaryContainer),
                    const SizedBox(height: 10),
                    Text(
                      'Expand Your Horizons',
                      textAlign: TextAlign.center,
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Based on your love for minimalist architecture in Copenhagen.',
                      textAlign: TextAlign.center,
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Switch to map view tab
                        Get.find<DashboardController>().changeTabIndex(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: VoyentaColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text(
                          'Generate Map',
                          style: VoyentaTypography.bodyMd.copyWith(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

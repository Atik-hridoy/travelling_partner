import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoyentaColors.surface,
      body: Stack(
        children: [
          // Ambient atmosphere glow
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    VoyentaColors.voyagerStart.withOpacity(0.04),
                    Colors.transparent,
                  ],
                  radius: 1.2,
                  center: Alignment.center,
                ),
              ),
            ),
          ),
          
          // Center Logo & Branding
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Main Logo Image
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                  builder: (context, val, child) {
                    return Opacity(
                      opacity: val,
                      child: Transform.scale(
                        scale: 0.9 + 0.1 * val,
                        child: child,
                      ),
                    );
                  },
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDpQsd-Ma_2G-sEVT_98zD1eKXRmktjcbPEunM5TjcAvgiRHI4KAvtJCcfRB8f2pQDz_I5w3trP_3EsLlqNIg_oCklQJ0B67e8D9iViaGudvlQYbGv1LkRvPrlYS2IFYKcJjYMnmgg-c6VLdxfQoZFc1rId1LWBnBof0XTR8R61L04MIFkrSsi7v_IAzD1u8kdy2v5bncSey8FoGoE2z_EC-zSQzgPzhDS3pL-m57OnSgQDodadoPlZ2q65kcETBDflNafoislkPmLQ',
                    width: 220,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback logo in case of network issue
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: VoyentaColors.voyagerGradient,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Voyanta',
                          style: VoyentaTypography.displayLgMobile.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Tagline
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  builder: (context, val, child) {
                    return Opacity(
                      opacity: val,
                      child: child,
                    );
                  },
                  child: Text(
                    'Know Before You Go',
                    style: VoyentaTypography.bodyLg.copyWith(
                      color: VoyentaColors.onSurfaceVariant.withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Loading indicator & text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(VoyentaColors.primary),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Initializing AI',
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: VoyentaColors.outline,
                        letterSpacing: 2.0,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Luxury Visual Anchor (Bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shower_outlined,
                    color: VoyentaColors.primary.withOpacity(0.5),
                    size: 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'THE INVISIBLE CONCIERGE',
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: VoyentaColors.outline.withOpacity(0.6),
                      fontSize: 9,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

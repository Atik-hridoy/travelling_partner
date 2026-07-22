import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/glass_card.dart';
import '../onboarding_controller.dart';
import 'photo_card.dart';

class WelcomeStep extends StatelessWidget {
  final OnboardingController controller;

  const WelcomeStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    
    // Dynamically adjust sizes based on screen dimensions for responsiveness
    final double logoSize = screenHeight < 700 ? 44 : 56;
    final double cardSize = screenHeight < 700 ? 100 : 130;
    final double welcomeSpacing = screenHeight < 700 ? 8 : 16;
    final double photoSectionHeight = screenHeight < 700 ? 150 : 200;

    return Container(
      key: const ValueKey('WelcomeStep'),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBST5K2Pw2D9ajS8WH2RstGvjB3xzWAEatYR06ME6UuVP7QLnrfH5TXWjGUKcyZ6jCsjxAA__IXF5OHdgYXoN-R6WB220qQYfMQCkL5c9DI836GBMOwWtxoYlrshUkyfFL1oUSplD7RrMScZ6vwNLnIFc91Lpgl4amqFKp3v-ciDsAmGrZz0GPVToKI8HiLTqXcXtlkSf7znUJHhNTdQYK3w2Z08r7CpQBniVyyvzgwkvItIYtYgQbvzodF6YAuubNao5rzL6kCcLyC',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.1),
              VoyentaColors.surfaceDim.withOpacity(0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: welcomeSpacing),
                          // Logo Branding
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: logoSize,
                                height: logoSize,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.explore,
                                    size: logoSize * 0.55,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Voyanta',
                                style: VoyentaTypography.displayLgMobile.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                  fontSize: screenHeight < 700 ? 20 : 24,
                                ),
                              ),
                            ],
                          ),
                          
                          const Spacer(),

                          // 3D Photo Sequence Animation Area (Mocked with responsive cards)
                          SizedBox(
                            height: photoSectionHeight,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Back Photo Card Left
                                Transform.translate(
                                  offset: Offset(-cardSize * 0.45, 0),
                                  child: Transform.rotate(
                                    angle: -0.15,
                                    child: PhotoCard(
                                      url: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCxL-wpEe-ARsDlCv8wflvLbCEEKFFi-ab0ykzuyjepqarsoY7CTYJ6aAuO4U353K4DD2tnrUJyrqIeIIrrZmRshX3ZmFu3lu-83o6M7KbjC1RWMP87jLs6zOz5dE5LY5NCOtHk3A3H0ShHaCiQz41PHQm0eK2nRT9kWF62PWfmUb4Diqa3EMT9irQrlxgBWG8NXz93U2MhVB4FHFXk8c0JcqVQafQugcR60WOwaUYOSgJhHZ_z22X2LgIvJCa5dBNfNnyj5pVJFwH1',
                                      size: cardSize,
                                    ),
                                  ),
                                ),
                                // Back Photo Card Right
                                Transform.translate(
                                  offset: Offset(cardSize * 0.45, 0),
                                  child: Transform.rotate(
                                    angle: 0.15,
                                    child: PhotoCard(
                                      url: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDIdPIyqWEkGSP70a6GOGIqAZQW2UOxadjEZDDOdkYMhM-MpOY3R0uE-COnXmOY34KW1mJwrzXleaIOj9Z9dM9Rp5X8rX-lO_3HkqT5toB3e56_s3jdSnGfMQKZ9fs9A1RI0eXMlT61sHyIstxYjOrZdb4btoky9gL38BCDDLIHjxp11ZijSYbjjCX1ke-7DvK1GnWPTXUJz19475roFRahY7OjZcXA3KtXuJesKDYgHeW65U-qsd4xTYc5YMqQVr0hlhf6W_vnwbAL',
                                      size: cardSize,
                                    ),
                                  ),
                                ),
                                // Center Photo Card
                                Transform.translate(
                                  offset: const Offset(0, -10),
                                  child: PhotoCard(
                                    url: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDWOSbzyaYA3FJchaQPhT2vXHGNkkWZxMyy__PX3QwFluBqJdRf-igdJeB58HicWwZ3WVVJ8TO2bv1wi9Ms6DQcnF5boy4U93Tq6RBGnHZSPczgKNHe2kAugTJYWpyFKqLZSLy8KJho8UjWfx_PeckAjq6cBychI0CCpUoiqZOtc75jkAB_ALIZ5V3IAQubi8mV6m758vK5W37fJQKShlDEAkJwzlw0UWK2EjPPAL4_OiyTZGAegoUeVhvqwAbkvJgCGCNvGiU7cUXt',
                                    size: cardSize,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // Bottom Glassmorphism Text Container
                          GlassCard(
                            borderRadius: 28,
                            bgOpacity: 0.75,
                            padding: EdgeInsets.all(screenHeight < 700 ? 16.0 : 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Your AI-Powered Travel OS',
                                  textAlign: TextAlign.center,
                                  style: VoyentaTypography.headlineMd.copyWith(
                                    color: VoyentaColors.onSurface,
                                    fontWeight: FontWeight.w800,
                                    fontSize: screenHeight < 700 ? 18 : 22,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Discover hidden gems, stay safe, and plan itineraries in one intelligent ecosystem.',
                                  textAlign: TextAlign.center,
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    color: VoyentaColors.onSurfaceVariant,
                                    fontSize: screenHeight < 700 ? 12 : 14,
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Pagination indicators
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        gradient: VoyentaColors.voyagerGradient,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: VoyentaColors.outlineVariant,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: VoyentaColors.outlineVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: welcomeSpacing),
                                // Buttons
                                CustomButton(
                                  text: 'Next',
                                  icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                                  onPressed: () => controller.nextStep(),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () => controller.nextStep(),
                                  child: Text(
                                    'Skip',
                                    style: VoyentaTypography.labelCaps.copyWith(
                                      color: VoyentaColors.onSurfaceVariant,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

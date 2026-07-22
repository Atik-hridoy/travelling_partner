import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/glass_card.dart';

class HiddenGemsSection extends StatelessWidget {
  const HiddenGemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 750;

    final largeCard = const _LargeFeatureCard();

    final smallCards = MockData.smallHiddenGems.map((gem) {
      return _SmallGemCard(gem: gem);
    }).toList();

    final aiAssistantCard = const _FloatingAiCard();

    if (isWide) {
      return Column(
        children: [
          largeCard,
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.82,
            children: [
              ...smallCards,
              aiAssistantCard,
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          largeCard,
          const SizedBox(height: 20),
          ...smallCards.map((card) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: card,
              )),
          aiAssistantCard,
        ],
      );
    }
  }
}

class _LargeFeatureCard extends StatelessWidget {
  const _LargeFeatureCard();

  @override
  Widget build(BuildContext context) {
    final gem = MockData.largeHiddenGem;
    final List<dynamic> pills = gem['pills'] as List<dynamic>;

    return GlassCard(
      borderRadius: 36,
      padding: const EdgeInsets.all(20),
      borderColor: VoyentaColors.outlineVariant.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  gem['img'] as String,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      color: VoyentaColors.surfaceContainerHigh,
                      child: const Center(
                        child: Icon(Icons.image_not_supported, color: VoyentaColors.outline, size: 36),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: VoyentaColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'MUST VISIT',
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return const Icon(Icons.star, color: Colors.amber, size: 16);
                }),
              ),
              const SizedBox(width: 8),
              Text(
                '${gem['rating']} (${gem['reviewsCount']})',
                style: const TextStyle(
                  color: VoyentaColors.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            gem['title'] as String,
            style: VoyentaTypography.headlineMd.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: VoyentaColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            gem['desc'] as String,
            style: VoyentaTypography.bodyMd.copyWith(
              fontSize: 12.5,
              height: 1.45,
              color: VoyentaColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: pills.map((pill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: VoyentaColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  pill as String,
                  style: VoyentaTypography.labelCaps.copyWith(
                    fontSize: 8.5,
                    color: VoyentaColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 54,
                      height: 28,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: const NetworkImage(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuA151LPY8Ih-x7reZHOnWDqnExiaSvifxqHf929OweOktNxO4HFUnS_qBmcEN3elUYdsDV4gleIjlRZaU9EY69PwoAh1XymGjyrCwXLaQ1D-C3xL-urWvhdA7LJhZ-dSpwsD4V8M3P8IT-RJBZ4C5Wlwx7WRR8aDiFsY912Jnc7AMqwxTUMjHprFA4JIelUVMpEc4iYXNAldc_dXZ4DTuzB83LwTwbFNqnol95IaEBBrYmvVdeBDq5vFtP7Lhy4-JPw2i2KJmT9mfqd',
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 13,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: const NetworkImage(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBa_fCganULibwRpOXGcU93TtDvNAwkAXtVHW06bZOpsfK85VcZGpuxDN3pFt1hl5yRznYdDTi98YbKIQM_48Q6kd5_RDgnEjxzboHHbn9agak3I4Twrnlp3lpt6tV-eUQOG7T3pQsESRqomGMl01fAHa1wRFx_YaJr9Z-c82ptrc-O8KpkmcstRb35Y8M2Li5_lYCvc6zjz5VHv3rAekdWbXK0up-M3nDpWTgO6CW15vucvpxUWV6BA-ZmuaTMxZXLS15aO9FklUSG',
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 26,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: const NetworkImage(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCLFU1Igc8maK-COFsKeI56ZaxW2gkAHwibNZKWW6GRbJnenBceKg_Cb2MI6z6NFd8pd5rXQeNstOnEWpRj-NNcPgtCqT-NRpk_FYQxEHt6uiGTC1OGfrTz6bg6SQ9JIBPH3AzFtboMwCiS-E0E109-3ucQ7PalCeJpfrKRpaHSyXaGv_xLmom4Tti_WBptPkK_mDlTLD-Zt4l17eK4FRe4WXV3QI2-KG1qks_LMe0rPu8JvCr5wiOyNvqHP_8gnuztKrFYYCg3-dKJ',
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Recommended by experts',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: VoyentaColors.onSurfaceVariant,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: VoyentaColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Save Gem',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
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

class _SmallGemCard extends StatelessWidget {
  final Map<String, String> gem;

  const _SmallGemCard({required this.gem});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 32,
      padding: const EdgeInsets.all(16),
      borderColor: VoyentaColors.outlineVariant.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    gem['img']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: VoyentaColors.surfaceContainerHigh,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, color: VoyentaColors.outline, size: 28),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.favorite_border, color: VoyentaColors.primary, size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            gem['location']!,
            style: VoyentaTypography.labelCaps.copyWith(
              color: VoyentaColors.primary,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            gem['title']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: VoyentaTypography.headlineMd.copyWith(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: VoyentaColors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            gem['desc']!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: VoyentaTypography.bodyMd.copyWith(
              fontSize: 11.5,
              height: 1.4,
              color: VoyentaColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  gem['author']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: VoyentaColors.onSurface,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  gem['action']!,
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: VoyentaColors.primary,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
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

class _FloatingAiCard extends StatelessWidget {
  const _FloatingAiCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: VoyentaColors.primary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: VoyentaColors.primary.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: VoyentaColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.primary.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 16),
              Text(
                'Ask Voyanta AI',
                style: VoyentaTypography.headlineMd.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: VoyentaColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Can't find what you're looking for? Our AI can scan thousands of community posts to find your perfect match.",
                style: VoyentaTypography.bodyMd.copyWith(
                  fontSize: 12,
                  height: 1.45,
                  color: VoyentaColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.AI_ASSISTANT),
            style: ElevatedButton.styleFrom(
              backgroundColor: VoyentaColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Start AI Chat',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

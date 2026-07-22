import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/mock/mock_data.dart';
import 'widgets/hero_banner.dart';
import 'widgets/concierge_card.dart';
import 'widgets/highlights_section.dart';
import 'widgets/know_before_you_go.dart';
import 'widgets/trending_section.dart';
import 'widgets/community_tips.dart';

class PlaceDetailsView extends StatelessWidget {
  const PlaceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final Map<String, dynamic> place = MockData.santoriniDetails;

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: VoyentaColors.primary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Voyanta',
          style: VoyentaTypography.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: VoyentaColors.primary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: VoyentaColors.primary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Immersive Hero Gallery (Oia Santorini Cover Image)
                HeroBanner(place: place, screenHeight: screenHeight),

                // 2. AI Concierge Summary (Overlapping Card)
                ConciergeCard(place: place),
                const SizedBox(height: 24),

                // 3. Highlights Chips
                HighlightsSection(place: place),
                const SizedBox(height: 28),

                // 4. Know Before You Go (3 Columns Grid)
                KnowBeforeYouGo(place: place),
                const SizedBox(height: 28),

                // 5. What's Trending Here (Asymmetric Bento Grid)
                TrendingSection(place: place),
                const SizedBox(height: 28),

                // 6. Community Tips (Glass Cards)
                CommunityTips(place: place),
              ],
            ),
          ),

          // Floating Action Button (Plan My Visit)
          Positioned(
            bottom: 24,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Navigate to Trip Planner tab
                Get.offAllNamed('/dashboard');
              },
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: VoyentaColors.primaryContainer,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.primary.withOpacity(0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.event_available, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Plan My Visit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

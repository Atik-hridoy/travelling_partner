import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import 'widgets/search_input_bar.dart';
import 'widgets/category_list.dart';
import 'widgets/recent_searches.dart';
import 'widgets/ai_recommendation_card.dart';
import 'widgets/trending_section.dart';
import 'widgets/curated_collections.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 900;

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: VoyentaColors.primary),
          onPressed: () => Get.back(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, color: VoyentaColors.primary, size: 22),
            const SizedBox(width: 4),
            Text(
              'Voyanta',
              style: VoyentaTypography.headlineMd.copyWith(
                fontWeight: FontWeight.w800,
                color: VoyentaColors.primary,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: VoyentaColors.primary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Search Input Bar
            const SearchInputBar(),
            const SizedBox(height: 16),

            // 2. Category horizontal scroll list
            const CategoryList(),
            const SizedBox(height: 28),

            // 3. Main content Layout (Split Columns for Tablet/Web, Stacked for Mobile)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const RecentSearches(),
                              const SizedBox(height: 36),
                              const AIRecommendationCard(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const TrendingSection(),
                              const SizedBox(height: 36),
                              const CuratedCollections(),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const RecentSearches(),
                        const SizedBox(height: 28),
                        const AIRecommendationCard(),
                        const SizedBox(height: 28),
                        const TrendingSection(),
                        const SizedBox(height: 28),
                        const CuratedCollections(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

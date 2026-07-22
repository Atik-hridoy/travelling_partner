import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/mock/mock_data.dart';
import 'community_controller.dart';
import 'widgets/search_hero_section.dart';
import 'widgets/live_stories_header.dart';
import 'widgets/live_stories_carousel.dart';
import 'widgets/insider_access_header.dart';
import 'widgets/hidden_gems_section.dart';

class CommunityStories extends GetView<CommunityController> {
  const CommunityStories({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = MockData.communityStories;

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: const Row(
          children: [
            SizedBox(width: 16),
            Icon(Icons.location_on, color: VoyentaColors.primary, size: 24),
          ],
        ),
        title: Text(
          'Voyanta',
          style: VoyentaTypography.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: VoyentaColors.primary,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: VoyentaColors.onSurfaceVariant),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Hero Section: "Travel Questions?"
            const SearchHeroSection(),
            const SizedBox(height: 36),

            // 2. Curated Travel Stories Section
            const LiveStoriesHeader(),
            const SizedBox(height: 16),
            LiveStoriesCarousel(stories: stories),
            const SizedBox(height: 36),

            // 3. Insider Access & Hidden Gems Section
            const InsiderAccessHeader(),
            const SizedBox(height: 16),
            const HiddenGemsSection(),
          ],
        ),
      ),
    );
  }
}

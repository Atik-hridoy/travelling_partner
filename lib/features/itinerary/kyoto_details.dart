import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/mock/mock_data.dart';
import 'kyoto_controller.dart';
import 'widgets/city_hero_banner.dart';
import 'widgets/city_ai_summary_card.dart';
import 'widgets/city_things_to_know_card.dart';
import 'widgets/city_quick_stats_grid.dart';
import 'widgets/city_best_time_card.dart';
import 'widgets/city_emergency_card.dart';
import 'widgets/city_experiences_section.dart';

class KyotoDetails extends GetView<KyotoDetailsController> {
  const KyotoDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 900;
    final Map<String, dynamic> data = MockData.kyotoDetails;

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
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: VoyentaColors.primary),
            onPressed: () => Get.toNamed('/search'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Editorial Image Header
                CityHeroBanner(data: data),

                // 2. Main Content Grid (Split Columns for Web, Stacked for Mobile)
                Transform.translate(
                  offset: const Offset(0, -32),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left column (AI Summary, Things to Know)
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    CityAISummaryCard(data: data),
                                    const SizedBox(height: 24),
                                    CityThingsToKnowCard(data: data),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              // Right column (Stats Sidebar)
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    CityQuickStatsGrid(data: data),
                                    const SizedBox(height: 24),
                                    CityBestTimeCard(data: data),
                                    const SizedBox(height: 24),
                                    CityEmergencyCard(data: data),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CityAISummaryCard(data: data),
                              const SizedBox(height: 24),
                              CityThingsToKnowCard(data: data),
                              const SizedBox(height: 24),
                              CityQuickStatsGrid(data: data),
                              const SizedBox(height: 24),
                              CityBestTimeCard(data: data),
                              const SizedBox(height: 24),
                              CityEmergencyCard(data: data),
                            ],
                          ),
                  ),
                ),

                // 3. Signature Experiences
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CityExperiencesSection(data: data, isWide: isWide),
                ),
              ],
            ),
          ),

          // Floating AI Assistant Button (Contextual)
          Positioned(
            bottom: 24,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => Get.toNamed('/ai_assistant'),
              backgroundColor: VoyentaColors.primary,
              shape: const CircleBorder(),
              elevation: 8,
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

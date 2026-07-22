import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/mock/mock_data.dart';
import 'widgets/place_hero_gallery.dart';
import 'widgets/place_info_header.dart';
import 'widgets/place_community_tips_card.dart';
import 'widgets/place_crowd_prediction_card.dart';
import 'widgets/place_map_transport_bento.dart';
import 'widgets/place_bottom_action_bar.dart';

class ShisendoDetails extends StatelessWidget {
  const ShisendoDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 900;
    final Map<String, dynamic> data = MockData.shisendoDetails;

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
          IconButton(
            icon: const Icon(Icons.more_vert, color: VoyentaColors.primary),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Immersive Hero Gallery
                PlaceHeroGallery(data: data, isWide: isWide),

                // 2. Place Info Header (Overlaps Gallery)
                Transform.translate(
                  offset: const Offset(0, -24),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: PlaceInfoHeader(data: data),
                  ),
                ),

                // 3. Bento Grid Section (Tips & Crowd Prediction)
                Transform.translate(
                  offset: const Offset(0, -12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 8,
                                child: PlaceCommunityTipsCard(data: data),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 4,
                                child: PlaceCrowdPredictionCard(data: data),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PlaceCommunityTipsCard(data: data),
                              const SizedBox(height: 20),
                              PlaceCrowdPredictionCard(data: data),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 12),

                // 4. Map & Transport Bento Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PlaceMapTransportBento(data: data, isWide: isWide),
                ),
              ],
            ),
          ),

          // 5. Contextual Bottom Action Bar
          const Align(
            alignment: Alignment.bottomCenter,
            child: PlaceBottomActionBar(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/destination_card.dart';
import '../widgets/hidden_gem_chip.dart';

class DestinationStep extends GetView<TripWizardController> {
  const DestinationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Section
          Container(
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: TextField(
              controller: controller.searchController,
              onChanged: (val) => controller.destination.value = val,
              decoration: InputDecoration(
                hintText: 'Where do you want to go?',
                hintStyle: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.outline),
                prefixIcon: const Icon(Icons.search, color: VoyentaColors.outline),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
          
          // Autocomplete Suggestions Dropdown
          Obx(() {
            if (controller.placeSuggestions.isEmpty) return const SizedBox.shrink();
            
            return Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: VoyentaColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.placeSuggestions.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: VoyentaColors.outlineVariant.withValues(alpha: 0.2),
                ),
                itemBuilder: (context, index) {
                  final place = controller.placeSuggestions[index];
                  return ListTile(
                    leading: const Icon(Icons.location_city, color: VoyentaColors.primary),
                    title: Text(place, style: VoyentaTypography.bodyLg),
                    onTap: () {
                      controller.selectSuggestion(place);
                      // Close keyboard
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 40),

          // Dynamic Suggestions based on Search
          Obx(() {
            final query = controller.destination.value.trim();

            if (query.isEmpty) {
              // Default state: Suggested Near You
              return _buildDestinationContent(
                title: 'Suggested Near You',
                subtitle: 'Based on your current location',
                largeTitle: 'Coastal Getaway',
                largeSubtitle: 'Experience the serene beauty of the nearby coast.',
                smallTitle1: 'Mountain Retreat',
                smallTitle2: 'City Escape',
                hiddenGemsTitle: 'Local Hidden Gems',
                hiddenGems: const [
                  HiddenGemChip(icon: Icons.park, title: 'National Park', color: VoyentaColors.tertiary),
                  HiddenGemChip(icon: Icons.water, title: 'Hidden Lake', color: VoyentaColors.primary),
                  HiddenGemChip(icon: Icons.museum, title: 'Art District', color: VoyentaColors.secondary),
                ],
              );
            } else {
              // Search state: Suggestions for query
              // Capitalize first letter for better display
              final displayQuery = query.length > 1 
                  ? '${query[0].toUpperCase()}${query.substring(1)}'
                  : query.toUpperCase();
                  
              return _buildDestinationContent(
                title: 'Suggestions for "$displayQuery"',
                subtitle: 'Popular spots matching your search',
                largeTitle: '$displayQuery City Center',
                largeSubtitle: 'The heart of $displayQuery with top attractions and luxury stays.',
                smallTitle1: 'North $displayQuery',
                smallTitle2: 'South $displayQuery',
                hiddenGemsTitle: 'Hidden Gems in $displayQuery',
                hiddenGems: [
                  HiddenGemChip(icon: Icons.landscape, title: '$displayQuery Hills', color: VoyentaColors.tertiary),
                  HiddenGemChip(icon: Icons.storefront, title: 'Local Market', color: VoyentaColors.primary),
                  HiddenGemChip(icon: Icons.restaurant, title: 'Secret Cafe', color: VoyentaColors.secondary),
                  HiddenGemChip(icon: Icons.temple_buddhist, title: 'Old Town', color: VoyentaColors.error),
                ],
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildDestinationContent({
    required String title,
    required String subtitle,
    required String largeTitle,
    required String largeSubtitle,
    required String smallTitle1,
    required String smallTitle2,
    required String hiddenGemsTitle,
    required List<HiddenGemChip> hiddenGems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant),
        ),
        const SizedBox(height: 24),

        // Large Card
        DestinationCard(
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBQPaQLgw2KStvXXIaJLaM7v1kLfVfAWq2PpqugvPCIJnxk2VKKDlEW0MgANjm_62_vI6saRr98seX_QB0DnF9E-9zljlfGXnVqeJCdr26__CoDJCoQE-W8KC4APDejvYn9Enb55CCcvNHeL9eaek60PTZoSKLvF0iVgqzCqV249OVul3AH3KaPtfPgaMOqUX3h2gP-7L6xsAJ5NDzmiwZ67wFox9_wttQ5S6FATM0De_Q-UdAmSVO52oF6BJ_RPGPSp6RpQUfZZ_2u',
          title: largeTitle,
          subtitle: largeSubtitle,
          isPopular: true,
          height: 280,
        ),
        const SizedBox(height: 16),

        // Small Cards Row
        Row(
          children: [
            Expanded(
              child: DestinationCard(
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA25V2Hk-z9Di-WsM3D1hI1ojs8apUSQI4uIp_iv846G-bRdzKVViqOWi8DBnV5dbFZHNgxt6ClLwPkdn_RIjffOl2I7Lkdl7eOI7entPXVX3fGLpqqRsoAVtPzgJLPDK1n7GMG4dLeEU9IU9wg4Nez_c87M9sK2sPYNSl9lwIHNLUdXc8ao9PZxzIrdTC8MZqqnGz0HfFNHtVQXQwaMmc-nCdR0aS8VBxZ2g8F0w6h72DYfEodix_1SYyuj1W13KyHb-wlV-G_73Ja',
                title: smallTitle1,
                subtitle: '9.8 Rating',
                height: 200,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DestinationCard(
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA9Y-yOIW2F6bq2tBDAihzKmZvCD0hiN9lEWdu5nw0e1GQ5HKM2OEUygGdb6dUnJf0GNEGhlzO3OLV06dRjiOZsQxptHxkHdAVBD05DiQ8SznQ4ivnVnpcw6-9dGNuKvmW0THWEqNrtR-IGHDcbBaxacfxMWzs8FqMUrH0DiKwH3qKressS7GeLw_JwqZr4IA3_qOiYcluBWaIHeB6t4UGHdRILNLOp8eJvZ_6Mb1M6AboI2mOkUzHobnFkXCN1ucB54cyj99OWKjlg',
                title: smallTitle2,
                subtitle: 'Popular pick',
                height: 200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Hidden Gems
        Row(
          children: [
            const Icon(Icons.auto_awesome, color: VoyentaColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                hiddenGemsTitle,
                style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: hiddenGems,
        ),
      ],
    );
  }
}

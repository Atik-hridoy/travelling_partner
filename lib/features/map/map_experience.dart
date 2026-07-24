import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart' hide MapController;
import 'package:latlong2/latlong.dart';
import '../../core/theme/colors.dart';
import '../../core/mock/mock_data.dart';
import '../../core/constants/api_constants.dart';
import 'map_controller.dart';
import 'widgets/map_filter_pills.dart';
import 'widgets/map_insight_button.dart';
import 'widgets/map_trending_carousel.dart';
import 'widgets/map_search_bar.dart';
import 'widgets/map_location_button.dart';

class MapExperience extends GetView<MapController> {
  const MapExperience({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filterPills = MockData.mapFilterPills;

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. Mapbox Map View (flutter_map with official Mapbox Streets style tiles)
          Positioned.fill(
            child: Obx(() {
              final markers = <Marker>[
                Marker(
                  point: const LatLng(37.7897, -122.3972),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, color: Colors.redAccent, size: 36),
                ),
                Marker(
                  point: const LatLng(37.7894, -122.4014),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, color: Colors.orangeAccent, size: 36),
                ),
                Marker(
                  point: const LatLng(37.7955, -122.3937),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, color: Colors.blueAccent, size: 36),
                ),
              ];

              if (controller.searchedLocation.value != null) {
                markers.add(
                  Marker(
                    point: controller.searchedLocation.value!,
                    width: 48,
                    height: 48,
                    child: const Icon(Icons.stars_rounded, color: Colors.deepPurpleAccent, size: 42),
                  ),
                );
              }

              return FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: const LatLng(37.7897, -122.3972),
                  initialZoom: 14.5,
                  minZoom: 1.0,
                  maxZoom: 19.0,
                  onTap: (_, __) {
                    if (controller.isSearchActive.value) {
                      controller.deactivateSearch();
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: ApiConstants.mapboxTileUrl,
                    userAgentPackageName: 'com.voyenta.app',
                    maxZoom: 19,
                    minZoom: 1,
                  ),
                  MarkerLayer(markers: markers),
                ],
              );
            }),
          ),

          // 2. Subtle gradient overlay (touch passthrough)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.25),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          // 3. 🔍 Floating Glassmorphic Search Bar (TOP)
          const MapSearchBar(),

          // 4. Glassmorphic Category Filter Pills
          //    Pushed down to avoid overlapping search bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 76,
            left: 0,
            right: 0,
            child: MapFilterPills(filterPills: filterPills),
          ),

          // 5. Floating AI Insights Button (Bolt Icon)
          const MapInsightButton(),

          // 5.5 Floating Current Location Button
          const MapLocationButton(),

          // 6. "Trending Nearby" Carousel (Bottom)
          Obx(() => MapTrendingCarousel(
            nearbyPlaces: controller.trendingPlaces,
            isLoading: controller.isTrendingLoading.value,
          )),
        ],
      ),
    );
  }
}

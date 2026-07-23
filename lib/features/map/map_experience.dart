import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/theme/colors.dart';
import '../../core/mock/mock_data.dart';
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
          // 1. Real Google Map Background
          Positioned.fill(
            child: Obx(() {
              // Show searched location marker if available
              final Set<Marker> markers = {
                const Marker(
                  markerId: MarkerId('salesforce_park'),
                  position: LatLng(37.7897, -122.3972),
                  infoWindow: InfoWindow(title: 'Salesforce Park'),
                ),
                const Marker(
                  markerId: MarkerId('blue_bottle'),
                  position: LatLng(37.7894, -122.4014),
                  infoWindow: InfoWindow(title: 'Blue Bottle Coffee'),
                ),
                const Marker(
                  markerId: MarkerId('ferry_building'),
                  position: LatLng(37.7955, -122.3937),
                  infoWindow: InfoWindow(title: 'The Ferry Building'),
                ),
              };

              // Add search result marker dynamically
              if (controller.searchedLocation.value != null) {
                markers.add(
                  Marker(
                    markerId: const MarkerId('search_result'),
                    position: controller.searchedLocation.value!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure),
                    infoWindow: InfoWindow(
                      title: controller.searchQuery.value,
                    ),
                  ),
                );
              }

              return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7897, -122.3972),
                  zoom: 14.5,
                ),
                onMapCreated: controller.onMapCreated,
                markers: markers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onTap: (_) {
                  // Dismiss search on map tap
                  if (controller.isSearchActive.value) {
                    controller.deactivateSearch();
                  }
                },
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

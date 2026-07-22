import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/theme/colors.dart';
import '../../core/mock/mock_data.dart';
import 'map_controller.dart';
import 'widgets/map_filter_pills.dart';
import 'widgets/map_insight_button.dart';
import 'widgets/map_trending_carousel.dart';
import 'widgets/map_app_bar_header.dart';

class MapExperience extends GetView<MapController> {
  const MapExperience({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filterPills = MockData.mapFilterPills;
    final List<Map<String, dynamic>> nearbyPlaces = MockData.mapNearbyPlaces;

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      body: Stack(
        children: [
          // 1. Real Google Map Background
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7897, -122.3972),
                zoom: 14.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('salesforce_park'),
                  position: const LatLng(37.7897, -122.3972),
                  infoWindow: const InfoWindow(title: 'Salesforce Park'),
                  onTap: () => controller.selectMarker('Salesforce Park'),
                ),
                Marker(
                  markerId: const MarkerId('blue_bottle'),
                  position: const LatLng(37.7894, -122.4014),
                  infoWindow: const InfoWindow(title: 'Blue Bottle Coffee'),
                  onTap: () => controller.selectMarker('Blue Bottle'),
                ),
                Marker(
                  markerId: const MarkerId('ferry_building'),
                  position: const LatLng(37.7955, -122.3937),
                  infoWindow: const InfoWindow(title: 'The Ferry Building'),
                  onTap: () => controller.selectMarker('The Ferry Building'),
                ),
              },
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),

          // 2. Subtle overlay gradient (passes touches through to map)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.transparent,
                      Colors.black.withOpacity(0.25),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          // 3. Top App Bar Header
          const MapAppBarHeader(),

          // 4. Glassmorphic Category Filter Pills (Floating)
          MapFilterPills(filterPills: filterPills),

          // 5. Floating AI Insights Button (Bolt Icon)
          const MapInsightButton(),

          // 6. "Trending Nearby" Carousel (Bottom)
          MapTrendingCarousel(nearbyPlaces: nearbyPlaces),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/constants/api_constants.dart';
import '../../core/services/app_logger.dart';

class MapController extends GetxController {
  var selectedMarker = ''.obs;
  var isPanelExpanded = false.obs;

  final MapControllerImpl mapController = MapControllerImpl();

  // ── Search State ──────────────────────────────────────────────────────────
  final searchQuery = RxString('');
  var isSearchActive = false.obs;
  var isSearchLoading = false.obs;
  var suggestions = <Map<String, String>>[].obs;
  var searchedLocation = Rx<LatLng?>(null);

  // ── Trending State ────────────────────────────────────────────────────────
  var isTrendingLoading = false.obs;
  var trendingPlaces = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Default fallback mock data until location is fetched
    trendingPlaces.value = [
      {'title': 'Discovering Places...', 'dist': '--', 'tags': ['Exploring']},
    ];
  }

  void selectMarker(String name) {
    selectedMarker.value = name;
    isPanelExpanded.value = true;
  }

  void clearSelection() {
    selectedMarker.value = '';
    isPanelExpanded.value = false;
  }

  // ── Search (Mapbox Geocoding Engine) ───────────────────────────────────────

  void activateSearch() => isSearchActive.value = true;

  void deactivateSearch() {
    isSearchActive.value = false;
    suggestions.clear();
    searchQuery.value = '';
  }

  Future<void> onSearchChanged(String query) async {
    searchQuery.value = query;
    if (query.trim().length < 2) {
      suggestions.clear();
      return;
    }

    isSearchLoading.value = true;
    try {
      // Mapbox Places / Geocoding API endpoint
      final url = Uri.parse(
        ApiConstants.mapboxGeocodingUrl(query.trim()),
      );

      final response = await http
          .get(url, headers: {
            'User-Agent': 'VoyentaApp/1.0 (travel app)',
          })
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> features = data['features'] as List<dynamic>? ?? [];

        AppLogger.info(
            '🗺️ Mapbox Geocoding: ${features.length} real results for "$query"',
            tag: 'MAPBOX_SEARCH');

        suggestions.value = features.map<Map<String, String>>((item) {
          final placeName = item['place_name'] as String? ?? item['text'] as String? ?? '';
          final geometry = item['geometry'] as Map<String, dynamic>? ?? {};
          final center = item['center'] as List<dynamic>? ?? geometry['coordinates'] as List<dynamic>? ?? [0.0, 0.0];
          
          final double lon = (center.isNotEmpty ? center[0] : 0.0).toDouble();
          final double lat = (center.length > 1 ? center[1] : 0.0).toDouble();

          return {
            'description': placeName.isNotEmpty ? placeName : 'Unknown Location',
            'lat': lat.toString(),
            'lon': lon.toString(),
          };
        }).toList();
      } else {
        AppLogger.error('Mapbox Search HTTP ${response.statusCode}', response.body);
        suggestions.clear();
      }
    } catch (e) {
      AppLogger.error('Mapbox search error', e);
      suggestions.clear();
    } finally {
      isSearchLoading.value = false;
    }
  }

  /// User picks a suggestion — move Mapbox map to lat/lng
  void selectSuggestion(String description, String lat, String lon) {
    isSearchActive.value = false;
    suggestions.clear();
    searchQuery.value = description.split(',').first.trim();

    try {
      final double latitude = double.parse(lat);
      final double longitude = double.parse(lon);
      final target = LatLng(latitude, longitude);
      searchedLocation.value = target;

      mapController.move(target, 14.5);

      AppLogger.success(
          '📍 Mapbox moved to: $description ($latitude, $longitude)',
          tag: 'MAP_MOVE');

      // Fetch nearby places
      fetchTrendingPlaces(latitude, longitude, queryName: description);
    } catch (e) {
      AppLogger.error('Map camera move error', e);
    }
  }

  // ── Current Location ────────────────────────────────────────────────────────
  var isLocationFetching = false.obs;

  Future<void> goToCurrentLocation() async {
    isLocationFetching.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        AppLogger.error('Location error', 'Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AppLogger.error('Location error', 'Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AppLogger.error('Location error', 'Location permissions are permanently denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));

      final target = LatLng(position.latitude, position.longitude);
      
      searchedLocation.value = target;
      searchQuery.value = 'Current Location';

      mapController.move(target, 15.0);
      
      AppLogger.success('Moved to current location: ${position.latitude}, ${position.longitude}', tag: 'MAP');
      
      // Fetch nearby places
      fetchTrendingPlaces(position.latitude, position.longitude, queryName: 'Current Location');
    } catch (e) {
      AppLogger.error('Error getting current location', e);
    } finally {
      isLocationFetching.value = false;
    }
  }

  // ── Fetch Nearby Places (Wikipedia GeoSearch) ─────────────────────────────
  Future<void> fetchTrendingPlaces(double lat, double lon, {String? queryName}) async {
    isTrendingLoading.value = true;
    try {
      final url = Uri.parse(ApiConstants.wikipediaGeoSearchUrl(lat, lon));
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'VoyentaApp/1.0 (travel app)',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['query']?['geosearch'] as List<dynamic>? ?? [];

        if (results.isNotEmpty) {
          trendingPlaces.value = results.map((place) {
            final title = place['title'] as String? ?? 'Unknown Place';
            final distMeters = (place['dist'] as num?)?.toDouble() ?? 0.0;
            final distStr = distMeters > 1000 
                ? '\${(distMeters / 1000).toStringAsFixed(1)}km' 
                : '\${distMeters.toInt()}m';
                
            return {
              'title': title,
              'dist': distStr,
              'tags': ['Landmark', 'Nearby'],
            };
          }).toList();
        } else {
          trendingPlaces.value = [];
        }

        // Save to Firestore for future valuable insights
        _saveLocationHistoryToFirestore(lat, lon, queryName, trendingPlaces.toList());
      }
    } catch (e) {
      AppLogger.error('Error fetching trending places', e);
    } finally {
      isTrendingLoading.value = false;
    }
  }

  // ── Save Location History ──────────────────────────────────────────────────
  Future<void> _saveLocationHistoryToFirestore(
      double lat, double lon, String? queryName, List<Map<String, dynamic>> places) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      
      // Safe check: If user is not logged in, we can either skip or log info
      final userId = user?.uid ?? 'guest_user';

      await FirebaseFirestore.instance.collection('location_history').add({
        'userId': userId,
        'queryName': queryName ?? 'Unknown Location',
        'latitude': lat,
        'longitude': lon,
        'timestamp': FieldValue.serverTimestamp(),
        'trendingPlaces': places,
      });
      AppLogger.success('Location & trending data saved', tag: 'LOCATION_HISTORY');
    } catch (e) {
      // Catch permission-denied or network errors gracefully so app keeps running smoothly
      AppLogger.info('Location history save status: $e', tag: 'LOCATION_HISTORY');
    }
  }
}

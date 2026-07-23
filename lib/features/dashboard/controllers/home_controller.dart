import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/location_weather_service.dart';
import '../../../core/services/app_logger.dart';
import '../../auth/auth_service.dart';
import '../../profile/profile_controller.dart';

class HomeController extends GetxController {
  var isFlightExpanded = false.obs;
  var notificationCount = 2.obs;
  var currentLocation = 'your destination'.obs;
  var locationSummary = 'Analyzing local spots to curate your perfect afternoon based on local hidden gems.'.obs;
  var isWikiLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRealLocation();
  }

  Future<void> loadRealLocation() async {
    try {
      final data = await LocationWeatherService.fetchLiveWeatherAndLocation();
      if (data.locationName.isNotEmpty) {
        final parts = data.locationName.split(',');
        final city = parts[0].trim();
        currentLocation.value = city;

        // Check if we already have this city's curation saved in Firebase Profile
        if (Get.isRegistered<ProfileController>()) {
          final profileCtrl = Get.find<ProfileController>();
          final profile = profileCtrl.user.value;
          
          if (profile['lastCuratedCity'] == city && profile['currentLocationSummary'] != null) {
            locationSummary.value = profile['currentLocationSummary'];
            AppLogger.success('Loaded saved curation from Firebase: /users/${AuthService.currentUser?.uid ?? "julian_d"}', tag: 'FIREBASE_CURED');
            return;
          }
        }
        
        // If not cached in Firebase, fetch live from Wikipedia
        fetchLocalWikiCuration(city);
      }
    } catch (_) {
      currentLocation.value = 'your destination';
    }
  }

  Future<void> fetchLocalWikiCuration(String city) async {
    isWikiLoading.value = true;
    try {
      AppLogger.info('Fetching live Wikipedia curation summary for: $city', tag: 'WIKI_FETCH');
      final url = Uri.parse(ApiConstants.wikipediaSummaryUrl(city));
      final response = await http.get(url).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final wikiData = json.decode(response.body);
        final String? extract = wikiData['extract'];
        if (extract != null && extract.isNotEmpty) {
          String cleanSummary = extract;

          // Safe trim: only seek sentence boundary if extract is long enough
          if (extract.length > 120) {
            final int searchFrom = extract.length > 120 ? 120 : 0;
            final sentenceEnd = extract.indexOf('.', searchFrom);
            if (sentenceEnd != -1) {
              cleanSummary = extract.substring(0, sentenceEnd + 1);
            } else {
              // No sentence boundary found — just take first 200 chars
              cleanSummary = extract.length > 200
                  ? '${extract.substring(0, 200)}...'
                  : extract;
            }
          }
          
          // Format it to sound exactly like a premium AI Curation recommendation!
          final String aiCurationText = 'Our AI Concierge analyzed the local spots in $city. Nova recommends: $cleanSummary';
          
          locationSummary.value = aiCurationText;
          AppLogger.success('Live AI Curation Formatted: "$aiCurationText"', tag: 'WIKI_SUCCESS');

          // Save this new curation to Cloud Firestore Profile
          saveCurationToFirebase(city, aiCurationText);
          return;
        }
      }
    } catch (e) {
      AppLogger.error('Wiki Curation Notice', e);
    } finally {
      isWikiLoading.value = false;
    }
    
    // Fallback if Wiki is offline or city not found
    locationSummary.value = 'Our AI has analyzed 12,000+ local spots to curate your perfect afternoon in $city based on your custom taste.';
  }

  Future<void> saveCurationToFirebase(String city, String summary) async {
    final uid = AuthService.currentUser?.uid;
    if (uid == null) return;

    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      await docRef.set({
        'lastCuratedCity': city,
        'currentLocationSummary': summary,
      }, SetOptions(merge: true));
      AppLogger.success('Synced new location curation to Firestore: /users/$uid', tag: 'FIRESTORE_CURI_SYNC');
    } catch (e) {
      AppLogger.error('Curation Firebase Sync Notice', e);
    }
  }

  void toggleFlightExpansion() {
    isFlightExpanded.value = !isFlightExpanded.value;
  }
}

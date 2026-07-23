import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/services/app_logger.dart';
import '../../core/services/gemini_service.dart' show GroqService;
import '../auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ── Data Model ──────────────────────────────────────────────────────────────
class PlanMyDayItem {
  final String id;
  final String timeTag;
  final String distance;
  final String title;
  final String description;
  final String novaInsight;
  final IconData icon;
  final String imageUrl;
  final String category;

  PlanMyDayItem({
    required this.id,
    required this.timeTag,
    required this.distance,
    required this.title,
    required this.description,
    required this.novaInsight,
    required this.icon,
    required this.imageUrl,
    this.category = 'attraction',
  });
}

// ── Controller ───────────────────────────────────────────────────────────────
class PlanMyDayController extends GetxController {
  var activeNodeIndex = 0.obs;
  var isLoading = true.obs;
  var isGeminiPowered = false.obs;
  var cityName = 'your city'.obs;
  var cityTagline = ''.obs;
  var userTravelStyles = <String>[].obs;

  final itineraryItems = <PlanMyDayItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromFirebaseAndBuild();
  }

  /// Step 1: Load city + styles from Firebase
  Future<void> _loadFromFirebaseAndBuild() async {
    isLoading.value = true;
    try {
      final uid = AuthService.currentUser?.uid;
      Map<String, dynamic> firebaseData = {};

      if (uid != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        if (doc.exists && doc.data() != null) {
          firebaseData = doc.data()!;
          AppLogger.info('✅ Firebase profile loaded for plan: /users/$uid',
              tag: 'PLAN_FIREBASE');
        }
      }

      // Extract city from Firebase location field
      final String rawLocation = firebaseData['location'] as String? ??
          firebaseData['lastCuratedCity'] as String? ??
          'Dhaka';
      final String rawCountry = (rawLocation.contains(','))
          ? rawLocation.split(',').last.trim()
          : 'Bangladesh';
      final city = rawLocation.split(',')[0].trim();
      cityName.value = city;

      // AI curation tagline from Firebase
      final String? summary =
          firebaseData['currentLocationSummary'] as String?;
      cityTagline.value = (summary != null && summary.isNotEmpty)
          ? summary
          : 'Nova has curated the best spots in $city for your perfect day.';

      // Travel styles
      final dynamic stylesRaw = firebaseData['travelStyles'];
      if (stylesRaw is List) {
        userTravelStyles.value = stylesRaw.cast<String>();
      }

      AppLogger.success(
          '🗺️ Building plan for: $city | styles: ${userTravelStyles.join(", ")}',
          tag: 'PLAN_BUILD');

    // Step 2: Try DeepSeek AI first, then Wikipedia fallback
      await _buildItinerary(city, rawCountry);
    } catch (e) {
      AppLogger.error('Plan My Day load error', e);
      _useFallbackItinerary(cityName.value);
    } finally {
      isLoading.value = false;
    }
  }

  /// Step 2: Try DeepSeek → Wikipedia → Generic fallback
  Future<void> _buildItinerary(String city, String country) async {
    // ── Attempt 1: Groq AI (free) ─────────────────────────────────────────
    if (GroqService.isConfigured) {
      try {
        AppLogger.info('🤖 Calling Groq AI (Llama 3.3) for $city...', tag: 'GROQ');
        final aiResponse = await GroqService.generateDayPlan(
          city: city,
          country: country,
          travelStyles: userTravelStyles,
          locationContext: cityTagline.value,
        );

        if (aiResponse != null) {
          final items = _parseGeminiResponse(aiResponse, city);
          if (items.isNotEmpty) {
            itineraryItems.value = items;
            isGeminiPowered.value = true;
            AppLogger.success(
                '✨ Groq AI itinerary built: ${items.length} spots for $city',
                tag: 'GROQ_DONE');
            return;
          }
        }
      } catch (e) {
        AppLogger.error('Groq attempt failed, trying Wikipedia', e);
      }
    }

    // ── Attempt 2: Wikipedia spot search ─────────────────────────────────
    await _buildFromWikipedia(city);
  }

  /// Parse Gemini JSON response into PlanMyDayItems
  List<PlanMyDayItem> _parseGeminiResponse(String raw, String city) {
    try {
      // Strip markdown code fences if present
      String cleaned = raw.trim();
      if (cleaned.startsWith('```')) {
        cleaned = cleaned
            .replaceFirst(RegExp(r'```json?\s*'), '')
            .replaceAll(RegExp(r'```\s*$'), '')
            .trim();
      }

      final List<dynamic> data = json.decode(cleaned);
      final List<PlanMyDayItem> items = [];

      for (int i = 0; i < data.length && i < 5; i++) {
        final Map<String, dynamic> item = data[i];
        final String title = item['title'] as String? ?? 'Spot ${i + 1}';
        final String category = item['category'] as String? ?? 'attraction';
        final String distKm = item['distanceKm'] as String? ?? '2.0';

        items.add(PlanMyDayItem(
          id: '${i + 1}',
          timeTag: item['timeTag'] as String? ?? _defaultTimeSlots[i],
          distance: '$distKm km away',
          title: title,
          description: item['description'] as String? ??
              'A must-visit spot in $city curated by Nova AI.',
          novaInsight: item['novaInsight'] as String? ??
              'Nova recommends visiting this spot in the morning for the best experience.',
          icon: _iconForCategory(category),
          imageUrl: _unsplashForKeyword(title, category),
          category: category,
        ));
      }
      return items;
    } catch (e) {
      AppLogger.error('Gemini JSON parse error', e);
      return [];
    }
  }

  static const List<String> _defaultTimeSlots = [
    '08:30 AM — MORNING',
    '10:30 AM — LATE MORNING',
    '01:00 PM — LUNCH',
    '03:30 PM — AFTERNOON',
    '06:45 PM — EVENING',
  ];

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'nature':
      case 'park':
        return Icons.park_rounded;
      case 'culture':
      case 'museum':
        return Icons.museum_rounded;
      case 'food':
      case 'lunch':
      case 'restaurant':
        return Icons.restaurant_rounded;
      case 'evening':
      case 'sunset':
        return Icons.wb_twilight_rounded;
      case 'morning':
        return Icons.wb_sunny_rounded;
      case 'architecture':
        return Icons.architecture_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'leisure':
        return Icons.local_activity_rounded;
      default:
        return Icons.place_rounded;
    }
  }

  /// Wikipedia OpenSearch fallback
  Future<void> _buildFromWikipedia(String city) async {
    try {
      final searchUrl = Uri.parse(
          'https://en.wikipedia.org/w/api.php'
          '?action=opensearch&search=${Uri.encodeComponent("$city tourist attractions")}'
          '&limit=8&format=json&origin=*');

      final response =
          await http.get(searchUrl).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> titles =
            data.length > 1 ? (data[1] as List<dynamic>) : [];

        if (titles.isNotEmpty) {
          AppLogger.success('📚 Wikipedia spots for $city: ${titles.join(", ")}',
              tag: 'PLAN_WIKI');
          _buildItemsFromWikiTitles(city, titles);
          return;
        }
      }
    } catch (e) {
      AppLogger.error('Wikipedia fallback failed', e);
    }
    _useFallbackItinerary(city);
  }

  void _buildItemsFromWikiTitles(String city, List<dynamic> titles) {
    final icons = [
      Icons.wb_sunny_rounded,
      Icons.museum_rounded,
      Icons.restaurant_rounded,
      Icons.park_rounded,
      Icons.wb_twilight_rounded,
    ];
    final categories = ['morning', 'culture', 'food', 'nature', 'evening'];
    final distances = ['0.8 km', '2.3 km', '1.1 km', '3.5 km', '4.2 km'];

    final int spotCount = titles.length < 5 ? titles.length : 5;
    final List<PlanMyDayItem> items = [];

    for (int i = 0; i < spotCount; i++) {
      final spotName = (titles[i] as String)
          .replaceAll(RegExp(r'\s*\(.*?\)'), '')
          .trim();

      items.add(PlanMyDayItem(
        id: '${i + 1}',
        timeTag: _defaultTimeSlots[i],
        distance: distances[i],
        title: spotName,
        description:
            'Nova recommends $spotName in $city — a curated local gem '
            'matching your ${userTravelStyles.isNotEmpty ? userTravelStyles.take(2).join(" & ") : "travel"} style.',
        novaInsight:
            'Selected by Nova AI as a top pick in $city based on your adventure profile.',
        icon: icons[i],
        imageUrl: _unsplashForKeyword(spotName, categories[i]),
        category: categories[i],
      ));
    }

    if (items.length < 5) {
      items.addAll(_genericItems(city).take(5 - items.length));
    }
    itineraryItems.value = items;
  }

  /// Keyword → Unsplash image
  String _unsplashForKeyword(String title, String category) {
    final t = '${title.toLowerCase()} $category';
    if (t.contains('mosque') || t.contains('masjid')) {
      return 'https://images.unsplash.com/photo-1564769662533-4f00a87b4056?w=800';
    } else if (t.contains('park') || t.contains('garden') || t.contains('nature')) {
      return 'https://images.unsplash.com/photo-1506146332389-18140dc7b2fb?w=800';
    } else if (t.contains('museum') || t.contains('gallery') || t.contains('culture')) {
      return 'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=800';
    } else if (t.contains('market') || t.contains('bazar') || t.contains('food')) {
      return 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800';
    } else if (t.contains('river') || t.contains('lake') || t.contains('water')) {
      return 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800';
    } else if (t.contains('fort') || t.contains('palace') || t.contains('castle')) {
      return 'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=800';
    } else if (t.contains('university') || t.contains('college')) {
      return 'https://images.unsplash.com/photo-1498243691581-b145c3f54a5a?w=800';
    } else if (t.contains('temple') || t.contains('shrine')) {
      return 'https://images.unsplash.com/photo-1582190730060-b76e0bbc2c3b?w=800';
    } else if (t.contains('evening') || t.contains('sunset') || t.contains('twilight')) {
      return 'https://images.unsplash.com/photo-1449034446853-66c86144b0ad?w=800';
    } else if (t.contains('morning') || t.contains('cafe') || t.contains('coffee')) {
      return 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800';
    }
    return 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800';
  }

  void _useFallbackItinerary(String city) {
    itineraryItems.value = _genericItems(city);
  }

  List<PlanMyDayItem> _genericItems(String city) => [
        PlanMyDayItem(
          id: '1',
          timeTag: '08:30 AM — MORNING',
          distance: '1.2 km away',
          title: '$city City Center',
          description:
              'Start your morning at the vibrant heart of $city. Nova has mapped the most scenic walking route through the city\'s highlights.',
          novaInsight:
              'Best time to explore — fewer crowds and perfect golden morning light.',
          icon: Icons.wb_sunny_rounded,
          imageUrl: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800',
        ),
        PlanMyDayItem(
          id: '2',
          timeTag: '10:30 AM — LATE MORNING',
          distance: '2.5 km away',
          title: 'Heritage Quarter',
          description:
              'Explore $city\'s rich cultural heritage through its iconic architecture and historical landmarks.',
          novaInsight:
              'Nova AI found this as a top-rated cultural landmark in your area.',
          icon: Icons.account_balance_rounded,
          imageUrl: 'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=800',
        ),
        PlanMyDayItem(
          id: '3',
          timeTag: '01:00 PM — LUNCH',
          distance: '0.9 km away',
          title: 'Local Food Street',
          description:
              'Savour authentic local flavours at $city\'s most beloved street food destination — curated by Nova.',
          novaInsight:
              'Try the local specialties. Nova found this consistently rated 4.8+ by travellers.',
          icon: Icons.restaurant_rounded,
          imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
        ),
        PlanMyDayItem(
          id: '4',
          timeTag: '03:30 PM — AFTERNOON',
          distance: '3.1 km away',
          title: '$city Botanical Garden',
          description:
              'A peaceful escape into lush greenery — perfect for photography and quiet reflection.',
          novaInsight:
              'Golden-hour photography from 4 PM onward is spectacular here.',
          icon: Icons.park_rounded,
          imageUrl: 'https://images.unsplash.com/photo-1506146332389-18140dc7b2fb?w=800',
        ),
        PlanMyDayItem(
          id: '5',
          timeTag: '06:45 PM — EVENING',
          distance: '2.0 km away',
          title: '$city Riverside Walk',
          description:
              'End your perfect day with a sunset stroll along $city\'s scenic waterfront promenade.',
          novaInsight:
              'Nova selected this viewpoint for the best sunset panorama in the city.',
          icon: Icons.wb_twilight_rounded,
          imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800',
        ),
      ];

  void setActiveNode(int index) {
    activeNodeIndex.value = index;
  }

  @override
  Future<void> refresh() async {
    isGeminiPowered.value = false;
    await _loadFromFirebaseAndBuild();
  }
}

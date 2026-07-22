import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../mock/mock_data.dart';

class MockDataSeeder {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> seedInitialData() async {
    try {
      debugPrint('🌱 Checking Firestore Seeding status...');

      // 1. Seed User Profile
      final userDoc = _firestore.collection('users').doc('julian_d');
      final userSnap = await userDoc.get();
      if (!userSnap.exists) {
        await userDoc.set(MockData.profileUser);
        debugPrint('✅ Seeded user profile into Firestore');
      }

      // 2. Seed Plan My Day Itineraries
      final itineraryCol = _firestore.collection('itineraries');
      final itinerarySnap = await itineraryCol.get();
      if (itinerarySnap.docs.isEmpty) {
        final sampleStops = [
          {
            'order': 1,
            'time': '9:00 AM',
            'title': 'Coffee at The Mill',
            'location': '712 Divisadero St, San Francisco',
            'category': 'Coffee & Breakfast',
            'distanceText': '0.0 mi',
            'description': 'Famous for artisanal sourdough toasts and small-batch roasted coffee in a bright, minimalist space.',
            'imageUrl': 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
            'novaQuote': 'Try the wild blueberry sourdough toast paired with their single-origin Ethiopia drip.',
          },
          {
            'order': 2,
            'time': '11:00 AM',
            'title': 'Explore SFMOMA Modern Art',
            'location': '151 3rd St, San Francisco',
            'category': 'Museum & Art',
            'distanceText': '1.8 mi',
            'description': 'Seven floors of extraordinary modern and contemporary art installations and photography.',
            'imageUrl': 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=800',
            'novaQuote': 'Floor 3 living wall has 25,000 native plants—great spot for a quiet photo.',
          },
          {
            'order': 3,
            'time': '1:30 PM',
            'title': 'Waterfront Sourdough Lunch',
            'location': 'Ferry Building, Shop 11, SF',
            'category': 'Lunch Spot',
            'distanceText': '3.2 mi',
            'description': 'Iconic artisanal bakery with bay views, famous clam chowder bowls, and crispy crust baguettes.',
            'imageUrl': 'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=800',
            'novaQuote': 'Sit outdoor facing the Bay Bridge for optimal mid-day sunshine and marine breeze.',
          },
          {
            'order': 4,
            'time': '3:45 PM',
            'title': '15th Avenue Tiled Steps',
            'location': '16th Ave & Moraga St, SF',
            'category': 'Hidden Gem',
            'distanceText': '5.1 mi',
            'description': '163 mosaic-tiled steps depicting a sea-to-stars trajectory crafted by neighborhood artists.',
            'imageUrl': 'https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=800',
            'novaQuote': 'Climb to Grandview Park at the top for a 360-degree panoramic ocean sunset view.',
          },
          {
            'order': 5,
            'time': '6:15 PM',
            'title': 'Presidio Sunset Lookout',
            'location': 'Lincoln Blvd, San Francisco',
            'category': 'Scenic Viewpoint',
            'distanceText': '6.4 mi',
            'description': 'Golden Gate Bridge panoramic viewpoint set against pine trees and coastal cliffs.',
            'imageUrl': 'https://images.unsplash.com/photo-1506146332389-18140dc7b2fb?w=800',
            'novaQuote': 'Golden hour light hits the bridge span perfectly around 6:30 PM today.',
          },
        ];

        for (var stop in sampleStops) {
          await itineraryCol.add(stop);
        }
        debugPrint('✅ Seeded 5 itinerary stops into Firestore');
      }

      // 3. Seed Saved Collections
      final collectionsCol = _firestore.collection('collections');
      final collectionsSnap = await collectionsCol.get();
      if (collectionsSnap.docs.isEmpty) {
        for (var item in MockData.profileCollections) {
          await collectionsCol.add(item);
        }
        debugPrint('✅ Seeded saved collections into Firestore');
      }

      debugPrint('🎉 Firestore Seed Completed Successfully!');
    } catch (e) {
      debugPrint('⚠️ MockDataSeeder Notice: $e');
    }
  }
}

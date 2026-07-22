import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../core/mock/mock_data.dart';
import '../../core/services/mock_data_seeder.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = Rx<Map<String, dynamic>>(MockData.profileUser);
  final stats = Rx<List<Map<String, String>>>(MockData.profileStats);
  final collections = Rx<List<Map<String, String>>>(MockData.profileCollections);
  final achievements = Rx<List<Map<String, dynamic>>>(MockData.profileAchievements);
  final settings = Rx<List<Map<String, dynamic>>>(MockData.profileSettings);

  @override
  void onInit() {
    super.onInit();
    _initFirebaseAndListen();
  }

  Future<void> _initFirebaseAndListen() async {
    try {
      // Seed initial data if database is empty
      await MockDataSeeder.seedInitialData();

      // Listen to live user profile changes in Firestore
      _firestore.collection('users').doc('julian_d').snapshots().listen((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          user.value = snapshot.data()!;
        }
      });
    } catch (e) {
      debugPrint('Firestore Profile Listen Info: $e');
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String bio,
    required String location,
    required String website,
  }) async {
    final updated = Map<String, dynamic>.from(user.value);
    updated['name'] = name;
    updated['bio'] = bio;
    updated['tagline'] = bio;
    updated['location'] = location;
    updated['website'] = website;

    // Local reactive update
    user.value = updated;

    // Push live update to Cloud Firestore
    try {
      await _firestore.collection('users').doc('julian_d').set(updated, SetOptions(merge: true));
      debugPrint('☁️ Profile updated live in Cloud Firestore!');
    } catch (e) {
      debugPrint('Firestore Update Error: $e');
    }
  }
}

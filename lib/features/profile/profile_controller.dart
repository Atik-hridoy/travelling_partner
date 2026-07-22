import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../core/mock/mock_data.dart';
import '../../core/services/mock_data_seeder.dart';
import '../../core/services/app_logger.dart';
import '../auth/auth_service.dart';

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
      // 1. Seed initial mock data if necessary
      try {
        await MockDataSeeder.seedInitialData();
      } catch (e) {
        debugPrint('Mock data seeder notice: $e');
      }

      // 2. Identify target user ID (Current Logged In User or fallback to demo)
      final uid = AuthService.currentUser?.uid ?? 'julian_d';

      // 3. Safe Stream Listen with onError handler to avoid app crashes
      _firestore.collection('users').doc(uid).snapshots().listen(
        (snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            user.value = snapshot.data()!;
            AppLogger.info('👤 Profile synced live from Firestore: /users/$uid', tag: 'FIRESTORE_SYNC');
          }
        },
        onError: (error) {
          AppLogger.error('Firestore Profile Stream Warning', error);
        },
      );
    } catch (e) {
      debugPrint('Firestore Profile Initialization Notice: $e');
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String bio,
    required String location,
    required String website,
    String? avatar,
    List<String>? travelStyles,
  }) async {
    final updated = Map<String, dynamic>.from(user.value);
    updated['name'] = name;
    updated['bio'] = bio;
    updated['tagline'] = bio;
    updated['location'] = location;
    updated['website'] = website;
    if (avatar != null && avatar.isNotEmpty) {
      updated['avatar'] = avatar;
      updated['imageUrl'] = avatar;
    }
    if (travelStyles != null) {
      updated['travelStyles'] = travelStyles;
    }

    // Local reactive update
    user.value = updated;

    // Push live update to Cloud Firestore for current user
    final uid = AuthService.currentUser?.uid;
    if (uid != null) {
      try {
        await _firestore.collection('users').doc(uid).set(updated, SetOptions(merge: true));
        AppLogger.success('🔥 CLOUD FIRESTORE SAVE SUCCESS!', tag: 'FIRESTORE_SAVE');
        AppLogger.success('Document Path: /users/$uid', tag: 'FIRESTORE_PATH');
      } catch (e) {
        AppLogger.error('Firestore Profile Update Failed for real UID: $uid', e);
      }
    } else {
      // If demo mode (no real user logged in), write to julian_d safely
      try {
        await _firestore.collection('users').doc('julian_d').set(updated, SetOptions(merge: true));
        AppLogger.success('🔥 CLOUD FIRESTORE SAVE SUCCESS (Demo Mode)!', tag: 'FIRESTORE_SAVE');
        AppLogger.success('Document Path: /users/julian_d', tag: 'FIRESTORE_PATH');
      } catch (e) {
        AppLogger.error('Firestore Profile Update Failed for julian_d', e);
      }
    }
  }
}

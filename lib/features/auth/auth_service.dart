import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// ------------------------------------------------------------------
/// Simple Firebase Authentication & Firestore User Data Helper Service
/// ------------------------------------------------------------------
class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current Firebase user
  static User? get currentUser => _auth.currentUser;

  /// 1. Create a new user account with Email & Password in Firebase Auth,
  /// and save their full profile information to Cloud Firestore 'users' collection.
  static Future<UserCredential> signUpWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
  }) async {
    // Step A: Create user in Firebase Authentication
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final User? user = credential.user;

    if (user != null) {
      // Step B: Save user profile details in Cloud Firestore 'users' collection
      final userProfileData = {
        'uid': user.uid,
        'name': fullName.trim(),
        'email': email.trim(),
        'bio': 'Curating the Unseen',
        'tagline': 'Curating the Unseen',
        'location': 'San Francisco, CA',
        'website': 'voyanta.travel/user',
        'memberBadge': 'NEW VOYAGER',
        'avatarUrl': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('users').doc(user.uid).set(userProfileData);
      
      // Also update default 'julian_d' document for instant demo fallback
      await _firestore.collection('users').doc('julian_d').set(userProfileData, SetOptions(merge: true));

      debugPrint('🔥 Firebase User registered and saved to Firestore: ${user.uid}');
    }

    return credential;
  }

  /// 2. Sign In an existing user with Email & Password via Firebase Auth
  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    debugPrint('🔑 Firebase User logged in: ${credential.user?.uid}');
    return credential;
  }

  /// 3. Sign Out current user from Firebase
  static Future<void> signOut() async {
    await _auth.signOut();
    debugPrint('👋 Firebase User signed out');
  }
}

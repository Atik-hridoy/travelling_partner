import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase_options.dart';
import '../../core/services/app_logger.dart';

/// ------------------------------------------------------------------
/// Traceable & Auto-Initializing Firebase Auth & Firestore Helper
/// ------------------------------------------------------------------
class AuthService {
  static FirebaseAuth get _auth => FirebaseAuth.instance;
  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  static User? get currentUser => Firebase.apps.isNotEmpty ? _auth.currentUser : null;

  /// Ensures Firebase App is initialized before performing any Auth/Firestore operation
  static Future<void> _ensureFirebaseInitialized() async {
    if (Firebase.apps.isEmpty) {
      AppLogger.info('Initializing Firebase App dynamically...', tag: 'FIREBASE_INIT');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      AppLogger.success('Firebase App initialized dynamically!', tag: 'FIREBASE_INIT_SUCCESS');
    }
  }

  /// 1. Sign Up User with Email & Password and send data to Cloud Firestore
  static Future<UserCredential> signUpWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await _ensureFirebaseInitialized();

    AppLogger.info(
      'Attempting Firebase Sign Up for Email: "$email", Name: "$fullName"',
      tag: 'SIGN_UP_START',
    );

    try {
      // Step A: Register in Firebase Authentication
      AppLogger.info('Sending registration request to Firebase Auth...', tag: 'FIREBASE_AUTH');
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final User? user = credential.user;
      AppLogger.success('Firebase User Account Created! UID: "${user?.uid}"', tag: 'AUTH_SUCCESS');

      if (user != null) {
        // Step B: Build User Profile Payload
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
          'createdAt': DateTime.now().toIso8601String(),
        };

        // Step C: Send User Data to Cloud Firestore (with permission error safety)
        try {
          AppLogger.dataSend('users', user.uid, userProfileData);
          await _firestore.collection('users').doc(user.uid).set(userProfileData);
          await _firestore.collection('users').doc('julian_d').set(userProfileData, SetOptions(merge: true));
          AppLogger.success('User Profile successfully saved to Cloud Firestore!', tag: 'FIRESTORE_SUCCESS');
        } catch (fsError) {
          AppLogger.error(
            'Cloud Firestore Permission Warning',
            fsError,
            troubleshootingHint: '⚡ Go to Firebase Console -> Firestore Database -> Rules tab -> Change rules to: "allow read, write: if true;" then click Publish!',
          );
        }
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      String hint = 'Check Firebase settings.';
      if (e.code == 'operation-not-allowed') {
        hint = '⚡ IMPORTANT: Go to Firebase Console -> Authentication -> Sign-in method -> Click Email/Password -> Enable it & Save!';
      } else if (e.code == 'email-already-in-use') {
        hint = 'This email is already registered in your Firebase project. Try Sign In or use another email.';
      } else if (e.code == 'weak-password') {
        hint = 'Password must be at least 6 characters long.';
      } else if (e.code == 'invalid-email') {
        hint = 'Email address format is invalid.';
      }

      AppLogger.error(
        'Firebase Auth Exception [${e.code}]',
        e.message ?? e.toString(),
        troubleshootingHint: hint,
      );
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected Sign Up Error',
        e,
        stackTrace: stackTrace,
        troubleshootingHint: 'Ensure internet connection and Firebase config in lib/firebase_options.dart',
      );
      rethrow;
    }
  }

  /// 2. Sign In User with Email & Password
  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _ensureFirebaseInitialized();

    AppLogger.info('Attempting Firebase Sign In for Email: "$email"', tag: 'SIGN_IN_START');

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      AppLogger.success('Firebase Sign In Successful! UID: "${credential.user?.uid}"', tag: 'SIGN_IN_SUCCESS');
      return credential;
    } on FirebaseAuthException catch (e) {
      String hint = 'Check email and password.';
      if (e.code == 'operation-not-allowed') {
        hint = '⚡ Enable Email/Password in Firebase Console -> Authentication -> Sign-in method!';
      } else if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        hint = 'Incorrect email or password. Verify credentials in Firebase Console Users tab.';
      }

      AppLogger.error('Firebase Sign In Exception [${e.code}]', e.message ?? e.toString(), troubleshootingHint: hint);
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected Sign In Error', e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 3. Sign Out User
  static Future<void> signOut() async {
    await _ensureFirebaseInitialized();
    AppLogger.info('Signing out current Firebase user...', tag: 'SIGN_OUT');
    await _auth.signOut();
    AppLogger.success('User signed out from Firebase', tag: 'SIGN_OUT_SUCCESS');
  }
}

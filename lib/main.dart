import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('🔥 Firebase Initialized Successfully with fir-ea35c (demo)!');
  } catch (e) {
    debugPrint('ℹ️ Firebase Setup Notice: $e');
  }

  runApp(const VoyentaApp());
}

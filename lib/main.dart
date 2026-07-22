import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    debugPrint('🔥 Firebase Initialized Successfully!');
  } catch (e) {
    debugPrint('ℹ️ Firebase Setup Notice: Running in Mock Mode until config added ($e)');
  }

  runApp(const VoyentaApp());
}

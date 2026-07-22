import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/colors.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/app_pages.dart';

class VoyentaApp extends StatelessWidget {
  const VoyentaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Voyanta Travel OS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: VoyentaColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: VoyentaColors.primary,
          primary: VoyentaColors.primary,
          secondary: VoyentaColors.secondary,
          background: VoyentaColors.background,
          surface: VoyentaColors.surface,
          error: VoyentaColors.error,
        ),
      ),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}

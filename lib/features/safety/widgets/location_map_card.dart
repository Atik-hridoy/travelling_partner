import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/typography.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class LocationMapCard extends StatelessWidget {
  const LocationMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuC0ppC3heIO_66W51qOoZstQ--PmQ5KFFwwtWXFZPcmrMM968z8Ggwi8L1bmIcgQuxyl7tzmuzX8dd_jyfKnWK47ER_8CS1dKfONcVG1sN6tL5vciRNMZZGs7G3Mh-f66NxFUpReXv-1LvvSlFIyxDtAvSDBurv9BTPbG0ZBmzYyOEe4StJpEN2NnoIQwy5N19F-oXUG5ppLgMdP7FErsJlzjJH7cTKTe4GY675D7DvB_Br3bSTlnmCdZawWLx7x3BRPgg8S27uYiFW',
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'CURRENT LOCATION',
              style: VoyentaTypography.labelCaps.copyWith(
                color: Colors.white70,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Shibuya City, Tokyo, Japan',
              style: VoyentaTypography.headlineMd.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // Navigate to Map tab
                Get.find<DashboardController>().changeTabIndex(1);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Text(
                  'EXPAND MAP',
                  style: VoyentaTypography.labelCaps.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

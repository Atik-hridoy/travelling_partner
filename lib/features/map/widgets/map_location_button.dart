import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../map_controller.dart';

class MapLocationButton extends StatelessWidget {
  const MapLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<MapController>();

    return Positioned(
      right: 16,
      bottom: 360, // Moved further up as requested
      child: Obx(() => Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: ctrl.isLocationFetching.value ? null : ctrl.goToCurrentLocation,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: ctrl.isLocationFetching.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey),
                      ),
                    )
                  : const Icon(
                      Icons.my_location_rounded,
                      color: Colors.black54, // Standard Google Maps grey
                      size: 24,
                    ),
            ),
          ),
        ),
      )),
    );
  }
}

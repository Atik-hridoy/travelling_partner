import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/routes/app_routes.dart';

class MapInsightButton extends StatelessWidget {
  const MapInsightButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 280,
      right: 16,
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.AI_ASSISTANT),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: VoyentaColors.primaryContainer,
            boxShadow: [
              BoxShadow(
                color: VoyentaColors.primary.withOpacity(0.4),
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.bolt, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}

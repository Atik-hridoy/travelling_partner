import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class EditPhotoHeader extends StatelessWidget {
  final String imageUrl;
  final String? localPath;
  final VoidCallback onChangePhoto;

  const EditPhotoHeader({
    super.key,
    required this.imageUrl,
    this.localPath,
    required this.onChangePhoto,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasLocalFile = localPath != null && localPath!.isNotEmpty && File(localPath!).existsSync();

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: hasLocalFile
                      ? Image.file(
                          File(localPath!),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: VoyentaColors.primaryContainer,
                              child: const Icon(Icons.person, size: 50, color: Colors.white),
                            );
                          },
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onChangePhoto,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: VoyentaColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.photo_camera_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onChangePhoto,
            child: Text(
              'Change Photo',
              style: VoyentaTypography.labelCaps.copyWith(
                color: VoyentaColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

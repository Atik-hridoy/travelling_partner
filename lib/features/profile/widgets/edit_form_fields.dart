import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

class EditFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController bioController;
  final TextEditingController locationController;
  final TextEditingController websiteController;
  final VoidCallback? onDetectLocation;
  final bool isDetectingLocation;

  const EditFormFields({
    super.key,
    required this.nameController,
    required this.bioController,
    required this.locationController,
    required this.websiteController,
    this.onDetectLocation,
    this.isDetectingLocation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormFieldLabel('FULL NAME'),
        _buildTextField(nameController),

        const SizedBox(height: 16),

        _buildFormFieldLabel('BIO'),
        _buildTextField(bioController, maxLines: 3),

        const SizedBox(height: 16),

        _buildFormFieldLabel('LOCATION (TAP GPS ICON TO FETCH)'),
        _buildTextField(
          locationController,
          prefixIcon: Icons.location_on_outlined,
          readOnly: true,
          onTap: isDetectingLocation ? null : onDetectLocation,
          suffixWidget: IconButton(
            icon: isDetectingLocation
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: VoyentaColors.primary,
                    ),
                  )
                : const Icon(
                    Icons.my_location_rounded,
                    color: VoyentaColors.primary,
                    size: 22,
                  ),
            tooltip: 'Fetch Current GPS Location',
            onPressed: isDetectingLocation ? null : onDetectLocation,
          ),
        ),

        const SizedBox(height: 16),

        _buildFormFieldLabel('WEBSITE'),
        _buildTextField(websiteController, prefixIcon: Icons.link_rounded),
      ],
    );
  }

  Widget _buildFormFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
      child: Text(
        label,
        style: VoyentaTypography.labelCaps.copyWith(
          color: VoyentaColors.onSurfaceVariant,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    IconData? prefixIcon,
    Widget? suffixWidget,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        style: VoyentaTypography.bodyMd.copyWith(
          color: VoyentaColors.onSurface,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: VoyentaColors.onSurfaceVariant, size: 20) : null,
          suffixIcon: suffixWidget,
          hintText: readOnly ? 'Tap GPS button to fetch location...' : null,
          hintStyle: VoyentaTypography.bodyMd.copyWith(
            color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.5),
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

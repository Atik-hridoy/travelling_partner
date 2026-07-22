import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/special_requirements_widgets.dart';

class SpecialRequirementsStep extends GetView<TripWizardController> {
  const SpecialRequirementsStep({super.key});

  @override
  Widget build(BuildContext context) {
    // Local state for this UI (could be moved to controller if needed for logic)
    final dietary = <String>[].obs;
    final accessibility = <String>[].obs;
    final family = <String>[].obs;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Any special requirements?',
            style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            'Help your Invisible Concierge tailor every detail to your personal needs and preferences for a seamless journey.',
            style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
          ),
          const SizedBox(height: 40),

          // Dietary Preferences
          SpecialRequirementsSection(
            title: 'Dietary Preferences',
            icon: Icons.restaurant,
            content: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SpecialRequirementChip(label: 'Vegetarian', icon: Icons.eco, selection: dietary),
                SpecialRequirementChip(label: 'Halal', icon: Icons.verified_user, selection: dietary),
                SpecialRequirementChip(label: 'Vegan', icon: Icons.psychology, selection: dietary),
                SpecialRequirementChip(label: 'Kosher', icon: Icons.flatware, selection: dietary),
                SpecialRequirementChip(label: 'Gluten-Free', icon: Icons.emergency, selection: dietary),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Accessibility & Family
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SpecialRequirementsSection(
                title: 'Accessibility',
                icon: Icons.accessible,
                content: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SpecialRequirementChip(label: 'Wheelchair', icon: Icons.accessible_forward, selection: accessibility),
                    SpecialRequirementChip(label: 'Visual Aid', icon: Icons.visibility_off, selection: accessibility),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SpecialRequirementsSection(
                title: 'Family',
                icon: Icons.family_restroom,
                content: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SpecialRequirementChip(label: 'Kids Friendly', icon: Icons.child_care, selection: family),
                    SpecialRequirementChip(label: 'Stroller Access', icon: Icons.stroller, selection: family),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Custom Notes
          SpecialRequirementsSection(
            title: 'Custom Notes',
            icon: Icons.edit_note,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  maxLines: 5,
                  style: VoyentaTypography.bodyMd,
                  decoration: InputDecoration(
                    hintText: "Allergies, specific interests, or any other details you'd like us to know...",
                    hintStyle: TextStyle(color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.4)),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: VoyentaColors.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: VoyentaColors.primary, width: 2),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 80, right: 16), // Bottom right alignment
                      child: Icon(Icons.auto_fix_high, color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.2), size: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('ENCRYPTED & PRIVATE', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6), fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Visual Context Card
          Container(
            height: 192,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                image: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAcDXaddsETByVQVHdqWfGiPCISwVkKgGp47Du0UMxMGg_reYLA_nW38lJ72lZrN9cqMWiLCWi68TiyA8x46HeJ8ah7psWald_W3mVMHWwnCiHAlskJwtD1z9t-Yorg3Rvwbo51OrUhajnQRcWVfN8yxrAN1xVykcZsmJqyzs9-CXC-zIImvpNAz0pS5SkyQuyA8FvCLLw442hjQja7Qsre9h8RipfIpEe9xY-SCiN60ecEux0WLweaCVH9LGbcpbtTCVniSlMGLpXE'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  VoyentaColors.primary.withValues(alpha: 0.6),
                  BlendMode.srcATop,
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 24,
                  left: 32,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        child: const Icon(Icons.verified, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tailored Just for You', style: VoyentaTypography.headlineMd.copyWith(color: Colors.white)),
                          Text('Your preferences shape every recommendation.', style: VoyentaTypography.bodyMd.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

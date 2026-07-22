import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/mock/mock_data.dart';
import '../onboarding_controller.dart';

class InterestsStep extends StatelessWidget {
  final OnboardingController controller;

  const InterestsStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> detailsList = MockData.onboardingInterests;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    // Dynamically adjust Grid cross axis count and aspect ratio based on width for tablet responsiveness
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;
    final double childAspectRatio = screenWidth > 400 ? 1.25 : 1.1;

    return Scaffold(
      backgroundColor: VoyentaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: VoyentaColors.primary, size: 20),
          onPressed: () => controller.prevStep(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step 1 of 3',
              style: VoyentaTypography.labelCaps.copyWith(
                color: VoyentaColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Interests',
              style: VoyentaTypography.monoTechnical.copyWith(
                color: VoyentaColors.outline,
                fontSize: 11,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: const LinearProgressIndicator(
                value: 0.33,
                minHeight: 5,
                backgroundColor: VoyentaColors.surfaceContainerHigh,
                valueColor: AlwaysStoppedAnimation<Color>(VoyentaColors.primary),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Content Header
              Center(
                child: Column(
                  children: [
                    Text(
                      'What defines your journey?',
                      textAlign: TextAlign.center,
                      style: VoyentaTypography.displayLgMobile.copyWith(
                        color: VoyentaColors.onSurface,
                        fontWeight: FontWeight.w800,
                        fontSize: screenHeight < 700 ? 22 : 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select at least three interests to help our AI craft your perfect itinerary.',
                      textAlign: TextAlign.center,
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: VoyentaColors.onSurfaceVariant,
                        fontSize: screenHeight < 700 ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Bento Grid of cards
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: detailsList.length,
                  itemBuilder: (context, index) {
                    final item = detailsList[index];
                    final name = item['name'] as String;
                    final icon = item['icon'] as IconData;
                    final desc = item['desc'] as String;

                    return Obx(() {
                      final isSelected = controller.selectedInterests.contains(name);
                      return GestureDetector(
                        onTap: () => controller.toggleInterest(name),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? VoyentaColors.primary.withOpacity(0.06)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? VoyentaColors.primary
                                  : VoyentaColors.outlineVariant.withOpacity(0.4),
                              width: isSelected ? 2.0 : 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Active checkmark badge top right
                              if (isSelected)
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: VoyentaColors.primary,
                                    size: 18,
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: VoyentaColors.primary.withOpacity(0.08),
                                    ),
                                    child: Icon(icon, color: VoyentaColors.primary, size: 20),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    name,
                                    style: VoyentaTypography.bodyMd.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: VoyentaColors.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    desc,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: VoyentaTypography.bodyMd.copyWith(
                                      color: VoyentaColors.onSurfaceVariant.withOpacity(0.8),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Continue button
              CustomButton(
                text: 'Continue',
                onPressed: () => controller.nextStep(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

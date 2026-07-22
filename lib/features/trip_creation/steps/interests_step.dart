import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/interest_card.dart';

class InterestsStep extends GetView<TripWizardController> {
  const InterestsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / AI Recommendation
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerLowest.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: VoyentaColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.auto_awesome, color: VoyentaColors.onPrimary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI RECOMMENDATION', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.primary)),
                      const SizedBox(height: 8),
                      Text(
                        'Based on your style, we recommend these curated experiences for your journey.',
                        style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select the interests that resonate with you to help our Invisible Concierge refine your daily itinerary.',
                        style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
            children: const [
              InterestCard(
                title: 'Museums',
                icon: Icons.museum,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAgVwJeNcJX4-HEL-3q_rEKBSop4o03A5Kxalt_G3pZw5oNkXm_GPwXaw7JQX3zi4Eghivw-Gze2hdr7B0Td_gffVf4j5TrxKbAY9vRq8Pe-aEXwQWPV_uS9fXZ2tbzTBdAwaKNamHAT6naEQ6x0H7cL8eY8AjlMr6dPdbYJ4dLgQaLAy9JuYhiRQyQPs5xhAeGnAG_9tDQnf1QIZ9t-SBww8a3y93fJBXy1YLve5uKFoU8CrTwPHMw3HyO7Xz79qws4jguLJ1OX2tv',
              ),
              InterestCard(
                title: 'Temples',
                icon: Icons.temple_buddhist,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBMlCsvjgYIK0wjfGNEUIvspJL9Z4tMLK6hbPkNX50KUL352PUrD410t8M3JiYtqIGfJ8702uWNKXMS5-WuE859RLwaFI9KwWsAygC98fJ5_3QSfrun27ezv_iMEXeH6Jl6CfRIy7b_Y6m6Rx9cXQMOUmkYgT8x-8c8bTA9_A3OG7zJq2v87a5YvMiY2If0_im0iE-wApSG_NSgU1kWr_ibRwZzCKydDawDjFGOT0H4Pqow4Yw_niWTUyf-8rO3LOQYDOTDAsQA2yfg',
              ),
              InterestCard(
                title: 'Local Food',
                icon: Icons.restaurant,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB3hHd0_Z-bpvdTsbpvrB1eTCQ3YD_oBnqy_0mI0Syq06djYKbqpl6PC_gEMeyYy5DdbvUYTAxwSjRnAgrRknmAg1zj2D3_b-UvqSqAo2O57qHip1epGhncNVEClmzuDZPjQfQHnvWbbFSc_5K0b8hRh6xUFATuQxRMq8Vmn-GFswaGSY7MrGW17JgO3U7-QEPy3SzUgw3HraMR1fioSO61tOTnkqngU6RDta4Xu42k78_CO6yb9-jTWmlGhEUdbrdt1HwoM65UR87H',
              ),
              InterestCard(
                title: 'Hiking',
                icon: Icons.hiking,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB3BAMkZylO5xMX--DvIFChvEajM0Zlr4nITvYc5-O3jRdH4l2sZjS4557BK8neaOUo11N0E82Xf3VowzDSgF9VFhFC88MLCBtQzcEQ6lPw2KqfLc_nOSgnp_PktCLTVKTT0JI00z-hQZlZnRRZ1qDQPRyO3fEO7KRgGvIDk0R-Q8Dg7BFrynBwSvyP7DPtwCQbJzay3grYEWRM7Uet8tVXpnhFyeVMacIXv-1YAH5P_5ulbh5-qd9VwyB4gomY-W7wDF5PUu52dP-7',
              ),
              InterestCard(
                title: 'Nightlife',
                icon: Icons.nightlife,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDQMyuU3DAQ-I6Qucwp2XNa0wXV4jN6-nWYmwaDH4r9lBox9P95XX0AQeGoGdLE3CSjVYjs-D8zABh2fm9pZRA5ktU-tTzwIX0iNJIKkRvJ1yDNoTr9rz-t2uT6I6ip2xskupp680raZ_iWa-fDUbLjf_1AznYJnZBFz_YeeTL5aczCN8Rkdzl-_hTyzaM5l41XIVacnliQXdStN_NzD_WfiwjxnPGniCXptwMUcwyDPgo2UueTTyjauVquWLYdptQedvmN0DBK6Uxs',
              ),
              InterestCard(
                title: 'Shopping',
                icon: Icons.shopping_bag,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBBhiT2nnkQahkEDRE64fhcdWSo0j5e1V_EBeSn2RWb0oNXGt2DLs2R97IMc10KE9LqZfeL3V93URMpmYwY20laAeck0Ozxnv9P3w8y9Je00onhYBBciRX6mEXdfOsIZanGvjN01OzZ4jTOjHMVO6yGQt4BgJnS1UJqLDwlHyBUzRgCsbNr4p6QrkI_ryrhKkpNxe2u0Kh6epwPXYJ3CAsKUZFOKXO18NGPbpEq_54s3T5BoxMFL3LTWsaM_mNSlaeNtTD3G5umGtUv',
              ),
              InterestCard(
                title: 'Wellness',
                icon: Icons.spa,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCu2bN1wWphULqNqjd7KOXbKLYu8n9531RWU-0AP8mJ_T8RiJwMo5YSetgsyAd2j-Bzm5FfPlhEb3X-h-6qVD5FiJHDmRvKDhNXulY7q1mHR9Uv0HS8Ajx7UtiWYNwYDq2Xvlcn3qsngJRASo8Y6XCH7MOTKLqcFf9sHjd33rnt57HuVYR-KqDCpJSE1BPO-MnRoJtZ9HQwZ2-vVselyA5j65voM804RVOhrCHszu5M_lRwWrYwbfgyd2A2pxqJJITJf8Xi-uurRbVb',
              ),
              InterestCard(
                title: 'Architecture',
                icon: Icons.architecture,
                imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAOSG6lJQITQy1tX1jet46X7E6V8U9mogKK_AikzEMX9kF0AA3zvJTDFT4Jj5r-SLrB1euC4UZrrEY4BrWU_-7qi0MvL9hxPKgeb5mLsFwC7jHOm-MN9SrYvlb7bBH5X4f0kTjr2SQb3jsdjnUlikZ9cpmeh1kFaqKWSL2lbVI-qWGCfxFUCrmoxYmF-4VVU_Zs2MjYNOz2fPQfOUXL8GkDHV0BDOodFZvPS-0_cUkvVrXjPhqzs9huW0OOqMfNSoH4R4Pd4vw3z2JO',
              ),
            ],
          ),
          const SizedBox(height: 48),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: VoyentaColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: VoyentaColors.outlineVariant.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.insights, color: VoyentaColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text('AI is analyzing selection patterns...', style: VoyentaTypography.monoTechnical.copyWith(color: VoyentaColors.onSurfaceVariant)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

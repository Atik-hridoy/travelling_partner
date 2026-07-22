import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/custom_button.dart';

class AiTravelerBudgetSelector extends StatefulWidget {
  final Function(String) onSelected;

  const AiTravelerBudgetSelector({super.key, required this.onSelected});

  @override
  State<AiTravelerBudgetSelector> createState() => _AiTravelerBudgetSelectorState();
}

class _AiTravelerBudgetSelectorState extends State<AiTravelerBudgetSelector> {
  String selectedTraveler = 'Couple';
  double budgetLevel = 2; // 1 = Budget, 2 = Comfort, 3 = Luxury, 4 = Ultra

  final budgetLevels = {
    1: {'cost': 150, 'label': 'Budget', 'desc': 'Backpacker style, hostels, and street food.', 'includes': ['Hostels', 'Walking', 'Street Food']},
    2: {'cost': 450, 'label': 'Comfort', 'desc': 'Essential comfort and local gems.', 'includes': ['3★ Hotels', 'Public Transport', 'Bistros']},
    3: {'cost': 1200, 'label': 'Luxury', 'desc': 'Premium stays and private experiences.', 'includes': ['5★ Resorts', 'Private Drivers', 'Fine Dining']},
    4: {'cost': 2500, 'label': 'Ultra', 'desc': 'Ultimate exclusivity and bespoke service.', 'includes': ['Palatial Suites', 'Helicopters', 'Michelin Dining']},
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Travelers Section
        Text('Travelers', style: VoyentaTypography.titleMd.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
          children: [
            _buildTravelerCard(
              'Solo',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAXJpSMNbA1h1wo7erFqPCsACeN-uFRpZ96dU19aayzLXBuVHP5r2SazRwmPPgv53R2Vrqg2yvIMyelELWQzBGCLkzbRkEjogWTv3QaSMKXTRUm8_orp3aYj6U4hCCiypGHgES-TWh-UFM34clm16veg9oyiyFhI8p6IPyZSPdJA0lWPM_IlONdkv_NHDWESffFcib1ZpHQKlihvmcloQCxPxVqb7QiYwXQ5VyW3rUOsczgxtQ9C_TX9Wig_wowbQQKrVev0K88YNOU',
            ),
            _buildTravelerCard(
              'Couple',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCodfm7nrR-ylmm0lBYC6t5oeoHcPoOIYYo-sW2MdAsMMJHCuUPhbpdBb1Y0eKUJVR3mWfFagfHno27UqK7K3Oy4jg3ioPUXFaqGNpUBUuJkJgGPfJ0En34Mxsxa_I2dUcGnuMPQGdiqTT57fq-zgRaFM8NCKiQdXUB0hXFBVV2JdKeWE_qTkl9bp8s6JfPpLkR_ZR27zkZ_XeWXV6SvE0rCBIBEy8DBJ0hqIWAUu6JM_Bn2MLWpexPhw-10AmiSiyAfEH4WRSraYSE',
            ),
            _buildTravelerCard(
              'Family',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCdjqw23eStAsVoEufelDFnoJtfMbv84eEx7t_dSRWEhUN8e2HQGCF3lsSOlBC07SAv5z2zQ4ZZr2kdS3h0LtLkz7iLzH7f47BjvglTPgtdlcWodteJXi6q4KlD4h1HPZ5XnXdjl3uDF4B_Y0iX6Qf-tkZjpM5RXO_l1-Gy2QzlSW1cx8AHWigBbxxkENE4WGR7pl3Z5I06qqWhLhD8CN4yd0Y8Em_f2PrAghw8b5ArNarp2vv9-TMkHtOr0PQWO-a_5rh6P7sHLk70',
            ),
            _buildTravelerCard(
              'Group',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDFD6u4LUJ25zSubOHy9C4PQsO9nf896sHBWLYDlZ6IuNEfWCstP5qg_OGQmj9C3rGbdLA8v0HT05aARojIRay3tGriT79ZvDAqZu5fod9QOoF-_56gewbo1pcoWjhMZ-E0RvotB_eP-FvKeEM_ucl6lwOSIgQ8ptxbtaPSutLZ6P_BYq1zoRKC7O0YpqFRb_S1nESm0bDchbpdXpH-ptLvGvO1a4KmcYYieSrZ4JWmbBjUa7Zn3dnXVXa6sfIR4bqv9XE6m6OKQBxS',
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Budget Section
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: VoyentaColors.primary.withValues(alpha: 0.05),
                    blurRadius: 40,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Budget Level', style: VoyentaTypography.titleMd.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(
                              budgetLevels[budgetLevel.toInt()]!['desc'] as String,
                              style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${budgetLevels[budgetLevel.toInt()]!['cost']}',
                            style: VoyentaTypography.headlineLg.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold),
                          ),
                          Text('EST. DAILY TOTAL', style: VoyentaTypography.labelSm.copyWith(color: VoyentaColors.onSurfaceVariant.withValues(alpha: 0.6))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Custom Slider
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: VoyentaColors.primary,
                      inactiveTrackColor: VoyentaColors.surfaceVariant,
                      thumbColor: VoyentaColors.primary,
                      overlayColor: VoyentaColors.primary.withValues(alpha: 0.1),
                      trackHeight: 6,
                    ),
                    child: Slider(
                      value: budgetLevel,
                      min: 1,
                      max: 4,
                      divisions: 3,
                      onChanged: (v) => setState(() => budgetLevel = v),
                    ),
                  ),
                  
                  // Slider Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBudgetLabel('Budget', 1),
                      _buildBudgetLabel('Comfort', 2),
                      _buildBudgetLabel('Luxury', 3),
                      _buildBudgetLabel('Ultra', 4),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Includes Chips
                  Text('INCLUDES', style: VoyentaTypography.labelSm.copyWith(color: VoyentaColors.onSurfaceVariant, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (budgetLevels[budgetLevel.toInt()]!['includes'] as List<String>)
                        .map((include) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: VoyentaColors.primary),
                                color: VoyentaColors.primaryContainer.withValues(alpha: 0.1),
                              ),
                              child: Text(
                                include,
                                style: VoyentaTypography.labelSm.copyWith(color: VoyentaColors.primary),
                              ),
                            ))
                        .toList(),
                  ),
                  
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Confirm Budget',
                    onPressed: () {
                      widget.onSelected("$selectedTraveler, ${budgetLevels[budgetLevel.toInt()]!['label']} Budget");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildTravelerCard(String title, String imageUrl) {
    final isSelected = selectedTraveler == title;
    
    return GestureDetector(
      onTap: () => setState(() => selectedTraveler = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? VoyentaColors.primary.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? VoyentaColors.primary : Colors.white.withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: VoyentaColors.primary.withValues(alpha: 0.2),
                blurRadius: 10,
              ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                title.toUpperCase(),
                style: VoyentaTypography.labelSm.copyWith(
                  color: VoyentaColors.onSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetLabel(String label, int value) {
    final isActive = value == budgetLevel.toInt();
    return Text(
      label,
      style: VoyentaTypography.labelSm.copyWith(
        color: isActive ? VoyentaColors.primary : VoyentaColors.onSurfaceVariant,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

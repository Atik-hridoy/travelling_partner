import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/amenity_chip.dart';

class AccommodationStep extends GetView<TripWizardController> {
  const AccommodationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final amenities = <String>[].obs;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Where do you lay your head?',
            style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the sanctuary that best fits your travel narrative.',
            style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
          ),
          const SizedBox(height: 40),

          // Options
          const AccommodationCard(
            title: 'Boutique Hotel',
            description: 'Local charm, personalized service.',
            icon: Icons.hotel,
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBhkNPMXep9WvJOmIqP-f1o_wLF6PV_RL_VbqxaW2VKRioRkKsRRQXyIBekEZ0DXjdgCFGV1ELHJHA6jPm3wVwQhEmMZ5bANqmAegzSXlfBMR9aQOhLxtM3raypLuPQkPhk6_CVmd5PK_Il2C2o-ls1RN-MFIpc30Wof6M6lHTL8mB8wHJZBEKIZwzSXGhrRneptd84ip1CysKjjM9X4WAqiBePKBGJXYz0C5MvdJ4hLuBCQ1pIder4gN7pV73ckCruhOO-U-4PjVF8',
          ),
          const SizedBox(height: 12),
          const AccommodationCard(
            title: 'Luxury Resort',
            description: 'Spas, pools, and ultimate comfort.',
            icon: Icons.holiday_village,
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAZhEfozDVQGjP1csOQhVk707fh8twmGp91yFrW4MKzQT61HFYO4QTYaP6Rp3p7OT2rUByRr6E9p1cClnUAonXp3UyzHOZwocPkmELB-gnAFvhmRA5YYRgOyDpQdnnxnO9DgG4Zy8Llq_EhEybiF3o6QGqPFZr_VX45VEb2wxHVgI4kmzVDqlvbIdL42rgXQeewXb_mJ_BytALZjtOhVHsJlBDEwoOA5eBIhgNzjETWwHuzd4KC6t4PvqXk7bpTRCe_sp2ZcnYCF7m8',
          ),
          const SizedBox(height: 12),
          const AccommodationCard(
            title: 'Private Villa',
            description: 'Exclusive space for your group.',
            icon: Icons.villa,
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC7CCsl03k61Ath9U8QujYe8CGP9IYD2uF1yFnhD5o10xPXZnBLe8tYxOGAeOW6lZWPEZe4gjDqj1FCD0gmbRVwjIB0CERBatmKrKxOZtEipMnLD-TxDxk2efNksvlb4mr52j0IIsYbOQSRxKn7Qv465btYoUcwSl4Fy01_O9ha3UgqAB9KOWg0AFsQMciwHSFFppQ3jprXXBk6orSOBDLrNVlxr4q6YFgUMLy9gNw_LyosltgaxJiZR-bFqgSZ3zXBG_j17mKTv1H1',
          ),
          const SizedBox(height: 12),
          const AccommodationCard(
            title: 'Ryokan / Heritage',
            description: 'Traditional stays for deep immersion.',
            icon: Icons.foundation,
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBxoGXfJaQ9IAkGipQqnqoDhrHa3tIgLPy-TFXU-ji21YgWMZoTu7QAG0YxCDoIob0RXzMRbnVP37-vIoUcR_qcP0oyIzi6g-BCqtrPilyr9zCQ6-yiuigfys-kKLNGentRY6EXxoFahkQk9IZJwQaaxNSL6H9A-WmMaPJnGN6yGBKPg68EtV4FeKcxe2jfxqQG9tsU5oDkmr8g0PzjVsz1NV-WRMPG_rDBxntxCJLBZ_FEJ4LQEycw0fwqkev-sFwZt7rtWCSmuVXK',
          ),
          
          const SizedBox(height: 40),

          // Amenities
          Text(
            'Must-Have Amenities',
            style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AmenityChip(icon: Icons.wifi, label: 'Fast Wi-Fi', amenities: amenities),
              AmenityChip(icon: Icons.pool, label: 'Pool', amenities: amenities),
              AmenityChip(icon: Icons.spa, label: 'Spa', amenities: amenities),
              AmenityChip(icon: Icons.fitness_center, label: 'Gym', amenities: amenities),
              AmenityChip(icon: Icons.local_bar, label: 'Rooftop Bar', amenities: amenities),
              AmenityChip(icon: Icons.pets, label: 'Pet Friendly', amenities: amenities),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../trip_wizard_controller.dart';
import '../widgets/travel_style_card.dart';

class TravelStyleStep extends GetView<TripWizardController> {
  const TravelStyleStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Text(
            "What's your travel style?",
            style: VoyentaTypography.displayLgMobile.copyWith(color: VoyentaColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Select the vibes that resonate with your ideal journey. Our AI concierge will tailor the itinerary to your taste.',
            style: VoyentaTypography.bodyLg.copyWith(color: VoyentaColors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Grid
          const TravelStyleCard(
            title: 'Adventure',
            subtitle: 'Thrilling treks, hidden trails, and adrenaline-fueled exploration across the wild.',
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAZhEfozDVQGjP1csOQhVk707fh8twmGp91yFrW4MKzQT61HFYO4QTYaP6Rp3p7OT2rUByRr6E9p1cClnUAonXp3UyzHOZwocPkmELB-gnAFvhmRA5YYRgOyDpQdnnxnO9DgG4Zy8Llq_EhEybiF3o6QGqPFZr_VX45VEb2wxHVgI4kmzVDqlvbIdL42rgXQeewXb_mJ_BytALZjtOhVHsJlBDEwoOA5eBIhgNzjETWwHuzd4KC6t4PvqXk7bpTRCe_sp2ZcnYCF7m8',
            height: 240,
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: TravelStyleCard(
                  title: 'Luxury',
                  subtitle: 'Refined comfort and five-star retreats.',
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuC7CCsl03k61Ath9U8QujYe8CGP9IYD2uF1yFnhD5o10xPXZnBLe8tYxOGAeOW6lZWPEZe4gjDqj1FCD0gmbRVwjIB0CERBatmKrKxOZtEipMnLD-TxDxk2efNksvlb4mr52j0IIsYbOQSRxKn7Qv465btYoUcwSl4Fy01_O9ha3UgqAB9KOWg0AFsQMciwHSFFppQ3jprXXBk6orSOBDLrNVlxr4q6YFgUMLy9gNw_LyosltgaxJiZR-bFqgSZ3zXBG_j17mKTv1H1',
                  height: 200,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TravelStyleCard(
                  title: 'Culture',
                  subtitle: 'Museums and local history.',
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBxoGXfJaQ9IAkGipQqnqoDhrHa3tIgLPy-TFXU-ji21YgWMZoTu7QAG0YxCDoIob0RXzMRbnVP37-vIoUcR_qcP0oyIzi6g-BCqtrPilyr9zCQ6-yiuigfys-kKLNGentRY6EXxoFahkQk9IZJwQaaxNSL6H9A-WmMaPJnGN6yGBKPg68EtV4FeKcxe2jfxqQG9tsU5oDkmr8g0PzjVsz1NV-WRMPG_rDBxntxCJLBZ_FEJ4LQEycw0fwqkev-sFwZt7rtWCSmuVXK',
                  height: 200,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: TravelStyleCard(
                  title: 'Nature',
                  subtitle: 'Untouched landscapes.',
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBbvlVJyCDl6TW72OwlJiPwb4KX3hd7qrTPD4AYp0CK-kMw9ljQcH0jst1DwVqUX7qhcYqz3WG14iDVTBHliihNUUGEo-3YzhhZLq6FMOQ-60zcDNOV4r3QJyBWI7HWi_uKxxvQKGhGKQOe7oQT98RSHqKlJ_pNdEjs0LKfdBt1XW5FUTfgr00fP6t8jHmej_f5LZ9eIAdKOmPOFyfU8m40gk5Wmsu4jfuaK3AGaWBJCc16lrT-buw-d07TTqTQjOgMQ332JuJioZ6n',
                  height: 200,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TravelStyleCard(
                  title: 'Food',
                  subtitle: 'Culinary journeys.',
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCjqzdBaKJnd-aIWYKQYIjWRF0VNMKwi70CFx6lUNoVBwZ7Qx9Th7oLPtIf0ROhp8evHo9Zq981ZI2oMD1Wc61aP-48alKP4BIxauaw_GkeWAp8mwwXQcDTrGyoljq7ZjV2VKKchGGNz8Z16FSZT0S7_7hXyvI-rL8Y4l_a1P2mQy8ySltV_dpFI6VJlDsBx-FBvCH2n1a1IEnrUXTZC2PgWvK0tWkDyQJGubG-a1zROqa9I-28GQcP9PhfVpwqEHiXRqATn0_udnf8',
                  height: 200,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

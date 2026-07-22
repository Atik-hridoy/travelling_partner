import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/glass_card.dart';

class TripUpcomingActivityCard extends StatelessWidget {
  const TripUpcomingActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAy7h04eCNwhd-SqMdzA7H013lEioaHl-u_m6nZDzyMmpMT-GN0OEZgmHXS_ptmrO2iVsGWays1lLH6skzMdSLxVDYky1JsKlxEeBo3vwNaJ4XT3xMeNYAb7KO8TE9-C5CDz6icQTw9j-RKrCVhialPcewnaenoBm69B2_I-nCzlFPVzEFmUgpqFaMr-LStTfilXqPgi7PQDLRTZB9rJarAKzGN_PGcgmZuKlqJ9N09ux5V6TSeNPPD0vQ9j1c6FuKJ4iVc_POqecjd',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NEXT ACTIVITY • 11:30 AM',
                style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.primary, fontSize: 10),
              ),
              Text(
                '2.4km away',
                style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Nishiki Market Culinary Tour',
            style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore the "Kitchen of Kyoto" with a private guide. Sample seasonal delicacies and visit century-old shops.',
            style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.directions, color: VoyentaColors.primary, size: 18),
                label: Text('Navigate', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              const SizedBox(width: 16),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info, color: VoyentaColors.onSurfaceVariant, size: 18),
                label: Text('Details', style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onSurfaceVariant, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TripBentoGrid extends StatelessWidget {
  const TripBentoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    
    if (isWide) {
      return Row(
        children: [
          Expanded(child: _buildBudget()),
          const SizedBox(width: 24),
          Expanded(child: _buildWeather()),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBudget(),
          const SizedBox(height: 24),
          _buildWeather(),
        ],
      );
    }
  }

  Widget _buildBudget() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Budget Tracker', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onSurface)),
              const Icon(Icons.account_balance_wallet, color: VoyentaColors.onSurfaceVariant, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: 0.64,
                  strokeWidth: 8,
                  backgroundColor: VoyentaColors.surfaceContainerHigh,
                  color: VoyentaColors.primary,
                ),
              ),
              Column(
                children: [
                  Text('64%', style: VoyentaTypography.headlineMd.copyWith(fontWeight: FontWeight.bold)),
                  Text('SPENT', style: VoyentaTypography.labelCaps.copyWith(fontSize: 8, color: VoyentaColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('¥142,500', style: VoyentaTypography.headlineMd.copyWith(fontWeight: FontWeight.bold)),
          Text('Remaining of ¥400,000', style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, color: VoyentaColors.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildWeather() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kyoto Weather', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onSurface)),
                  Text('Partly Cloudy', style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, color: VoyentaColors.onSurfaceVariant)),
                ],
              ),
              Icon(Icons.cloud_outlined, color: VoyentaColors.tertiary, size: 32),
            ],
          ),
          const SizedBox(height: 16),
          Text('22°C', style: VoyentaTypography.displayLgMobile.copyWith(fontWeight: FontWeight.w300, fontSize: 36)),
          Text('H: 24° L: 16° • Humid: 45%', style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, color: VoyentaColors.onSurfaceVariant)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildWeatherHour('1 PM', Icons.sunny, '23°', false)),
              const SizedBox(width: 8),
              Expanded(child: _buildWeatherHour('4 PM', Icons.cloud, '21°', true)),
              const SizedBox(width: 8),
              Expanded(child: _buildWeatherHour('7 PM', Icons.nights_stay, '18°', false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherHour(String time, IconData icon, String temp, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? VoyentaColors.primary.withOpacity(0.1) : VoyentaColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: VoyentaColors.primary.withOpacity(0.2)) : null,
      ),
      child: Column(
        children: [
          Text(time, style: VoyentaTypography.labelCaps.copyWith(fontSize: 10, color: isActive ? VoyentaColors.primary : VoyentaColors.onSurfaceVariant)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Icon(icon, size: 20, color: isActive ? VoyentaColors.primary : VoyentaColors.onSurface),
          ),
          Text(temp, style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class TripAiRecommendation extends StatelessWidget {
  const TripAiRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: VoyentaColors.primaryContainer,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: VoyentaColors.primary.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            bottom: -40,
            child: Icon(Icons.temple_buddhist, size: 200, color: VoyentaColors.onPrimaryContainer.withOpacity(0.05)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: VoyentaColors.onPrimaryContainer, size: 18),
                  const SizedBox(width: 8),
                  Text('NOVA AI RECOMMENDATION', style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onPrimaryContainer, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Hidden Tea Ceremony in Gion',
                style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onPrimaryContainer, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'I noticed you have a 2-hour gap before dinner. There\'s a master-led tea ceremony starting at 4:30 PM just 400m from your current location. It\'s a quiet, non-tourist spot perfect for reflection.',
                style: VoyentaTypography.bodyMd.copyWith(color: VoyentaColors.onPrimaryContainer.withOpacity(0.9), height: 1.5),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: VoyentaColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text('Book for ¥4,500', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

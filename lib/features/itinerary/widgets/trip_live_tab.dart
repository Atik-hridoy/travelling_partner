import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class TripLiveTab extends StatelessWidget {
  const TripLiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMapSection(),
        const SizedBox(height: 24),
        _buildNextDestinationCard(),
        const SizedBox(height: 24),
        _buildLiveAiInsights(),
        const SizedBox(height: 24),
        _buildQuickDiscoveryGrid(),
        const SizedBox(height: 24),
        _buildEmergencyButton(),
      ],
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 256,
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        image: const DecorationImage(
          image: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBvcUcNnQlrp0ftWwQlWmZCN6aEGvZh9hMLFQrsbS4Y-GRBKsT4mDyqosmpf7LLauAxcmjGdlWIqpDpb2KwKm10CQW9sikLvk90qYHOOZZc2RdZcR6h4TCyPjUyoPdFGzz4Q4ZPhvGeeik7Lc474ANFt01-DnqIyd0xPcdemGHZvRftUfJ_J44NfoTYFy14zSPyFrElWV8G5PjcmPaTDsG-3gXHHtxKWI1PNA0mA2wWJlhPr4Yw2ovA7YP4iPn6T-4oYCec8pdD--sL'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Glass panel
          Positioned(
            top: 16,
            left: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: VoyentaColors.surfaceBright.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENTLY IN',
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: VoyentaColors.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      'Gion District',
                      style: VoyentaTypography.headlineMd.copyWith(
                        color: VoyentaColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: VoyentaColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.near_me, color: VoyentaColors.onPrimary),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextDestinationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLowest,
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.explore, color: VoyentaColors.tertiary, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'NEXT DESTINATION',
                        style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.tertiary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kiyomizu-dera Temple',
                    style: VoyentaTypography.headlineMd.copyWith(color: VoyentaColors.onSurface),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '12',
                    style: VoyentaTypography.displayLgMobile.copyWith(
                      color: VoyentaColors.primary,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    'MINS ETA',
                    style: VoyentaTypography.labelCaps.copyWith(
                      color: VoyentaColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1.2 km traveled',
                style: VoyentaTypography.monoTechnical.copyWith(color: VoyentaColors.onSurfaceVariant),
              ),
              Text(
                '0.8 km left',
                style: VoyentaTypography.monoTechnical.copyWith(color: VoyentaColors.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: VoyentaColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  color: VoyentaColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.primaryContainer.withOpacity(0.3),
                      blurRadius: 12,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveAiInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Text(
            'LIVE AI INSIGHTS',
            style: VoyentaTypography.labelCaps.copyWith(color: VoyentaColors.onSurfaceVariant),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: VoyentaColors.secondaryContainer.withOpacity(0.3),
            border: Border.all(color: VoyentaColors.secondaryContainer),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: VoyentaColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.auto_awesome, color: VoyentaColors.onPrimary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weather Alert: Rain expected in 20m',
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: VoyentaColors.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The temple is outdoors. I suggest visiting the Kyoto National Museum instead to stay dry.',
                      style: VoyentaTypography.bodyMd.copyWith(
                        color: VoyentaColors.onSecondaryContainer.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: VoyentaColors.primary,
                            foregroundColor: VoyentaColors.onPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text('REROUTE NOW', style: VoyentaTypography.labelCaps),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: VoyentaColors.primary,
                            side: BorderSide(color: VoyentaColors.primary.withOpacity(0.2)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text('DISMISS', style: VoyentaTypography.labelCaps),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickDiscoveryGrid() {
    return Row(
      children: [
        _buildDiscoveryButton(Icons.atm, 'ATM'),
        const SizedBox(width: 12),
        _buildDiscoveryButton(Icons.wc, 'RESTROOM'),
        const SizedBox(width: 12),
        _buildDiscoveryButton(Icons.medical_services, 'HOSPITAL'),
        const SizedBox(width: 12),
        _buildDiscoveryButton(Icons.local_cafe, 'CAFE'),
      ],
    );
  }

  Widget _buildDiscoveryButton(IconData icon, String label) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: VoyentaColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: VoyentaColors.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: VoyentaTypography.labelCaps.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: VoyentaColors.error,
        foregroundColor: VoyentaColors.onErrorContainer, // Using standard color, though on-error is white
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emergency_share, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            'EMERGENCY SOS',
            style: VoyentaTypography.headlineMd.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

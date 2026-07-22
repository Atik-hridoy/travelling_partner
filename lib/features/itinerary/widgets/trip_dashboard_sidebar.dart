import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/glass_card.dart';

class TripQuickActions extends StatelessWidget {
  const TripQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onSurface)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildActionBtn(Icons.edit, 'Edit Trip')),
              const SizedBox(width: 12),
              Expanded(child: _buildActionBtn(Icons.download, 'Offline Docs')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildActionBtn(Icons.map, 'Map View')),
              const SizedBox(width: 12),
              Expanded(child: _buildActionBtn(Icons.chat, 'AI Chat')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: VoyentaColors.primary),
          const SizedBox(height: 8),
          Text(label, style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class TripActiveBookings extends StatelessWidget {
  const TripActiveBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Bookings', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onSurface)),
          const SizedBox(height: 16),
          _buildBookingCard(Icons.hotel, 'HOTEL', 'Park Hyatt Kyoto', 'Check-out: Oct 19, 11:00 AM', 'Conf: #XY2841', 'chevron_right'),
          const SizedBox(height: 16),
          _buildBookingCard(Icons.flight, 'RETURN FLIGHT', 'JL 812 • KIX to LHR', 'Departure: Oct 19, 9:30 PM', 'Terminal 1', 'chevron_right'),
        ],
      ),
    );
  }

  Widget _buildBookingCard(IconData icon, String type, String title, String subtitle, String footerLeft, String footerRight) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VoyentaColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VoyentaColors.outlineVariant.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: VoyentaColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(type, style: VoyentaTypography.labelCaps.copyWith(fontSize: 10, color: VoyentaColors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold)),
          Text(subtitle, style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, color: VoyentaColors.onSurfaceVariant)),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(footerLeft, style: VoyentaTypography.bodyMd.copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: VoyentaColors.primary)),
              const Icon(Icons.chevron_right, size: 16, color: VoyentaColors.onSurfaceVariant),
            ],
          ),
        ],
      ),
    );
  }
}

class TripPackingProgress extends StatelessWidget {
  const TripPackingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Packing Status', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.onSurface)),
              Text('85%', style: VoyentaTypography.bodyMd.copyWith(fontWeight: FontWeight.bold, color: VoyentaColors.primary)),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.85,
              minHeight: 8,
              backgroundColor: VoyentaColors.surfaceContainerHigh,
              valueColor: AlwaysStoppedAnimation<Color>(VoyentaColors.primary),
            ),
          ),
          const SizedBox(height: 16),
          _buildPackItem('Universal Adapter', true),
          const SizedBox(height: 12),
          _buildPackItem('Comfortable Walking Shoes', true),
          const SizedBox(height: 12),
          _buildPackItem('Printed Reservation Copies', false),
        ],
      ),
    );
  }

  Widget _buildPackItem(String name, bool isChecked) {
    return Row(
      children: [
        Icon(
          isChecked ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isChecked ? VoyentaColors.primary : VoyentaColors.outlineVariant,
          size: 18,
        ),
        const SizedBox(width: 12),
        Text(
          name,
          style: VoyentaTypography.bodyMd.copyWith(
            fontSize: 12,
            color: isChecked ? VoyentaColors.onSurface : VoyentaColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

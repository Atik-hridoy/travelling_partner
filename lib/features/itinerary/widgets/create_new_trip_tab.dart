import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../trip_creation/trip_wizard_view.dart';
import '../../ai_planning/ai_planning_view.dart';

class CreateNewTripTab extends StatefulWidget {
  const CreateNewTripTab({super.key});

  @override
  State<CreateNewTripTab> createState() => _CreateNewTripTabState();
}

class _CreateNewTripTabState extends State<CreateNewTripTab> {
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> _images = [
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBhkNPMXep9WvJOmIqP-f1o_wLF6PV_RL_VbqxaW2VKRioRkKsRRQXyIBekEZ0DXjdgCFGV1ELHJHA6jPm3wVwQhEmMZ5bANqmAegzSXlfBMR9aQOhLxtM3raypLuPQkPhk6_CVmd5PK_Il2C2o-ls1RN-MFIpc30Wof6M6lHTL8mB8wHJZBEKIZwzSXGhrRneptd84ip1CysKjjM9X4WAqiBePKBGJXYz0C5MvdJ4hLuBCQ1pIder4gN7pV73ckCruhOO-U-4PjVF8',
    'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&w=1200&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _images.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey<int>(_currentIndex),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_images[_currentIndex]),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
        ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black45, Colors.black87],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // AI Chip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AI-POWERED TRIP OS',
                      style: VoyentaTypography.labelCaps.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Let’s Plan Your\nNext Adventure',
                textAlign: TextAlign.center,
                style: VoyentaTypography.displayLgMobile.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Answer a few questions and Nova will build the perfect trip for you.',
                textAlign: TextAlign.center,
                style: VoyentaTypography.bodyLg.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 48),

              // Primary Action
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const TripWizardView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: VoyentaColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start Planning',
                      style: VoyentaTypography.headlineMd.copyWith(
                        fontWeight: FontWeight.bold,
                        color: VoyentaColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // AI Action
              OutlinedButton(
                onPressed: () {
                  Get.to(() => const AiPlanningView());
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Let AI Plan for You',
                      style: VoyentaTypography.headlineMd.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Secondary Options
              _buildGlassCard(
                icon: Icons.upload_file,
                iconColor: VoyentaColors.onPrimaryContainer,
                iconBgColor: VoyentaColors.primaryContainer,
                title: 'Import Plan',
                subtitle: 'Already have a flight or hotel? Forward it to Nova.',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildGlassCard(
                icon: Icons.explore,
                iconColor: VoyentaColors.onTertiaryContainer,
                iconBgColor: VoyentaColors.tertiaryContainer,
                title: 'Community',
                subtitle: 'Browse curated itineraries from top travelers.',
                onTap: () {},
              ),

              const Spacer(),

              // Image indicator dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 24 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: VoyentaTypography.headlineMd.copyWith(
                          fontWeight: FontWeight.bold,
                          color: VoyentaColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: VoyentaTypography.bodyMd.copyWith(
                          color: VoyentaColors.onSurfaceVariant.withOpacity(
                            0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: VoyentaColors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

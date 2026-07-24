import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import 'widgets/map_navigation_painter.dart';
import 'widgets/navigation_top_hud_card.dart';
import 'widgets/navigation_bottom_sheet.dart';

class PremiumNavigationView extends StatefulWidget {
  final String destinationTitle;
  final String destinationImageUrl;
  final String distanceText;
  final String timeText;

  const PremiumNavigationView({
    super.key,
    this.destinationTitle = 'Coffee at The Mill',
    this.destinationImageUrl = 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
    this.distanceText = '12 min • 0.8 mi',
    this.timeText = '14:42',
  });

  @override
  State<PremiumNavigationView> createState() => _PremiumNavigationViewState();
}

class _PremiumNavigationViewState extends State<PremiumNavigationView>
    with TickerProviderStateMixin {
  late AnimationController _pathController;
  late AnimationController _pulseController;
  late AnimationController _orbController;
  late AnimationController _sheetController;
  late Animation<double> _sheetOffsetAnimation;

  bool _isSheetCollapsed = false;

  @override
  void initState() {
    super.initState();

    _pathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _sheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _sheetOffsetAnimation = Tween<double>(begin: 0.0, end: 245.0).animate(
      CurvedAnimation(
        parent: _sheetController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  void _toggleSheet() {
    setState(() {
      _isSheetCollapsed = !_isSheetCollapsed;
    });
    if (_isSheetCollapsed) {
      _sheetController.forward();
    } else {
      _sheetController.reverse();
    }
  }

  @override
  void dispose() {
    _pathController.dispose();
    _pulseController.dispose();
    _orbController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080709),
      body: Stack(
        children: [
          // 1. Vector Map Background with Animated Glowing Route
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge([_pathController, _pulseController]),
              builder: (context, child) {
                return CustomPaint(
                  painter: MapNavigationPainter(
                    pathProgress: _pathController.value,
                    pulseProgress: _pulseController.value,
                  ),
                );
              },
            ),
          ),

          // 2. Floating POI Labels & Nova Floating Orb
          Positioned.fill(
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    left: 24,
                    child: _buildPoiChip("Philosophy's Path"),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.52,
                    right: 32,
                    child: _buildPoiChip("Local Tea House"),
                  ),

                  // Floating Nova AI Orb
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.38,
                    left: MediaQuery.of(context).size.width * 0.45,
                    child: AnimatedBuilder(
                      animation: _orbController,
                      builder: (context, child) {
                        final dy = math.sin(_orbController.value * math.pi) * 8;
                        return Transform.translate(
                          offset: Offset(0, -dy),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const RadialGradient(
                                    center: Alignment(-0.3, -0.3),
                                    colors: [
                                      Color(0xFFCFBCFF),
                                      Color(0xFF6750A4),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF6750A4).withValues(alpha: 0.6),
                                      blurRadius: 16,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF121014).withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.15),
                                  ),
                                ),
                                child: Text(
                                  'SCENIC DETOUR DETECTED',
                                  style: VoyentaTypography.labelCaps.copyWith(
                                    color: VoyentaColors.primaryFixed,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Side Map Buttons
                  Positioned(
                    right: 16,
                    top: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      children: [
                        _buildSideMapButton(Icons.explore_outlined),
                        const SizedBox(height: 12),
                        _buildSideMapButton(Icons.layers_outlined),
                        const SizedBox(height: 12),
                        _buildSideMapButton(Icons.my_location_outlined),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Top HUD Navigation Card
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: NavigationTopHudCard(distanceText: widget.distanceText),
              ),
            ),
          ),

          // 4. Interactive Navigation Bottom Sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _sheetOffsetAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _sheetOffsetAnimation.value),
                  child: child,
                );
              },
              child: NavigationBottomSheet(
                destinationTitle: widget.destinationTitle,
                destinationImageUrl: widget.destinationImageUrl,
                distanceText: widget.distanceText,
                timeText: widget.timeText,
                isSheetCollapsed: _isSheetCollapsed,
                onToggleSheet: _toggleSheet,
                onEndTrip: () => Get.back(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoiChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF121014).withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Text(
        label,
        style: VoyentaTypography.labelCaps.copyWith(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildSideMapButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF121014).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}

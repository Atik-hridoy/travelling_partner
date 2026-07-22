import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';

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

    // Animated glowing route path controller
    _pathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Pulsing radar/location ring controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Floating Nova orb controller
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Interactive Bottom Sheet collapse/expand controller
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

  void _collapseSheet() {
    if (!_isSheetCollapsed) {
      setState(() {
        _isSheetCollapsed = true;
      });
      _sheetController.forward();
    }
  }

  void _expandSheet() {
    if (_isSheetCollapsed) {
      setState(() {
        _isSheetCollapsed = false;
      });
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
          // 1. Premium Vector Map Background with Animated Glowing Route Path
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge([_pathController, _pulseController]),
              builder: (context, child) {
                return CustomPaint(
                  painter: _MapNavigationPainter(
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
                  // POI 1: Philosophy's Path
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    left: 24,
                    child: _buildPoiChip("Philosophy's Path"),
                  ),

                  // POI 2: Local Tea House
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.52,
                    right: 32,
                    child: _buildPoiChip("Local Tea House"),
                  ),

                  // Floating Nova AI Orb with Scenic Detour Badge
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.4),
                                      blurRadius: 12,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'SCENIC DETOUR DETECTED',
                                  style: VoyentaTypography.labelCaps.copyWith(
                                    color: VoyentaColors.primaryFixed,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Floating Map Action Buttons (Right side controls)
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
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF121014).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Big Turn Direction Arrow Box
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: VoyentaColors.voyagerGradient,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: VoyentaColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.north_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 14),
                            // Distance & Street
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      AnimatedBuilder(
                                        animation: _pulseController,
                                        builder: (context, child) {
                                          return Container(
                                            width: 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: VoyentaColors.primaryFixed.withValues(
                                                alpha: 0.4 + (_pulseController.value * 0.6),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'IN 250 METERS',
                                        style: VoyentaTypography.labelCaps.copyWith(
                                          color: Colors.white.withValues(alpha: 0.6),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  RichText(
                                    text: TextSpan(
                                      style: VoyentaTypography.headlineMd.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: const [
                                        TextSpan(text: 'Head '),
                                        TextSpan(
                                          text: 'North',
                                          style: TextStyle(color: VoyentaColors.primaryFixed),
                                        ),
                                        TextSpan(text: ' on Ichijoji-sagari-matsu'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Close Navigation Button
                            IconButton(
                              icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 22),
                              onPressed: () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 4. Bottom Main Direction & Destination Sheet (Interactive Hide/Expand)
          AnimatedBuilder(
            animation: _sheetOffsetAnimation,
            builder: (context, child) {
              return Positioned(
                left: 0,
                right: 0,
                bottom: -_sheetOffsetAnimation.value,
                child: child!,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 32,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Grabber Handle with Gesture Drag & Tap to Collapse/Expand
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > 4) {
                        _collapseSheet();
                      } else if (details.delta.dy < -4) {
                        _expandSheet();
                      }
                    },
                    onTap: _toggleSheet,
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Container(
                          width: 54,
                          height: 5,
                          decoration: BoxDecoration(
                            color: VoyentaColors.primary.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isSheetCollapsed
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              size: 20,
                              color: VoyentaColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _isSheetCollapsed ? 'Tap to expand sheet' : 'Tap or drag down to hide',
                              style: VoyentaTypography.labelCaps.copyWith(
                                color: VoyentaColors.primary.withValues(alpha: 0.7),
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Destination Info Row
                  GestureDetector(
                    onTap: _toggleSheet,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        // Destination Thumbnail with Badge
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.12),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                  widget.destinationImageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: VoyentaColors.primaryContainer,
                                      child: const Icon(Icons.place, color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: VoyentaColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.stars_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 16),

                        // Destination Name & Walk Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.destinationTitle,
                                style: VoyentaTypography.headlineMd.copyWith(
                                  color: VoyentaColors.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.directions_walk_rounded,
                                      size: 14,
                                      color: VoyentaColors.primary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.distanceText,
                                      style: VoyentaTypography.bodyMd.copyWith(
                                        color: VoyentaColors.onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Arrival Time
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'ARRIVAL',
                              style: VoyentaTypography.labelCaps.copyWith(
                                color: VoyentaColors.outline,
                                fontSize: 9,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.timeText,
                              style: VoyentaTypography.displayLgMobile.copyWith(
                                color: VoyentaColors.primary,
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Integrated Nova Insight Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: VoyentaColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            gradient: VoyentaColors.voyagerGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NOVA INSIGHT',
                                style: VoyentaTypography.labelCaps.copyWith(
                                  color: VoyentaColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 2),
                              RichText(
                                text: TextSpan(
                                  style: VoyentaTypography.bodyMd.copyWith(
                                    color: VoyentaColors.onSurfaceVariant,
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                  children: const [
                                    TextSpan(text: "Taking the scenic path. It's "),
                                    TextSpan(
                                      text: '60% quieter',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: VoyentaColors.primary,
                                      ),
                                    ),
                                    TextSpan(text: ' and provides better shade for your walk.'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // End Trip Action Button
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () => Get.back(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: VoyentaColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'End Trip',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: VoyentaColors.surfaceContainerHighest.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.more_horiz_rounded, color: VoyentaColors.onSurfaceVariant),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}

class _MapNavigationPainter extends CustomPainter {
  final double pathProgress;
  final double pulseProgress;

  _MapNavigationPainter({
    required this.pathProgress,
    required this.pulseProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dark Radial Background
    final bgGradient = RadialGradient(
      center: Alignment.center,
      radius: 1.2,
      colors: [
        const Color(0xFF1A181E),
        const Color(0xFF080709),
      ],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = bgGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // 2. Road Network Lines
    final roadPaint = Paint()
      ..color = const Color(0xFF2D2B33).withValues(alpha: 0.4)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final roadPath = Path();
    roadPath.moveTo(-50, size.height * 0.2);
    roadPath.quadraticBezierTo(size.width * 0.5, size.height * 0.18, size.width + 50, size.height * 0.22);

    roadPath.moveTo(size.width * 0.3, -50);
    roadPath.quadraticBezierTo(size.width * 0.35, size.height * 0.5, size.width * 0.28, size.height + 50);

    roadPath.moveTo(-50, size.height * 0.55);
    roadPath.quadraticBezierTo(size.width * 0.5, size.height * 0.53, size.width + 50, size.height * 0.58);

    roadPath.moveTo(size.width * 0.75, -50);
    roadPath.quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width * 0.78, size.height + 50);

    canvas.drawPath(roadPath, roadPaint);

    // 3. Glowing Neon Purple Route Path
    final routePath = Path();
    final startP = Offset(size.width * 0.25, size.height * 0.85);
    final controlP1 = Offset(size.width * 0.25, size.height * 0.6);
    final cornerP = Offset(size.width * 0.65, size.height * 0.6);
    final endP = Offset(size.width * 0.65, size.height * 0.2);

    routePath.moveTo(startP.dx, startP.dy);
    routePath.lineTo(controlP1.dx, controlP1.dy);
    routePath.lineTo(cornerP.dx, cornerP.dy);
    routePath.lineTo(endP.dx, endP.dy);

    // Glow under path
    final glowPaint = Paint()
      ..color = const Color(0xFF8B5CF6).withValues(alpha: 0.6)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawPath(routePath, glowPaint);

    // Main Neon line
    final pathLinePaint = Paint()
      ..color = const Color(0xFF8B5CF6)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(routePath, pathLinePaint);

    // Dynamic Moving Dash pulse over the route path
    final metrics = routePath.computeMetrics().first;
    final totalLen = metrics.length;
    final animatedOffset = (pathProgress * totalLen) % totalLen;
    final extractLen = 40.0;
    final extractPath = metrics.extractPath(
      animatedOffset,
      math.min(animatedOffset + extractLen, totalLen),
    );

    final dashGlowPaint = Paint()
      ..color = const Color(0xFFE9DDFF)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawPath(extractPath, dashGlowPaint);

    // 4. Current Location Marker (Pulse Ring at startP)
    final locPulseRadius = 10.0 + (pulseProgress * 20.0);
    final locPulseAlpha = 0.5 * (1.0 - pulseProgress);
    final locPulsePaint = Paint()
      ..color = Colors.white.withValues(alpha: locPulseAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(startP, locPulseRadius, locPulsePaint);
    canvas.drawCircle(startP, 7, Paint()..color = Colors.white);
    canvas.drawCircle(startP, 11, Paint()..color = Colors.white.withValues(alpha: 0.4)..style = PaintingStyle.stroke..strokeWidth = 1.5);

    // 5. Destination POI Pin (Pulse Ring at endP)
    final poiPulseRadius = 12.0 + (pulseProgress * 25.0);
    final poiPulseAlpha = 0.4 * (1.0 - pulseProgress);
    final poiPulsePaint = Paint()
      ..color = const Color(0xFF8B5CF6).withValues(alpha: poiPulseAlpha)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(endP, poiPulseRadius, poiPulsePaint);
    canvas.drawCircle(endP, 6, Paint()..color = const Color(0xFFCFBCFF));

    // Bouncing Destination Arrow Pin
    final bounceY = math.sin(pulseProgress * math.pi * 2) * 5;
    final pinPath = Path();
    pinPath.moveTo(endP.dx - 12, endP.dy - 20 + bounceY);
    pinPath.lineTo(endP.dx + 12, endP.dy - 20 + bounceY);
    pinPath.lineTo(endP.dx, endP.dy - 35 + bounceY);
    pinPath.close();

    canvas.drawPath(
      pinPath,
      Paint()..color = const Color(0xFF8B5CF6).withValues(alpha: 0.9),
    );
  }

  @override
  bool shouldRepaint(covariant _MapNavigationPainter oldDelegate) {
    return oldDelegate.pathProgress != pathProgress ||
        oldDelegate.pulseProgress != pulseProgress;
  }
}

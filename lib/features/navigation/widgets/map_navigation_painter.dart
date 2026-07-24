import 'dart:math' as math;
import 'package:flutter/material.dart';

class MapNavigationPainter extends CustomPainter {
  final double pathProgress;
  final double pulseProgress;

  MapNavigationPainter({
    required this.pathProgress,
    required this.pulseProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dark Radial Background
    final bgGradient = const RadialGradient(
      center: Alignment.center,
      radius: 1.2,
      colors: [
        Color(0xFF1A181E),
        Color(0xFF080709),
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
    const extractLen = 40.0;
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
  bool shouldRepaint(covariant MapNavigationPainter oldDelegate) {
    return oldDelegate.pathProgress != pathProgress ||
        oldDelegate.pulseProgress != pulseProgress;
  }
}

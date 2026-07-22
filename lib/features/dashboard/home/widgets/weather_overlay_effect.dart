import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'weather_widget.dart';

class WeatherOverlayEffect extends StatefulWidget {
  final WeatherType weatherType;
  final Duration displayDuration;
  final VoidCallback? onCompleted;

  const WeatherOverlayEffect({
    super.key,
    this.weatherType = WeatherType.cloudy,
    this.displayDuration = const Duration(seconds: 4),
    this.onCompleted,
  });

  @override
  State<WeatherOverlayEffect> createState() => _WeatherOverlayEffectState();
}

class _WeatherOverlayEffectState extends State<WeatherOverlayEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();

    _initParticles();

    _controller = AnimationController(
      vsync: this,
      duration: widget.displayDuration,
    );

    // Fade in during first 20%, stay fully visible, then fade out in last 25%
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeIn),
        ),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 25,
      ),
    ]).animate(_controller);

    _controller.forward().then((_) {
      if (mounted && widget.onCompleted != null) {
        widget.onCompleted!();
      }
    });
  }

  void _initParticles() {
    final count = widget.weatherType == WeatherType.rainy
        ? 45
        : widget.weatherType == WeatherType.snowy
            ? 35
            : 15;

    for (int i = 0; i < count; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          speed: 0.3 + _random.nextDouble() * 0.7,
          size: 3 + _random.nextDouble() * 6,
          opacity: 0.2 + _random.nextDouble() * 0.6,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final overallOpacity = _opacityAnimation.value;
          if (overallOpacity <= 0.001) return const SizedBox.shrink();

          return Opacity(
            opacity: overallOpacity,
            child: CustomPaint(
              size: Size.infinite,
              painter: _WeatherOverlayPainter(
                weatherType: widget.weatherType,
                progress: _controller.value,
                particles: _particles,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Particle {
  double x;
  double y;
  double speed;
  double size;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
  });
}

class _WeatherOverlayPainter extends CustomPainter {
  final WeatherType weatherType;
  final double progress;
  final List<_Particle> particles;

  _WeatherOverlayPainter({
    required this.weatherType,
    required this.progress,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (weatherType) {
      case WeatherType.cloudy:
        _paintCloudyOverlay(canvas, size);
        break;
      case WeatherType.sunny:
        _paintSunnyOverlay(canvas, size);
        break;
      case WeatherType.rainy:
        _paintRainyOverlay(canvas, size);
        break;
      case WeatherType.snowy:
        _paintSnowyOverlay(canvas, size);
        break;
      case WeatherType.thunder:
        _paintThunderOverlay(canvas, size);
        break;
    }
  }

  void _paintCloudyOverlay(Canvas canvas, Size size) {
    // Soft ambient misty cloud bands passing across top of screen
    final paint1 = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF6750A4).withValues(alpha: 0.12),
          const Color(0xFF2563EB).withValues(alpha: 0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.4));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.4), paint1);

    // Floating soft cloud circles
    final cloudPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    final shiftX = progress * size.width * 0.3;

    canvas.drawCircle(
      Offset(-50 + shiftX, size.height * 0.1),
      90,
      cloudPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5 + shiftX, size.height * 0.05),
      110,
      cloudPaint,
    );
    canvas.drawCircle(
      Offset(size.width + 40 - shiftX, size.height * 0.15),
      85,
      cloudPaint,
    );
  }

  void _paintSunnyOverlay(Canvas canvas, Size size) {
    // Warm golden ambient sun flare gradient from top right
    final sunGlowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.8, -0.9),
        radius: 1.4,
        colors: [
          const Color(0xFFF59E0B).withValues(alpha: 0.22),
          const Color(0xFFFBBF24).withValues(alpha: 0.08),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), sunGlowPaint);

    // Sunbeam light rays
    final rayPaint = Paint()
      ..color = const Color(0xFFFDE68A).withValues(alpha: 0.12)
      ..strokeWidth = 24
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final center = Offset(size.width * 0.85, 0);
    final rayCount = 5;

    for (int i = 0; i < rayCount; i++) {
      final angle = (math.pi / 4) + (i * 0.18) + (progress * 0.05);
      final rayEnd = Offset(
        center.dx + math.cos(angle) * size.height,
        center.dy + math.sin(angle) * size.height,
      );
      canvas.drawLine(center, rayEnd, rayPaint);
    }
  }

  void _paintRainyOverlay(Canvas canvas, Size size) {
    // Cool atmosphere tint
    final ambientPaint = Paint()
      ..color = const Color(0xFF1E293B).withValues(alpha: 0.08);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), ambientPaint);

    // Falling raindrops
    final rainPaint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.5)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    for (final p in particles) {
      final currentY = ((p.y + progress * p.speed * 2) % 1.0) * size.height;
      final currentX = p.x * size.width - (progress * 20);

      canvas.drawLine(
        Offset(currentX, currentY),
        Offset(currentX - 4, currentY + p.size * 2.5),
        rainPaint..color = const Color(0xFF38BDF8).withValues(alpha: p.opacity),
      );
    }
  }

  void _paintSnowyOverlay(Canvas canvas, Size size) {
    final flakePaint = Paint()
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    for (final p in particles) {
      final currentY = ((p.y + progress * p.speed * 0.8) % 1.0) * size.height;
      final swayX = math.sin((progress * 4) + p.x * 10) * 15;
      final currentX = (p.x * size.width + swayX) % size.width;

      flakePaint.color = Colors.white.withValues(alpha: p.opacity * 0.8);
      canvas.drawCircle(Offset(currentX, currentY), p.size * 0.6, flakePaint);
    }
  }

  void _paintThunderOverlay(Canvas canvas, Size size) {
    // Flash intensity
    final flashVal = (progress * 8) % 1.0;
    if (flashVal > 0.85) {
      final flashPaint = Paint()
        ..color = const Color(0xFFEF4444).withValues(alpha: 0.15);
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), flashPaint);
    }

    _paintRainyOverlay(canvas, size);
  }

  @override
  bool shouldRepaint(covariant _WeatherOverlayPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.weatherType != weatherType;
  }
}

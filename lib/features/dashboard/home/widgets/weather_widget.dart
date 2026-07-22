import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

enum WeatherType { sunny, cloudy, rainy, snowy, thunder }

class WeatherWidget extends StatefulWidget {
  final String temperature;
  final String conditionName;
  final WeatherType? initialType;
  final ValueChanged<WeatherType>? onWeatherChanged;

  const WeatherWidget({
    super.key,
    this.temperature = '68°F',
    this.conditionName = 'Cloudy',
    this.initialType,
    this.onWeatherChanged,
  });

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  late WeatherType _currentType;
  late String _currentCondition;

  @override
  void initState() {
    super.initState();
    _currentType = widget.initialType ?? _parseType(widget.conditionName);
    _currentCondition = widget.conditionName;

    // Entrance Animation (Plays once on app entry / widget load)
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.elasticOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Continuous Subtle Effect Animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _entranceController.forward();
  }

  WeatherType _parseType(String condition) {
    final lower = condition.toLowerCase();
    if (lower.contains('sun') || lower.contains('clear')) {
      return WeatherType.sunny;
    } else if (lower.contains('rain') || lower.contains('drizzle')) {
      return WeatherType.rainy;
    } else if (lower.contains('snow')) {
      return WeatherType.snowy;
    } else if (lower.contains('storm') || lower.contains('thunder')) {
      return WeatherType.thunder;
    }
    return WeatherType.cloudy;
  }

  void _cycleWeatherDemo() {
    setState(() {
      final types = WeatherType.values;
      final nextIndex = (types.indexOf(_currentType) + 1) % types.length;
      _currentType = types[nextIndex];

      switch (_currentType) {
        case WeatherType.sunny:
          _currentCondition = 'Sunny';
          break;
        case WeatherType.cloudy:
          _currentCondition = 'Cloudy';
          break;
        case WeatherType.rainy:
          _currentCondition = 'Rainy';
          break;
        case WeatherType.snowy:
          _currentCondition = 'Snowy';
          break;
        case WeatherType.thunder:
          _currentCondition = 'Stormy';
          break;
      }
    });

    _entranceController.forward(from: 0.3);
    widget.onWeatherChanged?.call(_currentType);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildWeatherEffectIcon() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulseValue = _pulseController.value;

        switch (_currentType) {
          case WeatherType.sunny:
            return Transform.rotate(
              angle: pulseValue * 0.25,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoyentaColors.amber.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.amber.withValues(
                        alpha: 0.2 + (pulseValue * 0.2),
                      ),
                      blurRadius: 8 + (pulseValue * 6),
                      spreadRadius: 1 + (pulseValue * 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.wb_sunny_rounded,
                  size: 18,
                  color: VoyentaColors.amber,
                ),
              ),
            );

          case WeatherType.cloudy:
            return Transform.translate(
              offset: Offset((pulseValue * 3) - 1.5, 0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoyentaColors.voyagerEnd.withValues(alpha: 0.12),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.secondary.withValues(alpha: 0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.cloud_rounded,
                  size: 18,
                  color: VoyentaColors.voyagerStart,
                ),
              ),
            );

          case WeatherType.rainy:
            return Transform.translate(
              offset: Offset(0, pulseValue * 2.5),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: VoyentaColors.voyagerStart.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: VoyentaColors.voyagerStart.withValues(
                        alpha: 0.25,
                      ),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.grain_rounded,
                  size: 18,
                  color: VoyentaColors.voyagerStart,
                ),
              ),
            );

          case WeatherType.snowy:
            return Transform.rotate(
              angle: pulseValue * 0.5,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlueAccent.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlueAccent.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.ac_unit_rounded,
                  size: 18,
                  color: Colors.lightBlue,
                ),
              ),
            );

          case WeatherType.thunder:
            final flashAlpha = (pulseValue > 0.7) ? 0.4 : 0.15;
            return Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VoyentaColors.rose.withValues(alpha: flashAlpha),
                boxShadow: [
                  BoxShadow(
                    color: VoyentaColors.rose.withValues(alpha: flashAlpha),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.thunderstorm_rounded,
                size: 18,
                color: VoyentaColors.rose,
              ),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: GestureDetector(
            onTap: _cycleWeatherDemo,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: VoyentaColors.outlineVariant.withValues(alpha: 0.4),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildWeatherEffectIcon(),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'WEATHER',
                        style: VoyentaTypography.labelCaps.copyWith(
                          color: VoyentaColors.onSurfaceVariant.withValues(
                            alpha: 0.6,
                          ),
                          fontSize: 8,
                          letterSpacing: 0.5,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.2),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          '${widget.temperature} $_currentCondition',
                          key: ValueKey(_currentCondition),
                          style: VoyentaTypography.bodyMd.copyWith(
                            fontWeight: FontWeight.bold,
                            color: VoyentaColors.onSurface,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

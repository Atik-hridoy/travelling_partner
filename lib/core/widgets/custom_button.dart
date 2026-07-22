import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final double width;
  final double height;
  final bool isGradient;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.width = double.infinity,
    this.height = 56.0,
    this.isGradient = true,
    this.icon,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: widget.isSecondary
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0), // Capsule squircle shape
                  color: Colors.transparent,
                  border: Border.all(
                    color: VoyentaColors.primary.withOpacity(0.5),
                    width: 1.5,
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0),
                  gradient: widget.isGradient ? VoyentaColors.voyagerGradient : null,
                  color: widget.isGradient ? null : VoyentaColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: (widget.isGradient ? VoyentaColors.voyagerStart : VoyentaColors.primary)
                          .withOpacity(0.3),
                      blurRadius: 16.0,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  widget.icon!,
                  const SizedBox(width: 8.0),
                ],
                Text(
                  widget.text,
                  style: VoyentaTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.isSecondary ? VoyentaColors.primary : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

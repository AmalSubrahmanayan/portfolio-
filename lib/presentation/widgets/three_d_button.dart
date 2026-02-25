import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ThreeDButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const ThreeDButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<ThreeDButton> createState() => _ThreeDButtonState();
}

class _ThreeDButtonState extends State<ThreeDButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    const double pushDepth = 4.0;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: SizedBox(
          width: 200,
          height: 60,
          child: Stack(
            children: [
              // Shadow Layer (Bottom)
              Positioned(
                bottom: 0,
                child: Container(
                  width: 200,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlack.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // Top Layer (Button Face)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 50),
                top: _isPressed ? pushDepth : 0,
                child: Container(
                  width: 200,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite,
                    border: Border.all(color: AppColors.primaryBlack, width: 3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      widget.text,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

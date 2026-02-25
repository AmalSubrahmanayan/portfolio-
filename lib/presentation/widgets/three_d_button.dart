import 'dart:math' as math;
import 'package:flutter/material.dart';

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

class _ThreeDButtonState extends State<ThreeDButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _streakController;
  Offset _mousePos = Offset.zero;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _streakController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _streakController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent details, Size size) {
    setState(() {
      _isHovered = true;
      _mousePos = Offset(
        (details.localPosition.dx / size.width) * 2 - 1,
        (details.localPosition.dy / size.height) * 2 - 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const size = Size(240, 64);
    
    return MouseRegion(
      onEnter: (e) => setState(() => _isHovered = true),
      onExit: (e) => setState(() {
        _isHovered = false;
        _mousePos = Offset.zero;
      }),
      onHover: (e) => _onHover(e, size),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: AnimatedRotation(
            turns: 0, 
            duration: const Duration(milliseconds: 200),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002) // Perspective
                ..rotateX(_isHovered ? -_mousePos.dy * 0.2 : 0)
                ..rotateY(_isHovered ? _mousePos.dx * 0.2 : 0),
              alignment: FractionalOffset.center,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6200EE).withValues(alpha: _isHovered ? 0.4 : 0.1),
                      blurRadius: 20,
                      spreadRadius: _isHovered ? 5 : 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      // Obsidian Base
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D0D0D),
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      
                      // Energy Streaks
                      AnimatedBuilder(
                        animation: _streakController,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: _EnergyStreakPainter(
                              progress: _streakController.value,
                              isHovered: _isHovered,
                            ),
                            size: size,
                          );
                        },
                      ),

                      // Gloss/Glass Sheen
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.transparent,
                              Colors.white.withValues(alpha: 0.05),
                            ],
                          ),
                        ),
                      ),

                      // Reflected Edges
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 0.5,
                          ),
                        ),
                      ),

                      // Text
                      Center(
                        child: Text(
                          widget.text,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                            shadows: [
                              const Shadow(
                                color: Colors.black,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EnergyStreakPainter extends CustomPainter {
  final double progress;
  final bool isHovered;

  _EnergyStreakPainter({required this.progress, required this.isHovered});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final random = math.Random(42);
    
    for (int i = 0; i < 3; i++) {
      final y = size.height * (0.3 + i * 0.2);
      final xOffset = progress * size.width;
      
      final rect = Rect.fromLTWH(
        (xOffset + random.nextDouble() * size.width) % size.width - 50,
        y,
        100,
        2,
      );

      final gradient = LinearGradient(
        colors: [
          Colors.transparent,
          i == 0 ? const Color(0xFFAA00FF) : (i == 1 ? const Color(0xFF00B0FF) : Colors.white),
          Colors.transparent,
        ],
      ).createShader(rect);

      paint.shader = gradient;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(1)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EnergyStreakPainter oldDelegate) => true;
}

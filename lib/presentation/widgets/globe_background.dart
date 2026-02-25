import 'dart:math' as math;
import 'package:flutter/material.dart';

class GlobeBackground extends StatefulWidget {
  const GlobeBackground({super.key});

  @override
  State<GlobeBackground> createState() => _GlobeBackgroundState();
}

class _GlobeBackgroundState extends State<GlobeBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Point3D> _points = [];
  final int _pointCount = 1500;
  final double _radius = 350.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _initPoints();
  }

  void _initPoints() {
    // Fibonacci sphere algorithm for uniform point distribution
    final double phi = math.pi * (3.0 - math.sqrt(5.0)); // Golden angle

    for (int i = 0; i < _pointCount; i++) {
      final double y = 1 - (i / (_pointCount - 1.0)) * 2; // y goes from 1 to -1
      final double radiusAtY = math.sqrt(1 - y * y); // radius at y

      final double theta = phi * i; // Golden angle increment

      final double x = math.cos(theta) * radiusAtY;
      final double z = math.sin(theta) * radiusAtY;

      _points.add(_Point3D(x, y, z));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _GlobePainter(
            points: _points,
            rotationY: _controller.value * 2 * math.pi,
            radius: _radius,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _Point3D {
  final double x, y, z;
  _Point3D(this.x, this.y, this.z);
}

class _GlobePainter extends CustomPainter {
  final List<_Point3D> points;
  final double rotationY;
  final double radius;

  _GlobePainter({
    required this.points,
    required this.rotationY,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.75, size.height * 0.5);
    final paint = Paint()..style = PaintingStyle.fill;

    // Projection constants
    const double perspective = 1000.0;

    for (final point in points) {
      // Rotate around Y axis
      final double cosY = math.cos(rotationY);
      final double sinY = math.sin(rotationY);

      final double rotatedX = point.x * cosY - point.z * sinY;
      final double rotatedZ = point.x * sinY + point.z * cosY;

      // Translate to radius
      final double x3D = rotatedX * radius;
      final double y3D = point.y * radius;
      final double z3D = rotatedZ * radius;

      // Simple perspective projection
      final double scale = perspective / (perspective - z3D);
      final double x2D = x3D * scale;
      final double y2D = y3D * scale;

      // Color based on depth (Z)
      // Dots on the "front" are brighter and larger
      final double zNormalized = (rotatedZ + 1) / 2; // 0 (back) to 1 (front)
      
      // Use Amber colors as per the Dribbble concept
      final Color color = Color.lerp(
        const Color(0xFF5D4037).withValues(alpha: 0.1), // Deep brown/amber for back
        const Color(0xFFFFB300).withValues(alpha: 0.8), // Bright gold for front
        zNormalized,
      )!;

      paint.color = color;
      final double dotRadius = (zNormalized * 1.5 + 0.5) * scale;

      canvas.drawCircle(
        Offset(center.dx + x2D, center.dy + y2D),
        dotRadius,
        paint,
      );
    }
    
    // Draw atmospheric glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFF6F00).withValues(alpha: 0.15),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.2));
    
    canvas.drawCircle(center, radius * 1.2, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _GlobePainter oldDelegate) => true;
}

import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> particles = [];
  final Random random = Random();
  // Tuned to perfectly match the dense web default of particles.js
  final int particleCount = 120;
  final double connectionDistance = 150.0;
  final double mouseConnectionDistance = 200.0;
  Offset? mousePosition;

  @override
  void initState() {
    super.initState();
    // Use a very fast ticker but very small movement steps for buttery smooth 60fps
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initParticles(context.size ?? const Size(800, 800));
    });
  }

  void _initParticles(Size size) {
    particles.clear();
    for (int i = 0; i < particleCount; i++) {
      particles.add(Particle(
        x: random.nextDouble() * size.width,
        y: random.nextDouble() * size.height,
        // particles.js default moves very slowly and steadily
        speedX: (random.nextDouble() - 0.5) * 0.8,
        speedY: (random.nextDouble() - 0.5) * 0.8,
        // particles.js default dots are distinct but reasonably small
        radius: random.nextDouble() * 2 + 1.5,
        alpha: 255, 
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (particles.isEmpty || particles.length != particleCount) {
          _initParticles(Size(constraints.maxWidth, constraints.maxHeight));
        }
        return MouseRegion(
          onHover: (event) {
            setState(() {
              mousePosition = event.localPosition;
            });
          },
          onExit: (event) {
            setState(() {
              mousePosition = null;
            });
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              _updateParticles(constraints);
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: PlexusPainter(
                    particles, connectionDistance, mouseConnectionDistance, mousePosition),
              );
            },
          ),
        );
      },
    );
  }

  void _updateParticles(BoxConstraints constraints) {
    for (var particle in particles) {
      particle.x += particle.speedX;
      particle.y += particle.speedY;

      // perfect edge bouncing, no popping
      if (particle.x < 0 || particle.x > constraints.maxWidth) {
        particle.speedX *= -1;
        particle.x = particle.x.clamp(0.0, constraints.maxWidth);
      }
      if (particle.y < 0 || particle.y > constraints.maxHeight) {
        particle.speedY *= -1;
        particle.y = particle.y.clamp(0.0, constraints.maxHeight);
      }
    }
  }
}

class Particle {
  double x;
  double y;
  double speedX;
  double speedY;
  double radius;
  int alpha;

  Particle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.alpha,
  });
}

class PlexusPainter extends CustomPainter {
  final List<Particle> particles;
  final double connectionDistance;
  final double mouseConnectionDistance;
  final Offset? mousePosition;

  PlexusPainter(this.particles, this.connectionDistance,
      this.mouseConnectionDistance, this.mousePosition);

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8; // particles.js default has slightly thinner, elegant lines

    // Draw lines between close particles
    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final distance = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));

        if (distance < connectionDistance) {
          // particles.js lines fade out linearly as they get further apart
          final double opacityFactor = 1.0 - (distance / connectionDistance);
          // Max opacity of the line is slightly transparent (around 120-150 alpha out of 255)
          final int lineAlpha = (120 * opacityFactor).toInt().clamp(0, 255);
          
          linePaint.color = Colors.white.withAlpha(lineAlpha);
          canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), linePaint);
        }
      }
      
      // Draw lines reacting to the mouse cursor
      if (mousePosition != null) {
        final mouseDistance = sqrt(pow(p1.x - mousePosition!.dx, 2) + pow(p1.y - mousePosition!.dy, 2));
        if (mouseDistance < mouseConnectionDistance) { 
          // The mouse connection uses the same linear fade logic
          final double mouseOpacityFactor = 1.0 - (mouseDistance / mouseConnectionDistance);
          final int mouseLineAlpha = (150 * mouseOpacityFactor).toInt().clamp(0, 255);
          linePaint.color = Colors.white.withAlpha(mouseLineAlpha);
          canvas.drawLine(Offset(p1.x, p1.y), mousePosition!, linePaint);
        }
      }
    }

    // Draw particles on top of lines (dots are completely solid white with custom alpha)
    for (var particle in particles) {
      // In particles.js the dots themselves often stay solid opacity
      dotPaint.color = Colors.white.withAlpha(200); 
      canvas.drawCircle(Offset(particle.x, particle.y), particle.radius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PlexusPainter oldDelegate) => true;
}

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: size.width,
      color: AppColors.backgroundLight,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.15,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ABOUT ME bordered box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBlack, width: 4),
            ),
            child: Text(
              "ABOUT ME",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 4.0,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Intro Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : size.width * 0.1),
            child: Text(
              "Performance-driven Flutter Developer with 3+ years of experience building scalable cross-platform applications (Android, iOS, Web). Specialist in Clean Architecture, DDD, and Monorepo (Melos) management. Proven expertise in integrating complex GraphQL APIs and real-time systems for global-scale apps like Scoreblox. Committed to writing maintainable code and delivering high-quality user experiences.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 64),

          // EXPLORE divider
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 2, height: 16, color: AppColors.textSecondary),
              const SizedBox(width: 16),
              Text(
                "EXPLORE",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(width: 16),
              Container(width: 2, height: 16, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 16),
          // Zigzag placeholder
          Text(
            "\\/\\/\\/\\/\\/\\/",
            style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.5), letterSpacing: 2),
          ),
          const SizedBox(height: 80),

          // Services / Capabilities
          isMobile 
            ? Column(
                children: _buildServices(context)
                    .expand((widget) => [widget, const SizedBox(height: 48)])
                    .toList()
                  ..removeLast(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildServices(context)
                  .map((widget) => Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: widget,
                  )))
                  .toList(),
              ),
              
          const SizedBox(height: 80),
          // Zigzag placeholder
          Text(
            "\\/\\/\\/\\/\\/\\/",
            style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.5), letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildServices(BuildContext context) {
    return [
      const _ServiceItem(
        title: "DESIGN",
        icon: FontAwesomeIcons.penRuler,
        description: "I can design the site based on your needs and suggestions. I can also design the app from scratch and consult you during the job.",
      ),
      const _ServiceItem(
        title: "DEVELOPMENT",
        icon: FontAwesomeIcons.laptopCode,
        description: "I can build the site based on your needs and suggestions. I can also build the application connecting modern APIs and databases.",
      ),
      const _ServiceItem(
        title: "MAINTENANCE",
        icon: FontAwesomeIcons.gears,
        description: "I can maintain the site based on your needs and suggestions. I can also fix bugs from scratch and consult you during the job.",
      ),
    ];
  }
}

class _ServiceItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const _ServiceItem({
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -16,
              top: -8,
              child: FaIcon(
                icon,
                size: 48,
                color: AppColors.textSecondary.withValues(alpha: 0.1),
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'skills_section.dart';
class MobileAboutSection extends StatelessWidget {
  const MobileAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDark,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                // Top Bar / Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About Me",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.surfaceWhite,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  "Performance-driven Flutter Developer with 3+ years of experience building scalable cross-platform applications (Android, iOS, Web). Specialist in Clean Architecture, DDD, and Monorepo (Melos) management. Proven expertise in integrating complex GraphQL APIs and real-time systems.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 32),

                // Services Section Title
                Text(
                  "Services",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.surfaceWhite,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Services List
                _buildServiceCard(
                  icon: FontAwesomeIcons.paintbrush,
                  iconColor: AppColors.neonBlue,
                  title: "Design",
                  description: "Design the UI and user experience based on your needs and industry standards.",
                ),
                const SizedBox(height: 12),
                _buildServiceCard(
                  icon: FontAwesomeIcons.code,
                  iconColor: AppColors.neonPurple,
                  title: "Development",
                  description: "Develop seamless cross-platform applications with robust architecture and APIs.",
                ),
                const SizedBox(height: 12),
                _buildServiceCard(
                  icon: FontAwesomeIcons.wrench,
                  iconColor: AppColors.neonPink,
                  title: "Maintenance",
                  description: "Maintain your site and apps, fix bugs quickly, and consult you during the process.",
                ),
                const SizedBox(height: 32),
                  ],
                ),
              ),
              const SkillsSection(),
            ],
          ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceWhite.withOpacity(0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.surfaceWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.textSecondary.withOpacity(0.8),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(IconData icon, String name, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.surfaceWhite.withOpacity(0.1),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(icon, color: color, size: 28),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.surfaceWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 12,
            right: 12,
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.8),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


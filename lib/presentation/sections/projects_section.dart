import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectItem {
  final String title;
  final String description;
  final List<String> techStack;
  final String link;

  ProjectItem({
    required this.title,
    required this.description,
    required this.techStack,
    required this.link,
  });
}

class ProjectsSection extends StatelessWidget {
  final List<ProjectItem> projects = [
    ProjectItem(
      title: "SCOREBLOX",
      description: "A Global Scale Cricket App managing real-time live scoring and massive concurrency, built with 12+ modular packages in a Melos monorepo.",
      techStack: ["Flutter", "GraphQL", "Melos", "Firebase"],
      link: "#",
    ),
    ProjectItem(
      title: "DUJO",
      description: "Full-stack School ERP system featuring roles for admins, teachers, and parents with comprehensive management tools powered by Firebase.",
      techStack: ["Flutter Web", "Firebase", "Cloud Functions"],
      link: "#",
    ),
    ProjectItem(
      title: "KIOSK",
      description: "Self-service application integrating basic functionalities like bill processing and user selection alongside special offers and discounts.",
      techStack: ["Flutter", "Supabase", "Integrations"],
      link: "#",
    ),
    ProjectItem(
      title: "FOOD DELIVERY",
      description: "Feature-rich application with user registration, authentications, menu management, order placement, and cart management.",
      techStack: ["Flutter", "Supabase", "QR Code"],
      link: "#",
    ),
    ProjectItem(
      title: "CLONER E-COMMERCE",
      description: "E-Commerce application utilizing Node.js backend. Major functionalities include mail verification, mobile verification, payment transactions.",
      techStack: ["Flutter", "Node.js", "Dio", "API"],
      link: "#",
    ),
    ProjectItem(
      title: "MUSIC BEATS",
      description: "Offline Music-Player App utilizing MVC architecture with Hive local database for playlist and favorites management.",
      techStack: ["Flutter", "Hive", "Provider"],
      link: "#",
    ),
    ProjectItem(
      title: "LAWYER HELPER",
      description: "AI-powered legal assistance tool with case management and judgments referencing, generating templates for legal professionals.",
      techStack: ["Flutter", "GetX", "Socket.IO", "REST API"],
      link: "#",
    ),
    ProjectItem(
      title: "NETFLIX CLONE",
      description: "Dynamic content application based on TMDB API. Responsive layout designed with Domain-Driven Design principles constraint.",
      techStack: ["Flutter", "Bloc", "Clean Architecture"],
      link: "#",
    ),
    ProjectItem(
      title: "BLOOD DONATION",
      description: "Community application connecting users needing blood with potential donors, integrated with admin user management capabilities.",
      techStack: ["Flutter", "Dart", "Firebase"],
      link: "#",
    ),
  ];

  ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: size.width,
      color: AppColors.backgroundDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.15,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "FEATURED PROJECTS",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.surfaceWhite,
              fontWeight: FontWeight.w900,
              letterSpacing: 4.0,
            ),
          ),
          const SizedBox(height: 64),

          isMobile
              ? Column(
                  children: projects.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: _ProjectCard(project: p),
                  )).toList(),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 48,
                    mainAxisSpacing: 48,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return _ProjectCard(project: projects[index]);
                  },
                ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectItem project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.primaryBlack,
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                project.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.surfaceWhite,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              if (project.link != '#')
                IconButton(
                  onPressed: () => launchUrl(Uri.parse(project.link)),
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowUpRightFromSquare,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              project.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.8,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: project.techStack.map((tech) {
              return Text(
                tech.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 10,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

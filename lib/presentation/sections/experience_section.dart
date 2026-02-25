import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ExperienceItem {
  final String company;
  final String role;
  final String duration;
  final String description;
  final List<String> highlights;

  ExperienceItem({
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
    required this.highlights,
  });
}

class ExperienceSection extends StatelessWidget {
  final List<ExperienceItem> experiences = [
    ExperienceItem(
      company: "Phenomtec Solutions Pvt. Ltd.",
      role: "Flutter Developer",
      duration: "Apr 2024 – Dec 2025 | Kochi, Kerala",
      description: "Flutter developer for Scoreblox, a large-scale multi-platform cricket application (Android, iOS, Web) serving global users.",
      highlights: [
        "Architected a monorepo infrastructure with 12+ modular packages using Melos for better maintainability.",
        "Implemented GraphQL API integration, custom caching, and real-time live scoring architecture.",
        "Developed multilingual support (8 languages), advanced analytics, prediction systems, and dynamic UI systems.",
        "Integrated Firebase ecosystem, native Android/iOS features, QR scanning, and YouTube player.",
        "Established Flutter Flavors, shader optimization, and code generation delivering highly optimized performance."
      ],
    ),
    ExperienceItem(
      company: "Lepton Plus Communications",
      role: "Flutter Developer",
      duration: "Sep 2023 – Mar 2024 | Thiruvananthapuram, Kerala",
      description: "Led the development of diverse employee, school, and warehouse management systems.",
      highlights: [
        "Led the development of an employee management app, delivering a robust and efficient solution.",
        "Contributed significantly to a school management app, enhancing functionality and user experience.",
        "Played a key role in warehouse management projects, optimizing inventory tracking and logistics."
      ],
    ),
    ExperienceItem(
      company: "Subhaprada Holdings Private Limited",
      role: "Flutter Developer",
      duration: "Oct 2022 – Sep 2023 | Visakhapatnam, Andhra Pradesh",
      description: "Demonstrated proficiency in crafting engaging and educational mobile applications.",
      highlights: [
        "Created a 2D game using Flutter, highlighting mobile game development skills.",
        "Developed a UPSC preparation app to streamline educational application building.",
        "Designed and developed a Language Learning App using Supabase backend integration."
      ],
    ),
    ExperienceItem(
      company: "Oksy IT Solutions",
      role: "Relationship Executive",
      duration: "May 2021 – Oct 2022 | Malappuram, Kerala",
      description: "Fostered client relationships and drove overarching operational excellence.",
      highlights: [],
    ),
  ];
  
  final List<ExperienceItem> educations = [
    ExperienceItem(
      company: "SPS, Calicut, Kerala",
      role: "Mobile Development using Flutter",
      duration: "May 2022 – Oct 2022",
      description: "Intensive training program focused on building cross-platform mobile applications using Flutter.",
      highlights: [],
    ),
    ExperienceItem(
      company: "Bharathiar University, Coimbatore, Tamil Nadu",
      role: "Bachelor of Computer Applications",
      duration: "2017 – 2020",
      description: "Undergraduate degree focusing on computer applications, software development, and programming principles.",
      highlights: [],
    ),
  ];

  ExperienceSection({super.key});

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBlack, width: 4),
            ),
            child: Text(
              "EXPERIENCE",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 4.0,
              ),
            ),
          ),
          const SizedBox(height: 80),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              return _ExperienceTimelineNode(
                item: experiences[index],
                isLast: index == experiences.length - 1,
                isMobile: isMobile,
              );
            },
          ),

          const SizedBox(height: 80),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBlack, width: 4),
            ),
            child: Text(
              "EDUCATION",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 4.0,
              ),
            ),
          ),
          const SizedBox(height: 80),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: educations.length,
            itemBuilder: (context, index) {
              return _ExperienceTimelineNode(
                item: educations[index],
                isLast: index == educations.length - 1,
                isMobile: isMobile,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ExperienceTimelineNode extends StatelessWidget {
  final ExperienceItem item;
  final bool isLast;
  final bool isMobile;

  const _ExperienceTimelineNode({
    required this.item,
    required this.isLast,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Dot
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceWhite,
                  border: Border.all(color: AppColors.primaryBlack, width: 4),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 200, // Approximate height to connect to the next item
                  color: AppColors.primaryBlack.withOpacity(0.2),
                ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flex(
                    crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    direction: isMobile ? Axis.vertical : Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.role.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primaryBlack,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      if (!isMobile) const SizedBox(width: 12),
                      Text(
                        "@ ${item.company}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.duration.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...item.highlights.map((highlight) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, right: 12.0),
                              child: Icon(Icons.circle, 
                                  size: 6, color: AppColors.primaryBlack),
                            ),
                            Expanded(
                              child: Text(
                                highlight,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      );
  }
}

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'experience_section.dart';
import 'projects_section.dart';
import 'creative_portfolio_section.dart';

class MobileWorkSection extends StatelessWidget {
  const MobileWorkSection({super.key});

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
            ExperienceSection(),
            ProjectsSection(),
            const CreativePortfolioSection(),
          ],
        ),
      ),
    );
  }
}

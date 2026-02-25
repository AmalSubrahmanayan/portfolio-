import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class _SkillItem {
  final String name;
  final IconData icon;
  final Color color;

  _SkillItem(this.name, this.icon, this.color);
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
          // SKILLS Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBlack, width: 4),
            ),
            child: Text(
              "SKILLS",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 4.0,
              ),
            ),
          ),
          const SizedBox(height: 80),

          // LANGUAGES
          _buildCategoryHeader(context, "LANGUAGES:"),
          const SizedBox(height: 32),
          _buildSkillsGrid(
            context,
            isMobile,
            [
              _SkillItem("FLUTTER", FontAwesomeIcons.mobileScreen, const Color(0xFF54C5F8)),
              _SkillItem("DART", FontAwesomeIcons.code, const Color(0xFF0175C2)),
              _SkillItem("C", FontAwesomeIcons.c, const Color(0xFF00599C)),
              _SkillItem("HTML/CSS", FontAwesomeIcons.fileCode, const Color(0xFFE44D26)),
            ],
          ),
          const SizedBox(height: 64),

          // DEVELOPER TOOLS
          _buildCategoryHeader(context, "DEVELOPER TOOLS & LIBS:"),
          const SizedBox(height: 32),
          _buildSkillsGrid(
            context,
            isMobile,
            [
              _SkillItem("VS CODE", FontAwesomeIcons.code, const Color(0xFF0066B8)),
              _SkillItem("ECLIPSE", FontAwesomeIcons.moon, const Color(0xFF2C2255)),
              _SkillItem("ANDROID STUD.", FontAwesomeIcons.android, const Color(0xFF3DDC84)),
              _SkillItem("FIGMA", FontAwesomeIcons.figma, const Color(0xFFF24E1E)),
              _SkillItem("GIT/GITHUB", FontAwesomeIcons.gitAlt, const Color(0xFFF05032)),
              _SkillItem("SOURCETREE", FontAwesomeIcons.codeBranch, const Color(0xFF205081)),
              _SkillItem("HIVE", FontAwesomeIcons.database, const Color(0xFFFFCA28)),
              _SkillItem("FIREBASE", FontAwesomeIcons.fire, const Color(0xFFFFCA28)),
              _SkillItem("DIO", FontAwesomeIcons.networkWired, const Color(0xFF00599C)),
              _SkillItem("PROVIDER", FontAwesomeIcons.cubes, const Color(0xFF651FFF)),
              _SkillItem("GETX", FontAwesomeIcons.rocket, const Color(0xFF9C27B0)),
              _SkillItem("BLOC & CUBIT", FontAwesomeIcons.cube, const Color(0xFF3F51B5)),
              _SkillItem("SUPABASE", FontAwesomeIcons.server, const Color(0xFF4CAF50)),
              _SkillItem("GOROUTER", FontAwesomeIcons.route, const Color(0xFF00BCD4)),
            ],
          ),
          const SizedBox(height: 64),

          // TECHNOLOGIES
          _buildCategoryHeader(context, "TECHNOLOGIES & CONCEPTS:"),
          const SizedBox(height: 32),
          _buildSkillsGrid(
            context,
            isMobile,
            [
              _SkillItem("LINUX", FontAwesomeIcons.linux, AppColors.primaryBlack),
              _SkillItem("REST APIS", FontAwesomeIcons.cloud, AppColors.textSecondary),
              _SkillItem("MVC / MVVM", FontAwesomeIcons.layerGroup, AppColors.textSecondary),
              _SkillItem("CLEAN ARCH.", FontAwesomeIcons.broom, const Color(0xFF795548)),
              _SkillItem("DDD", FontAwesomeIcons.building, const Color(0xFF607D8B)),
              _SkillItem("JSON", FontAwesomeIcons.code, const Color(0xFFFDD835)),
              _SkillItem("WORDPRESS", FontAwesomeIcons.wordpress, const Color(0xFF21759B)),
              _SkillItem("VIBE CODING", FontAwesomeIcons.music, const Color(0xFFE91E63)),
              _SkillItem("ANTIGRAVITY", FontAwesomeIcons.spaceShuttle, const Color(0xFF673AB7)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width < 768 ? 0 : MediaQuery.of(context).size.width * 0.1),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context, bool isMobile, List<_SkillItem> items) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : MediaQuery.of(context).size.width * 0.1),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : 4,
          crossAxisSpacing: 32,
          mainAxisSpacing: 32,
          mainAxisExtent: 120,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                item.icon,
                size: 48,
                color: item.color,
              ),
              const SizedBox(height: 16),
              Text(
                item.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}

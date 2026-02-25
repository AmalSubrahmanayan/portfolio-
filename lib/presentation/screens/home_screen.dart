import 'package:flutter/material.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/experience_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';
import '../sections/creative_portfolio_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define GlobalKeys for each section
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Scroll controller to track position
  late ScrollController _scrollController;
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to scroll to a specific section
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  // Function to scroll to the top
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(
              onAboutMePressed: () => _scrollToSection(_aboutKey),
              onSkillsPressed: () => _scrollToSection(_skillsKey),
              onPortfolioPressed: () => _scrollToSection(_portfolioKey),
              onContactPressed: () => _scrollToSection(_contactKey),
            ),
            Container(key: _aboutKey, child: const AboutSection()),
            Container(key: _skillsKey, child: const SkillsSection()),
            ExperienceSection(),
            Container(key: _portfolioKey, child: ProjectsSection()),
            const CreativePortfolioSection(),
            Container(key: _contactKey, child: const ContactSection()),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.surface,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/experience_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';
import '../sections/creative_portfolio_section.dart';
import '../widgets/portfolio_navigation_bar.dart';

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
  NavigationSection _activeSection = NavigationSection.none;
  bool _isScrollingToSection = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _updateActiveSection();
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
  void _scrollToSection(GlobalKey key, NavigationSection section) {
    if (_activeSection == section) return;

    setState(() {
      _activeSection = section;
      _isScrollingToSection = true;
    });

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );

    // Reset the lock after the animation is finished
    Future.delayed(const Duration(milliseconds: 850), () {
      if (mounted) {
        setState(() {
          _isScrollingToSection = false;
        });
      }
    });
  }

  void _updateActiveSection() {
    if (_isScrollingToSection) return;

    final sections = {
      NavigationSection.about: _aboutKey,
      NavigationSection.skills: _skillsKey,
      NavigationSection.portfolio: _portfolioKey,
      NavigationSection.contact: _contactKey,
    };

    NavigationSection currentActive = NavigationSection.none;
    
    // We'll consider the "active" section as the one that occupies the top 30% of the viewport
    final double threshold = MediaQuery.of(context).size.height * 0.3;

    for (var entry in sections.entries) {
      final context = entry.value.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        
        // If the top of the section has scrolled past the threshold, or if it's the first section
        if (position.dy < threshold) {
          currentActive = entry.key;
        }
      }
    }

    if (_activeSection != currentActive) {
      setState(() {
        _activeSection = currentActive;
      });
    }
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
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  onAboutMePressed: () => _scrollToSection(_aboutKey, NavigationSection.about),
                  onSkillsPressed: () => _scrollToSection(_skillsKey, NavigationSection.skills),
                  onPortfolioPressed: () => _scrollToSection(_portfolioKey, NavigationSection.portfolio),
                  onContactPressed: () => _scrollToSection(_contactKey, NavigationSection.contact),
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
          // Sticky Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavigationBar(
              activeSection: _activeSection,
              onAboutMePressed: () => _scrollToSection(_aboutKey, NavigationSection.about),
              onSkillsPressed: () => _scrollToSection(_skillsKey, NavigationSection.skills),
              onPortfolioPressed: () => _scrollToSection(_portfolioKey, NavigationSection.portfolio),
              onContactPressed: () => _scrollToSection(_contactKey, NavigationSection.contact),
              isMobile: MediaQuery.of(context).size.width < 900,
            ),
          ),
        ],
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

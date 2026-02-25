import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../presentation/widgets/animated_background.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onAboutMePressed;
  final VoidCallback? onSkillsPressed;
  final VoidCallback? onPortfolioPressed;
  final VoidCallback? onContactPressed;

  const HeroSection({
    super.key,
    this.onAboutMePressed,
    this.onSkillsPressed,
    this.onPortfolioPressed,
    this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    if (isMobile) {
      return _buildMobileLayout(context, size);
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          // Background Light (Full width behind the slanted black)
          Container(color: AppColors.backgroundLight),

          // Background Dark Slanted
          ClipPath(
            clipper: _SlantedClipper(),
            child: Stack(
              children: [
                Container(color: AppColors.backgroundDark),
                const Positioned.fill(child: AnimatedBackground()),
              ],
            ),
          ),

          // Navigation Bar (Transparent to show the split background)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildNavigationBar(context),
          ),

          // Main Content Left
          Positioned(
            left: size.width * 0.1,
            top: size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, I am",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Amal Subrahmanyan",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Flutter Developer",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _launchEmail,
                  child: Text(
                    "amalsubru@gmail.com",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildSocialIcons(),
              ],
            ),
          ),

          // Portrait Image Placeholder
          Positioned(
            bottom: 0,
            right: size.width * 0.15,
            child: Container(
              height: size.height * 0.85,
              width: size.width * 0.4,
              decoration: const BoxDecoration(color: Colors.transparent),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/Amal.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                height: size.height * 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, Size size) {
    return Container(
      width: size.width,
      color: AppColors.backgroundLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavigationBar(context, isMobile: true),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 48.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hi, I am",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _launchEmail,
                  child: Text(
                    "amalsubru@gmail.com",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Flutter Developer",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                _buildSocialIcons(center: true),
                const SizedBox(height: 48),
                Container(
                  height: 400,
                  width: double.infinity,
                  color: AppColors.backgroundDark,
                  child: Image.asset(
                    'assets/images/Amal.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context, {bool isMobile = false}) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : MediaQuery.of(context).size.width * 0.1,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo placeholder
          const Text(
            "AS",
            style: TextStyle(
              color: AppColors.surfaceWhite,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),

          if (!isMobile)
            Row(
              children: [
                _navItem("About me", onAboutMePressed),
                const SizedBox(width: 32),
                _navItem("Skills", onSkillsPressed),
                const SizedBox(width: 32),
                _navItem("Portfolio", onPortfolioPressed),
                const SizedBox(width: 32),
                ElevatedButton(
                  onPressed: onContactPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surfaceWhite,
                    foregroundColor: AppColors.primaryBlack,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    "CONTACT ME",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.surfaceWhite,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSocialIcons({bool center = false}) {
    return Row(
      mainAxisAlignment: center
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        _socialIcon(FontAwesomeIcons.at, onPressed: _launchEmail),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.github, onPressed: _launchGitHub),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.linkedinIn, onPressed: _launchLinkedIn),
      ],
    );
  }

  Widget _socialIcon(IconData icon, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: FaIcon(icon, color: AppColors.primaryBlack, size: 20),
        ),
      ),
    );
  }

  Future<void> _launchLinkedIn() async {
    final Uri url = Uri.parse(
      'https://www.linkedin.com/in/amal-subrahmanyan-832082209/',
    );
    if (!await launchUrl(url)) {
      throw Exception('Could not launch LinkedIn');
    }
  }

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/AmalSubrahmanayan');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch GitHub');
    }
  }

  Future<void> _launchEmail() async {
    final Uri url = Uri.parse('mailto:amalsubru@gmail.com');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch email');
    }
  }
}

class _SlantedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Start slightly past the middle on the top
    path.moveTo(size.width * 0.55, 0);
    // Draw line to top right
    path.lineTo(size.width, 0);
    // Draw line to bottom right
    path.lineTo(size.width, size.height);
    // Draw line to bottom middle (slanted leftwards from top)
    path.lineTo(size.width * 0.45, size.height);
    // Close the path back to the start
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

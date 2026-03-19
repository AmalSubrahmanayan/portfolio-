import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class MobileHomeSection extends StatelessWidget {
  const MobileHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      width: size.width,
      height: size.height,
      color: AppColors.primaryBlack,
      child: Stack(
        children: [
          // Background Full-Screen Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Amal_mobile.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          
          // Dark Gradient Overlay for the bottom so the card blends/pops out
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.5, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // Top Action Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back / Menu Button
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.black.withOpacity(0.4),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Profile Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.05),
                        width: 1,
                      ),
                    ),
                    // Wrapping the Column in SingleChildScrollView and Flexible to prevent any overflow on small screens
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Amal\nSubrahmanyan",
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28, // slight reduction for safety
                                    height: 1.1, // Tight leading
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Handle
                          Text(
                            "@amal_subrahmanyan",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Bio
                          Text(
                            "Performance-driven Flutter Developer focused on creating impactful, scalable cross-platform digital experiences and applications.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 13, // Slightly reduced font size to save vertical space
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Social Links Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSocialIcon(FontAwesomeIcons.linkedinIn, _launchLinkedIn),
                              _buildSocialIcon(FontAwesomeIcons.github, _launchGitHub),
                              _buildSocialIcon(FontAwesomeIcons.solidEnvelope, _launchEmail),
                              _buildSocialIcon(FontAwesomeIcons.whatsapp, _launchWhatsApp),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Action Button (DOWNLOAD RESUME)
                          Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFFB75E), // Light orange
                                  Color(0xFFFF7B8E), // Pink
                                  Color(0xFFC77DFF), // Purple
                                  Color(0xFF8A2BE2), // Neon Blue equivalent
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: _launchResume,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                "RESUME",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          
                          // Fake home indicator inside the card just for the aesthetic
                          const SizedBox(height: 12),
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: FaIcon(
          icon,
          color: Colors.white.withOpacity(0.8),
          size: 24,
        ),
      ),
    );
  }

  Future<void> _launchLinkedIn() async {
    final Uri url = Uri.parse(dotenv.env['LINKEDIN_URL'] ?? '');
    if (!await launchUrl(url)) throw Exception('Could not launch LinkedIn');
  }

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse(dotenv.env['GITHUB_URL'] ?? '');
    if (!await launchUrl(url)) throw Exception('Could not launch GitHub');
  }

  Future<void> _launchWhatsApp() async {
    final Uri url = Uri.parse(dotenv.env['WHATSAPP_URL'] ?? '');
    if (!await launchUrl(url)) throw Exception('Could not launch WhatsApp');
  }

  Future<void> _launchEmail() async {
    final Uri url = Uri.parse('mailto:${dotenv.env['EMAIL_ADDRESS'] ?? ''}');
    if (!await launchUrl(url)) throw Exception('Could not launch email');
  }

  Future<void> _launchResume() async {
    final Uri url = Uri.parse(dotenv.env['RESUME_URL'] ?? '');
    if (!await launchUrl(url)) throw Exception('Could not launch resume');
  }
}

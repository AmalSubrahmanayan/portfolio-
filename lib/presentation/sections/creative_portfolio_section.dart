import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class CreativePortfolioSection extends StatefulWidget {
  const CreativePortfolioSection({super.key});

  @override
  State<CreativePortfolioSection> createState() =>
      _CreativePortfolioSectionState();
}

class _CreativePortfolioSectionState extends State<CreativePortfolioSection> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      width: double.infinity,
      height: isMobile ? 600 : 800,
      color: AppColors.backgroundDark,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: const [
              _PortfolioDesign1(),
              _PortfolioDesign3(),
              _PortfolioDesign4(),
              _PortfolioDesign2(),
            ],
          ),

          // Slider Indicators
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: _currentPage == index ? 1.0 : 0.3,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioDesign1 extends StatelessWidget {
  const _PortfolioDesign1();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Large background text "PORTFOLIO"
            IgnorePointer(
              child: Positioned(
                bottom: height * 0.1,
                child: Text(
                  'PORTFOLIO',
                  style: GoogleFonts.anton(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: isMobile ? 120 : 380,
                    letterSpacing: -5,
                  ),
                ),
              ),
            ),

            // Model Image
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/images/portfolio_model.png',
                height: height * 0.9,
                fit: BoxFit.contain,
              ),
            ),

            // "CREATIVE" text
            Positioned(
              top: height * 0.15,
              left: width * 0.05,
              child: Text(
                'CREATIVE',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: isMobile ? 32 : 64,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ),

            // Top right info
            Positioned(
              top: height * 0.05,
              right: width * 0.05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'DECEMBER / 2025',
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: isMobile ? 14 : 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'AMAL SUBRAHMANYAN',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: isMobile ? 16 : 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Lorem Ipsum - Left Column
            Positioned(
              bottom: height * 0.1,
              left: width * 0.05,
              width: width * 0.35,
              child: Text(
                'I am a dedicated Flutter Developer with a passion for crafting high-performance, visually stunning mobile and web applications. My expertise extends into UI/UX design, ensuring every product is as intuitive as it is beautiful.',
                style: GoogleFonts.lato(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: isMobile ? 10 : 14,
                  height: 1.5,
                ),
              ),
            ),

            // Bottom Lorem Ipsum - Right Column
            Positioned(
              bottom: height * 0.1,
              right: width * 0.05,
              width: width * 0.35,
              child: Text(
                'When I\'m not coding or designing, you\'ll likely find me submerged in the world of gaming. I believe that being a gamer enhances my perspective on interactive design and user engagement within the digital realm.',
                textAlign: TextAlign.right,
                style: GoogleFonts.lato(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: isMobile ? 10 : 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PortfolioDesign2 extends StatelessWidget {
  const _PortfolioDesign2();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    const creamColor = Color(0xFFE8E1D1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Top Left: Creative Presentation
            Positioned(
              top: height * 0.05,
              left: width * 0.05,
              child: Text(
                'Creative Presentation',
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: isMobile ? 14 : 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // Top Right: Arrow
            Positioned(
              top: height * 0.05,
              right: width * 0.05,
              child: Icon(
                Icons.trending_flat,
                color: creamColor,
                size: isMobile ? 32 : 48,
              ),
            ),

            // Layer 0: Background Text (THA     YOU)
            IgnorePointer(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.anton(
                    fontSize: isMobile ? 80 : 280,
                    letterSpacing: isMobile ? 2 : 10,
                  ),
                  children: [
                    TextSpan(
                      text: 'THA',
                      style: TextStyle(color: creamColor),
                    ),
                    const TextSpan(
                      text: 'NK',
                      style: TextStyle(color: Colors.transparent),
                    ),
                    TextSpan(
                      text: ' YOU',
                      style: TextStyle(color: creamColor),
                    ),
                  ],
                ),
              ),
            ),

            // Layer 1: Model Image (Center Overlapping)
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/images/thank_you_model.png',
                height: height * 0.9,
                fit: BoxFit.contain,
              ),
            ),

            // Layer 2: Foreground Outline Text (   NK    )
            IgnorePointer(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.anton(
                    fontSize: isMobile ? 80 : 280,
                    letterSpacing: isMobile ? 2 : 10,
                  ),
                  children: [
                    const TextSpan(
                      text: 'THA',
                      style: TextStyle(color: Colors.transparent),
                    ),
                    TextSpan(
                      text: 'NK',
                      style: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = isMobile ? 2.0 : 4.0
                          ..color = creamColor,
                      ),
                    ),
                    const TextSpan(
                      text: ' YOU',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Right: URL
            Positioned(
              bottom: height * 0.1,
              right: width * 0.05,
              child: Text(
                'www.Amalsubrahmanyan.com',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: isMobile ? 14 : 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PortfolioDesign3 extends StatelessWidget {
  const _PortfolioDesign3();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFF7E00), Color(0xFFFF5200)],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Header Navigation
              Positioned(
                top: height * 0.05,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'AMAL',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: isMobile ? 14 : 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                      Column(
                        children: [
                          Container(width: 40, height: 2, color: Colors.white),
                          const SizedBox(height: 4),
                          // Text(
                          //   'MENU',
                          //   style: GoogleFonts.montserrat(
                          //     color: Colors.white,
                          //     fontSize: 10,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ],
                      ),
                      Text(
                        'CONTACT',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: isMobile ? 14 : 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Background Text "FLUTTER"
              IgnorePointer(
                child: Positioned(
                  child: Center(
                    child: Text(
                      'FLUTTER',
                      style: GoogleFonts.anton(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: isMobile ? 120 : 380,
                        letterSpacing: -5,
                      ),
                    ),
                  ),
                ),
              ),

              // Model Image (Using existing asset as placeholder)
              Positioned(
                bottom: 0,
                child: Image.asset(
                  'assets/images/amal3-.png', // Placeholder
                  height: height * 0.9,
                  fit: BoxFit.contain,
                  color: Colors.orange.withValues(alpha: 0.1),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PortfolioDesign4 extends StatelessWidget {
  const _PortfolioDesign4();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    const cremaColor = Color(0xFFF8F5F2);

    return Container(
      color: cremaColor,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.05,
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Creative Presentation',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: isMobile ? 12 : 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
              Text(
                'Amal Subrahmanyan',
                style: GoogleFonts.montserrat(
                  color: Colors.black54,
                  fontSize: isMobile ? 12 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '25 Feb, 2026',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: isMobile ? 12 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Main Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Vertical Image
              Expanded(
                flex: 2,
                child: Container(
                  height: isMobile ? 300 : 450,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 40),
              // Right: Text and Sub-images
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DESIGN',
                      style: GoogleFonts.anton(
                        color: Colors.black,
                        fontSize: isMobile ? 48 : 84,
                        letterSpacing: -2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'I am a dedicated Flutter Developer with a passion for crafting high-performance, visually stunning mobile and web applications. My expertise extends into UI/UX design, ensuring every product is as intuitive as it is beautiful.',
                      style: GoogleFonts.lato(
                        color: Colors.black87,
                        fontSize: isMobile ? 12 : 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 70),
                    // Small Images Row
                    Row(
                      children: [
                        _smallImageItem(
                          'assets/images/logo_music_beats.png',
                          'Music Beats Logo',
                          isMobile,
                        ),
                        const SizedBox(width: 16),
                        _smallImageItem(
                          'assets/images/logo_cloner.png',
                          'App Icon Design',
                          isMobile,
                        ),
                        const SizedBox(width: 16),
                        _smallImageItem(
                          'assets/images/character_dharavi.png',
                          'Character Illustration',
                          isMobile,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _smallImageItem(String asset, String label, bool isMobile) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: isMobile ? 120 : 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(asset),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: Colors.black54,
              fontSize: isMobile ? 8 : 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

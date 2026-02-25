import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:flutter/rendering.dart';

enum NavigationSection { about, skills, portfolio, contact, none }

class PortfolioNavigationBar extends StatefulWidget {
  final NavigationSection activeSection;
  final VoidCallback onAboutMePressed;
  final VoidCallback onSkillsPressed;
  final VoidCallback onPortfolioPressed;
  final VoidCallback onContactPressed;
  final bool isMobile;

  const PortfolioNavigationBar({
    super.key,
    required this.activeSection,
    required this.onAboutMePressed,
    required this.onSkillsPressed,
    required this.onPortfolioPressed,
    required this.onContactPressed,
    this.isMobile = false,
  });

  @override
  State<PortfolioNavigationBar> createState() => _PortfolioNavigationBarState();
}

class _PortfolioNavigationBarState extends State<PortfolioNavigationBar> {
  final Map<NavigationSection, GlobalKey> _keys = {
    NavigationSection.about: GlobalKey(),
    NavigationSection.skills: GlobalKey(),
    NavigationSection.portfolio: GlobalKey(),
    NavigationSection.contact: GlobalKey(),
  };

  double _indicatorLeft = 0;
  double _indicatorWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  @override
  void didUpdateWidget(PortfolioNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeSection != widget.activeSection) {
      _updateIndicator();
    }
  }

  void _updateIndicator() {
    if (widget.activeSection == NavigationSection.none || widget.isMobile) {
      setState(() {
        _indicatorWidth = 0;
      });
      return;
    }

    final key = _keys[widget.activeSection];
    if (key == null) return;

    final context = key.currentContext;
    if (context == null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    
    // We need the position relative to the Row or Container
    final navBox = this.context.findRenderObject() as RenderBox;
    final relativePosition = navBox.globalToLocal(position);

    setState(() {
      _indicatorLeft = relativePosition.dx;
      _indicatorWidth = renderBox.size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundDark.withOpacity(0.95),
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 24 : MediaQuery.of(context).size.width * 0.1,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          const Text(
            "AS",
            style: TextStyle(
              color: AppColors.surfaceWhite,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),

          if (!widget.isMobile)
            Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    _navItem("About me", NavigationSection.about, widget.onAboutMePressed),
                    const SizedBox(width: 32),
                    _navItem("Skills", NavigationSection.skills, widget.onSkillsPressed),
                    const SizedBox(width: 32),
                    _navItem("Portfolio", NavigationSection.portfolio, widget.onPortfolioPressed),
                    const SizedBox(width: 32),
                    _navItem("Contact me", NavigationSection.contact, widget.onContactPressed),
                  ],
                ),
                // Sliding Indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  left: _indicatorLeft,
                  bottom: -8,
                  width: _indicatorWidth,
                  height: 3,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: widget.activeSection == NavigationSection.none ? 0 : 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.surfaceWhite.withOpacity(0.4),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, NavigationSection section, VoidCallback onPressed) {
    final bool isActive = widget.activeSection == section;
    
    return InkWell(
      key: _keys[section],
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          style: TextStyle(
            color: isActive ? AppColors.surfaceWhite : AppColors.surfaceWhite.withOpacity(0.6),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 14,
            letterSpacing: isActive ? 0.5 : 0,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}

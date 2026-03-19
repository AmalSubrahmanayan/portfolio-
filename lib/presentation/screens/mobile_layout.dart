import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../sections/mobile_home_section.dart';
import '../sections/mobile_about_section.dart';
import '../sections/mobile_work_section.dart';
import '../sections/mobile_contact_section.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _currentIndex = 0;

  final List<Widget> _sections = [
    const MobileHomeSection(),
    const MobileAboutSection(),
    const MobileWorkSection(),
    const MobileContactSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: IndexedStack(
        index: _currentIndex,
        children: _sections,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF141416), // Match deep dark background
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.neonPurple, // Highlighted with neon purple
        unselectedItemColor: AppColors.textSecondary.withOpacity(0.5),
        elevation: 0, // No shadow or border above
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: 'Work',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined),
            activeIcon: Icon(Icons.email),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../sections/mobile_home_section.dart';
import '../sections/mobile_about_section.dart';
import '../sections/mobile_work_section.dart';
import '../sections/mobile_contact_section.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            MobileHomeSection(),
            MobileAboutSection(),
            MobileWorkSection(),
            MobileContactSection(),
          ],
        ),
      ),
    );
  }
}

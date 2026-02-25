import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: size.width,
      color: AppColors.surfaceWhite,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.15,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBlack, width: 4),
            ),
            child: Text(
              "CONTACT",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 4.0,
              ),
            ),
          ),
          const SizedBox(height: 80),

          Text(
            "Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 64),

          // Contact Form & Info
          isMobile
              ? const _ContactForm()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      flex: 3,
                      child: _ContactForm(),
                    ),
                    SizedBox(width: 80),
                    Expanded(
                      flex: 2,
                      child: _ContactInfo(),
                    ),
                  ],
                ),
                
          if (isMobile) const SizedBox(height: 64),
          if (isMobile) const _ContactInfo(),
          
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField("ENTER YOUR SUBJECT", isEmail: false),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildTextField("ENTER YOUR NAME*", isEmail: false)),
            const SizedBox(width: 24),
            Expanded(child: _buildTextField("ENTER YOUR EMAIL*", isEmail: true)),
          ],
        ),
        const SizedBox(height: 24),
        _buildTextField("PHONE NUMBER", isEmail: false),
        const SizedBox(height: 24),
        _buildTextField("YOUR MESSAGE*", isEmail: false, maxLines: 5),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.backgroundLight,
            foregroundColor: AppColors.primaryBlack,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            shape: const RoundedRectangleBorder(),
            side: const BorderSide(color: AppColors.primaryBlack, width: 2),
            elevation: 0,
          ),
          child: Text(
            "SUBMIT",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlack,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String hint, {required bool isEmail, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.primaryBlack, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
          letterSpacing: 1.5,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: AppColors.backgroundLight,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlack.withValues(alpha: 0.2), width: 1),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlack, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem(
          context,
          "Kochi, Kerala",
          "Current Location",
          FontAwesomeIcons.locationDot,
        ),
        const SizedBox(height: 32),
        _buildInfoItem(
          context,
          "amalsubru@gmail.com",
          "Email Address",
          FontAwesomeIcons.envelope,
        ),
        const SizedBox(height: 32),
        _buildInfoItem(
          context,
          "+91 9562666753",
          "Phone Number",
          FontAwesomeIcons.phone,
        ),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String title, String subtitle, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, color: AppColors.primaryBlack, size: 24),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlack,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

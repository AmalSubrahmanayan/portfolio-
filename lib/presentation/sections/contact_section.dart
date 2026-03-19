import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
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

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendToWhatsApp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    final phone = _phoneController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || message.isEmpty) return;

    final targetPhone = dotenv.env['PHONE_NUMBER']?.replaceAll(RegExp(r'[^0-9]'), '') ?? "";
    final text = "Hello Amal,\n\nI am $name.\nEmail: $email\nPhone: $phone\nSubject: $subject\n\n$message";
    final url = Uri.parse("https://wa.me/$targetPhone?text=${Uri.encodeComponent(text)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField("ENTER YOUR SUBJECT", controller: _subjectController),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildTextField("ENTER YOUR NAME*", controller: _nameController)),
            const SizedBox(width: 24),
            Expanded(child: _buildTextField("ENTER YOUR EMAIL*", controller: _emailController, keyboardType: TextInputType.emailAddress)),
          ],
        ),
        const SizedBox(height: 24),
        _buildTextField("PHONE NUMBER", controller: _phoneController, keyboardType: TextInputType.phone),
        const SizedBox(height: 24),
        _buildTextField("YOUR MESSAGE*", controller: _messageController, maxLines: 5),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _sendToWhatsApp,
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

  Widget _buildTextField(String hint, {TextEditingController? controller, int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
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
          borderSide: BorderSide(color: AppColors.primaryBlack.withOpacity(0.2), width: 1),
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
          dotenv.env['EMAIL_ADDRESS'] ?? "",
          "Email Address",
          FontAwesomeIcons.envelope,
        ),
        const SizedBox(height: 32),
        _buildInfoItem(
          context,
          dotenv.env['PHONE_NUMBER'] ?? "",
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

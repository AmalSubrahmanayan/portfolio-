import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
class MobileContactSection extends StatefulWidget {
  const MobileContactSection({super.key});

  @override
  State<MobileContactSection> createState() => _MobileContactSectionState();
}

class _MobileContactSectionState extends State<MobileContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendToWhatsApp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || message.isEmpty) return;

    final targetPhone = dotenv.env['PHONE_NUMBER']?.replaceAll(RegExp(r'[^0-9]'), '') ?? "";
    final text = "Hello Amal,\n\nI am $name.\nEmail: $email\n\n$message";
    final url = Uri.parse("https://wa.me/$targetPhone?text=${Uri.encodeComponent(text)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDark,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar / Title
                Text(
                  "Get In Touch",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.surfaceWhite,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Have a project in mind or just want to say hi? Feel free to reach out!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 32),

                // Contact Info
                _buildContactInfoItem(
                  icon: FontAwesomeIcons.envelope,
                  color: AppColors.neonBlue,
                  title: dotenv.env['EMAIL_ADDRESS'] ?? "",
                  subtitle: "Email Address",
                ),
                const SizedBox(height: 24),
                _buildContactInfoItem(
                  icon: FontAwesomeIcons.phone,
                  color: AppColors.neonPurple,
                  title: dotenv.env['PHONE_NUMBER'] ?? "",
                  subtitle: "Phone Number",
                ),
                const SizedBox(height: 24),
                _buildContactInfoItem(
                  icon: FontAwesomeIcons.locationDot,
                  color: AppColors.neonPink,
                  title: "Kochi, Kerala",
                  subtitle: "Current Location",
                ),
                const SizedBox(height: 48),

                // Contact Form Title
                Text(
                  "Send a Message",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.surfaceWhite,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 24),

                // Form Fields
                _buildTextField("Your Name", controller: _nameController),
                const SizedBox(height: 16),
                _buildTextField("Your Email", controller: _emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                _buildTextField("Message", controller: _messageController, maxLines: 5),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [AppColors.neonBlue, AppColors.neonPurple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonBlue.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _sendToWhatsApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "SEND MESSAGE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
      ),
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Center(
            child: FaIcon(icon, color: color, size: 20),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.surfaceWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String hint, {TextEditingController? controller, int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.surfaceWhite, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.textSecondary.withOpacity(0.5),
          fontSize: 14,
        ),
        filled: true,
        fillColor: AppColors.surfaceWhite.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.surfaceWhite.withOpacity(0.1), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.neonPurple, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}


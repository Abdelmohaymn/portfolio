import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:portfolio/widgets/contact_item.dart';
import 'package:portfolio/widgets/social_icon.dart';
import 'package:portfolio/constants/colors.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 48),
          if (isMobile) _buildMobileContent(context) else _buildDesktopContent(context),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let\'s Connect',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'I\'m always interested in new opportunities and exciting projects. Whether you have a question or just want to say hi, feel free to reach out!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 204), // 0.8 * 255
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              _buildContactInfo(context),
              const SizedBox(height: 32),
              _buildSocialLinks(context),
            ],
          ),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 1,
          child: _buildContactForm(context),
        ),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let\'s Connect',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'I\'m always interested in new opportunities and exciting projects. Whether you have a question or just want to say hi, feel free to reach out!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 204), // 0.8 * 255
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        _buildContactInfo(context),
        const SizedBox(height: 32),
        _buildSocialLinks(context),
        const SizedBox(height: 48),
        _buildContactForm(context),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactItem(
          icon: Icons.email_outlined,
          text: 'email@example.com',
          onTap: () => _launchUrl('mailto:email@example.com'),
        ),
        const SizedBox(height: 16),
        ContactItem(
          icon: Icons.phone,
          text: 'WhatsApp',
          onTap: () => _launchUrl('https://wa.me/1234567890'),
        ),
        const SizedBox(height: 16),
        ContactItem(
          icon: Icons.link,
          text: 'LinkedIn',
          onTap: () => _launchUrl('https://linkedin.com/in/yourprofile'),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Follow me:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 16),
        SocialIcon(
          icon: Icons.link,
          onTap: () => _launchUrl('https://linkedin.com/in/yourprofile'),
        ),
        const SizedBox(width: 12),
        SocialIcon(
          svgPath: 'assets/icons/google_play.svg',
          onTap: () => _launchUrl('https://github.com/yourusername'),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send me a message',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          _buildFormField(
            context: context,
            label: 'Name',
            hintText: 'Enter your name',
            inputType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          _buildFormField(
            context: context,
            label: 'Email',
            hintText: 'Enter your email address',
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _buildFormField(
            context: context,
            label: 'Subject',
            hintText: 'What is this about?',
            inputType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          _buildFormField(
            context: context,
            label: 'Message',
            hintText: 'Your message here...',
            inputType: TextInputType.multiline,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required BuildContext context,
    required String label,
    required String hintText,
    required TextInputType inputType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: inputType,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          cursorColor: AppColors.gradientStart,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 102), // 0.4 * 255
            ),
            filled: true,
            fillColor: AppColors.overlay, // 0.2 * 255
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 51),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 51),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF8B5CF6),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        var isHovered = false;
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          cursor: SystemMouseCursors.click,
          child: Transform.scale(
            scale: isHovered ? 1.02 : 1.0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.cardBorder,
                  width: 1.5,
                ),

              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO: Handle form submission
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Send Message',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await url_launcher.canLaunchUrl(uri)) {
        await url_launcher.launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}

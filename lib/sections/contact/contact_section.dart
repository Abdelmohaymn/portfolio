import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:portfolio/widgets/contact_item.dart';
import 'package:portfolio/widgets/social_icon.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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
                  color: Colors.white.withValues(alpha: 204),
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
            color: Colors.white.withValues(alpha: 204),
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
          iconPath: 'assets/icons/email.svg',
          text: MockData.emailValue,
          onTap: () => _launchUrl('mailto:${MockData.emailValue}'),
        ),
        const SizedBox(height: 16),
        ContactItem(
          iconPath: 'assets/icons/whatsapp.svg',
          text: 'WhatsApp',
          onTap: () => _launchUrl('https://wa.me/${MockData.phoneValue}'),
        ),
        const SizedBox(height: 16),
        ContactItem(
          iconPath: 'assets/icons/linkedin.svg',
          text: 'LinkedIn',
          onTap: () => _launchUrl(MockData.linkedInValue),
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
          svgPath: 'assets/icons/linkedin.svg',
          onTap: () => _launchUrl(MockData.linkedInValue),
        ),
        const SizedBox(width: 12),
        SocialIcon(
          svgPath: 'assets/icons/github.svg',
          onTap: () => _launchUrl(MockData.githubValue),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
              controller: _nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildFormField(
              context: context,
              label: 'Email',
              hintText: 'Enter your email address',
              inputType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!_isValidEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildFormField(
              context: context,
              label: 'Subject',
              hintText: 'What is this about?',
              inputType: TextInputType.text,
              controller: _subjectController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Subject is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildFormField(
              context: context,
              label: 'Message',
              hintText: 'Your message here...',
              inputType: TextInputType.multiline,
              maxLines: 4,
              controller: _messageController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Message is required';
                }
                if (value.trim().length < 10) {
                  return 'Message should be at least 10 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required BuildContext context,
    required String label,
    required String hintText,
    required TextInputType inputType,
    required TextEditingController controller,
    required String? Function(String?) validator,
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
          controller: controller,
          validator: validator,
          keyboardType: inputType,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          cursorColor: AppColors.gradientStart,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 102),
            ),
            filled: true,
            fillColor: AppColors.overlay,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
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
                gradient: _isLoading
                    ? LinearGradient(
                  colors: [
                    AppColors.gradientStart.withOpacity(0.6),
                    AppColors.gradientEnd.withOpacity(0.6),
                  ],
                )
                    : AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.cardBorder,
                  width: 1.5,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _isLoading ? null : _handleSubmit,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else ...[
                          const Text(
                            'Send Message',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _sendEmail();
      _showSuccessMessage('Message sent successfully!');
      _clearForm();
    } catch (e) {
      _showErrorMessage('Failed to send message. Please try again.');
      debugPrint('Error sending email: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: MockData.emailValue, // Your email address
      queryParameters: {
        'subject': '${_subjectController.text} - From ${_nameController.text}',
        'body': '''
Name: ${_nameController.text}
Email: ${_emailController.text}
Subject: ${_subjectController.text}

Message:
${_messageController.text}

---
Sent from Portfolio Contact Form
        ''',
      },
    );

    if (await url_launcher.canLaunchUrl(emailUri)) {
      await url_launcher.launchUrl(emailUri);
    } else {
      throw Exception('Could not launch email client');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim());
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
    _formKey.currentState?.reset();
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
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
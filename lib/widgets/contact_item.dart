import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

class ContactItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ContactItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          //padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.withAlpha(Colors.white, 0.05),
            border: Border.all(color: AppColors.cardBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween<double>(
                  begin: 1.0,
                  end: isHovered ? 1.1 : 1.0,
                ),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                    boxShadow: [
                      if (isHovered)
                        BoxShadow(
                          color: AppColors.withAlpha(AppColors.gradientStart, 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                    ],
                  ),
                  child: Icon(widget.icon, color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: 16),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  foreground: isHovered ? (Paint()
                    ..shader = AppColors.primaryGradient.createShader(
                      const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                    ))
                  : null,
                  color: isHovered ? null : Colors.white,
                ),
                child: Text(widget.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

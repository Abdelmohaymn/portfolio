import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/colors.dart';

class SocialIcon extends StatefulWidget {
  final IconData? icon;
  final String? svgPath;
  final VoidCallback? onTap;

  const SocialIcon({
    super.key,
    this.icon,
    this.svgPath,
    this.onTap,
  }) : assert(icon != null || svgPath != null, 'Either icon or svgPath must be provided');

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: isHovered ? Matrix4.identity() : Matrix4.identity(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
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
            child: widget.icon != null
                ? Icon(widget.icon, color: Colors.white, size: 24)
                : SvgPicture.asset(
                    widget.svgPath!,
                    width: 30,
                    height: 30,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
          ),
        ),
      ),
    );
  }
}

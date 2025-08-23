import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';

class StoreIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  final bool isHovered;
  final ValueChanged<bool> onHoverChanged;

  const StoreIconButton({super.key,
    required this.iconPath,
    required this.onTap,
    required this.isHovered,
    required this.onHoverChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: isHovered ? 1.1 : 1.0,
          child: ShaderMask(
            shaderCallback: (bounds) => (isHovered
                ? AppColors.primaryGradient
                : const LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )).createShader(bounds),
            child: SvgPicture.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
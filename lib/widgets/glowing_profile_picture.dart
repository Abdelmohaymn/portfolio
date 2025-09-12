import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';

class GlowingProfilePicture extends StatefulWidget {
  final double size;

  const GlowingProfilePicture({
    super.key,
    this.size = 300,
  });

  @override
  State<GlowingProfilePicture> createState() => _GlowingProfilePictureState();
}

class _GlowingProfilePictureState extends State<GlowingProfilePicture>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _glowAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOutSine,
    ));

    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: AppDimensions.animationDurationNormal,
        curve: Curves.easeOut,
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  // Multiple layers of glow for better effect
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4 * _glowAnimation.value),
                    blurRadius: 30 * _glowAnimation.value,
                    spreadRadius: 10 * _glowAnimation.value,
                  ),
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.3 * _glowAnimation.value),
                    blurRadius: 60 * _glowAnimation.value,
                    spreadRadius: 20 * _glowAnimation.value,
                  ),
                  BoxShadow(
                    color: AppColors.accentPurple.withValues(alpha: 0.2 * _glowAnimation.value),
                    blurRadius: 90 * _glowAnimation.value,
                    spreadRadius: 30 * _glowAnimation.value,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: widget.size,
                backgroundColor: AppColors.accentOrange,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: CircleAvatar(
                    radius: widget.size,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    backgroundColor: AppColors.cardBackgroundAlt,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

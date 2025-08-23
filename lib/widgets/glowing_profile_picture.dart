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
    return AnimatedBuilder(
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
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
             color: AppColors.cardBackgroundAlt,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.png', // Add your profile picture path
                fit: BoxFit.cover,
                width: widget.size - 6, // Account for border
                height: widget.size - 6,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: widget.size - 6,
                    height: widget.size - 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                    ),
                    child: Icon(
                      Icons.person,
                      size: widget.size * 0.5,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/index.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _glowController;
  late AnimationController _backgroundAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDimensions.animationDurationFast,
      vsync: this,
    );
    _glowController = AnimationController(
      duration: AppDimensions.glowAnimationDuration,
      vsync: this,
    );
    _backgroundAnimation = AnimationController(
      duration: AppDimensions.backgroundAnimationDuration,
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    // Start the glow and background animations
    _glowController.repeat(reverse: true);
    _backgroundAnimation.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _glowController.dispose();
    _backgroundAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppDimensions.mobileBreakpoint;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      height: size.height - appBarHeight - statusBarHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.sectionPaddingHorizontalMobile : AppDimensions.sectionPaddingHorizontal,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Stack(
        children: [
          // Animated background shapes
          _buildAnimatedBackground(),
          // Content
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: BackgroundPainter(_backgroundAnimation.value),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              SizedBox(height: AppDimensions.spacingHuge),
              ShaderMask(
                shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  AppStrings.heroGreeting,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
              height: 1.1,
            ),
          ),
              ),
              SizedBox(height: AppDimensions.spacingXL),
          Text(
                AppStrings.heroTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
              SizedBox(height: AppDimensions.spacingXXL),
          Text(
                AppStrings.heroDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
              height: 1.6,
            ),
          ),
              SizedBox(height: AppDimensions.spacingXXXL),
          Wrap(
                spacing: AppDimensions.spacingM,
                runSpacing: AppDimensions.spacingM,
            children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
                    ),
                    child: GradientButton(
                      text: AppStrings.viewWorkButton,
                onPressed: () {
                  // TODO: Navigate to projects section
                },
                      isOutlined: false,
                    ),
                  ),
                  GradientButton(
                    text: AppStrings.getInTouchButton,
                    onPressed: () {
                      // TODO: Navigate to contact section
                    },
                    isOutlined: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: AppDimensions.spacingXXXL),
        Expanded(
          flex: 2,
          child: Center(
            child: MouseRegion(
              onEnter: (_) => _animationController.forward(),
              onExit: (_) => _animationController.reverse(),
              child: AnimatedBuilder(
                animation: Listenable.merge([_animationController, _glowController]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: AppDimensions.profilePictureSizeDesktop + 20,
                      height: AppDimensions.profilePictureSizeDesktop + 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cardBackgroundAlt,
                        border: Border.all(
                          color: AppColors.cardBorder,
                          width: 3.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4 * _glowAnimation.value),
                            blurRadius: 40 * _glowAnimation.value,
                            spreadRadius: 15 * _glowAnimation.value,
                          ),
                          BoxShadow(
                            color: AppColors.secondary.withValues(alpha: 0.4 * _glowAnimation.value),
                            blurRadius: 40 * _glowAnimation.value,
                            spreadRadius: 15 * _glowAnimation.value,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppDimensions.spacingHuge),
            // Profile picture for mobile
            MouseRegion(
              onEnter: (_) => _animationController.forward(),
              onExit: (_) => _animationController.reverse(),
              child: AnimatedBuilder(
                animation: Listenable.merge([_animationController, _glowController]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: AppDimensions.profilePictureSizeMobile + 20,
                      height: AppDimensions.profilePictureSizeMobile + 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4 * _glowAnimation.value),
                            blurRadius: 30 * _glowAnimation.value,
                            spreadRadius: 10 * _glowAnimation.value,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.surface,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile.png',
                              width: AppDimensions.profilePictureSizeMobile,
                              height: AppDimensions.profilePictureSizeMobile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppDimensions.spacingXL),
            ShaderMask(
              shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                child: Text(
            AppStrings.heroGreeting,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
            ),
            SizedBox(height: AppDimensions.spacingXL),
            Text(
              AppStrings.heroTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacingXXL),
            Text(
              AppStrings.heroDescription,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textTertiary,
            height: 1.6,
          ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacingXXXL),
            Wrap(
              spacing: AppDimensions.spacingM,
              runSpacing: AppDimensions.spacingM,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
                  ),
                  child: GradientButton(
                    text: AppStrings.viewWorkButton,
                    onPressed: () {
                      // TODO: Navigate to projects section
                    },
                    isOutlined: false,
                  ),
                ),
                GradientButton(
                  text: AppStrings.getInTouchButton,
                  onPressed: () {
                    // TODO: Navigate to contact section
                  },
                  isOutlined: true,
                  ),
              ],
            ),
            SizedBox(height: AppDimensions.spacingMassive),
          ],
        ),
        Positioned(
          right: AppDimensions.spacingL,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: 3,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw floating shapes
    final shapes = [
      _FloatingShape(
        Offset(size.width * 0.1 + math.sin(animationValue * 2 * math.pi) * 50, 
               size.height * 0.2 + math.cos(animationValue * 2 * math.pi) * 30),
        20 + math.sin(animationValue * 4 * math.pi) * 5,
      ),
      _FloatingShape(
        Offset(size.width * 0.8 + math.cos(animationValue * 2 * math.pi) * 40, 
               size.height * 0.3 + math.sin(animationValue * 2 * math.pi) * 50),
        15 + math.cos(animationValue * 4 * math.pi) * 5,
      ),
      _FloatingShape(
        Offset(size.width * 0.2 + math.sin(animationValue * 3 * math.pi) * 60, 
               size.height * 0.7 + math.cos(animationValue * 3 * math.pi) * 40),
        25 + math.sin(animationValue * 5 * math.pi) * 8,
      ),
      _FloatingShape(
        Offset(size.width * 0.7 + math.cos(animationValue * 2.5 * math.pi) * 45, 
               size.height * 0.8 + math.sin(animationValue * 2.5 * math.pi) * 35),
        18 + math.cos(animationValue * 6 * math.pi) * 6,
      ),
      // Additional shapes for more animation balls
      _FloatingShape(
        Offset(size.width * 0.05 + math.sin(animationValue * 1.8 * math.pi) * 35, 
               size.height * 0.5 + math.cos(animationValue * 1.8 * math.pi) * 45),
        12 + math.sin(animationValue * 3.2 * math.pi) * 4,
      ),
      _FloatingShape(
        Offset(size.width * 0.95 + math.cos(animationValue * 2.2 * math.pi) * 30, 
               size.height * 0.1 + math.sin(animationValue * 2.2 * math.pi) * 25),
        16 + math.cos(animationValue * 4.8 * math.pi) * 5,
      ),
      _FloatingShape(
        Offset(size.width * 0.4 + math.sin(animationValue * 1.6 * math.pi) * 55, 
               size.height * 0.9 + math.cos(animationValue * 1.6 * math.pi) * 35),
        22 + math.sin(animationValue * 5.5 * math.pi) * 7,
      ),
      _FloatingShape(
        Offset(size.width * 0.6 + math.cos(animationValue * 2.8 * math.pi) * 40, 
               size.height * 0.05 + math.sin(animationValue * 2.8 * math.pi) * 30),
        19 + math.cos(animationValue * 6.2 * math.pi) * 6,
      ),
    ];

    for (final shape in shapes) {
      canvas.drawCircle(shape.position, shape.radius, paint);
    }

    // Add some additional smaller shapes with different colors
    final paint2 = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final additionalShapes = [
      _FloatingShape(
        Offset(size.width * 0.3 + math.cos(animationValue * 1.5 * math.pi) * 35, 
               size.height * 0.1 + math.sin(animationValue * 1.5 * math.pi) * 25),
        12 + math.sin(animationValue * 3.5 * math.pi) * 3,
      ),
      _FloatingShape(
        Offset(size.width * 0.9 + math.sin(animationValue * 1.8 * math.pi) * 30, 
               size.height * 0.6 + math.cos(animationValue * 1.8 * math.pi) * 45),
        16 + math.cos(animationValue * 4.5 * math.pi) * 4,
      ),
      // More additional shapes
      _FloatingShape(
        Offset(size.width * 0.15 + math.sin(animationValue * 2.1 * math.pi) * 25, 
               size.height * 0.85 + math.cos(animationValue * 2.1 * math.pi) * 40),
        14 + math.sin(animationValue * 4.1 * math.pi) * 4,
      ),
      _FloatingShape(
        Offset(size.width * 0.85 + math.cos(animationValue * 1.9 * math.pi) * 35, 
               size.height * 0.75 + math.sin(animationValue * 1.9 * math.pi) * 30),
        17 + math.cos(animationValue * 5.1 * math.pi) * 5,
      ),
    ];

    for (final shape in additionalShapes) {
      canvas.drawCircle(shape.position, shape.radius, paint2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _FloatingShape {
  final Offset position;
  final double radius;

  _FloatingShape(this.position, this.radius);
}

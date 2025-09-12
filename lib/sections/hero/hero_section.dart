import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/constants/mock_data.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWorkPressed;
  const HeroSection({super.key, required this.onViewWorkPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
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
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOutSine,
    ));

    _glowController.repeat(reverse: true);
    _backgroundAnimation.repeat();
  }

  Future<void> _downloadCV() async {
    final Uri url = Uri.base.resolve('assets/cv/Abdelmohaymn_Albashier_CV.pdf');
    if (!await launchUrl(
      url,
      webOnlyWindowName: '_blank',
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
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
      height: size.height,
      padding: EdgeInsets.only(
        left: isMobile ? AppDimensions.sectionPaddingHorizontalMobile : AppDimensions.sectionPaddingHorizontal,
        right: isMobile ? AppDimensions.sectionPaddingHorizontalMobile : AppDimensions.sectionPaddingHorizontal,
        top: appBarHeight + statusBarHeight + AppDimensions.sectionPaddingVertical,
        bottom: AppDimensions.sectionPaddingVertical,
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
    final width = MediaQuery.of(context).size.width;
    final bool isTablet = width < AppDimensions.tabletBreakpoint;
    final double buttonWidth = isTablet ? 180.0 : AppDimensions.buttonWidth;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    MockData.heroTitle,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXL),
                Text(
                  MockData.heroSubtitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacingXXL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: StatNumber(number: MockData.projectsCount, label: AppStrings.projectsDelivered)),
                    Expanded(child: StatNumber(number: MockData.publishedAppsCount, label: AppStrings.publishedApps)),
                    Expanded(child: StatNumber(number: MockData.experienceYearsCount, label: AppStrings.yearsExperience)),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacingXXXL),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppDimensions.spacingL,
                  runSpacing: AppDimensions.spacingM,
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      height: AppDimensions.buttonHeight,
                      child: GradientButton(
                        text: AppStrings.viewWorkButton,
                        onPressed: widget.onViewWorkPressed,
                      ),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      height: AppDimensions.buttonHeight,
                      child: GradientBorderButton(
                        text: AppStrings.downloadCvButton,
                        onPressed: _downloadCV,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: AppDimensions.spacingXXXL),
        Expanded(
          flex: 2,
          child: Center(
            child: const GlowingProfilePicture(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
          child: Text(
            MockData.heroTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingL),
        Text(
          MockData.heroSubtitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacingXL),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: StatNumber(number: MockData.projectsCount, label: AppStrings.projectsDelivered)),
            Expanded(child: StatNumber(number: MockData.publishedAppsCount, label: AppStrings.publishedApps)),
            Expanded(child: StatNumber(number: MockData.experienceYearsCount, label: AppStrings.yearsExperience)),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingXXL),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingXL),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: GradientButton(
                  text: AppStrings.viewWorkButton,
                  onPressed: widget.onViewWorkPressed,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingM),
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: GradientBorderButton(
                  text: AppStrings.downloadCvButton,
                  onPressed: _downloadCV,
                ),
              ),
            ],
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

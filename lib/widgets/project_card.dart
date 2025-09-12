import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/models/project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import 'image_with_loading_indicator.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isIconHovered = false;
  final _random = math.Random();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  static const List<Color> accentColors = [
    Color(0xFF61DAFB),    // React blue
    Color(0xFF4CAF50),    // Material green
    Color(0xFF7C4DFF),    // Deep purple
    Color(0xFFE91E63),    // Material pink
    Color(0xFFFFC837),    // Warm yellow
    Color(0xFF009688),    // Teal
    Color(0xFF6C63FF),    // Primary purple
    Color(0xFFFF6584),    // Soft pink
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getRandomAccentColor() {
    return accentColors[_random.nextInt(accentColors.length)];
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showProjectImages(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    showDialog(
      context: context,
      barrierColor: AppColors.withAlpha(AppColors.scaffoldBackground, 0.95),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: RawKeyboardListener(
          focusNode: FocusNode()..requestFocus(),
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent) {
              final double scrollAmount = 100.0;

              if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                scrollController.animateTo(
                  scrollController.offset + scrollAmount,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                scrollController.animateTo(
                  scrollController.offset - scrollAmount,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              } else if (event.logicalKey == LogicalKeyboardKey.escape) {
                Navigator.pop(context);
              }
            }
          },
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.spacingXL,
                          horizontal: AppDimensions.spacingXL,
                        ),
                        itemCount: widget.project.images.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(bottom: AppDimensions.spacingL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.glowOverlay,
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
                            child: ImageWithLoadingIndicator(
                              imagePath: widget.project.images[index],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: AppDimensions.spacingM,
                        right: AppDimensions.spacingM,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to determine if we should use mobile layout
  bool _isMobileLayout(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  // Helper method to get responsive logo size
  double _getLogoSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 50;
    if (screenWidth < 900) return 55;
    return 60;
  }

  // Helper method to get responsive padding
  EdgeInsets _getCardPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return EdgeInsets.all(AppDimensions.spacingM);
    }
    return EdgeInsets.all(AppDimensions.spacingL);
  }

  // Helper method to get responsive margin
  EdgeInsets _getCardMargin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return EdgeInsets.all(AppDimensions.spacingS);
    }
    return EdgeInsets.all(AppDimensions.spacingM);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobileLayout(context);
    final logoSize = _getLogoSize(context);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: () => {
          if(widget.project.images.isNotEmpty)_showProjectImages(context)
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: double.infinity,
                margin: _getCardMargin(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColors.cardGradient,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
                  border: Border.all(
                    color: AppColors.withAlpha(AppColors.cardBorder, _glowAnimation.value * 0.5 + 0.1),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.withAlpha(AppColors.glowOverlay, _glowAnimation.value * 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: _getCardPadding(context),
                      child: isMobile
                          ? _buildMobileLayout(logoSize)
                          : _buildDesktopLayout(logoSize),
                    ),
                    if (_isHovered)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.withAlpha(AppColors.scaffoldBackground, 0.7),
                            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(widget.project.images.isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: isMobile ? 28 : 32,
                                    ),
                                    onPressed: () => _showProjectImages(context),
                                  ),
                                ),
                              if(widget.project.images.isNotEmpty)
                                SizedBox(height: AppDimensions.spacingL),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.project.googlePlayLink != null)
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/icons/google.svg',
                                        width: isMobile ? 35 : 40,
                                        height: isMobile ? 35 : 40,
                                      ),
                                      onPressed: () => _launchURL(widget.project.googlePlayLink!),
                                    ),
                                  if (widget.project.appStoreLink != null)
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/icons/apple.svg',
                                        width: isMobile ? 35 : 40,
                                        height: isMobile ? 35 : 40,
                                      ),
                                      onPressed: () => _launchURL(widget.project.appStoreLink!),
                                    ),
                                ],
                              ),
                              if (widget.project.githubLink != null) ...[
                                SizedBox(height: AppDimensions.spacingM),
                                MouseRegion(
                                  onEnter: (_) => setState(() => _isIconHovered = true),
                                  onExit: (_) => setState(() => _isIconHovered = false),
                                  child: GestureDetector(
                                    onTap: () => _launchURL(widget.project.githubLink!),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                                      child: Text(
                                        'View Details',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: Colors.white,
                                          fontSize: isMobile ? 14 : null,
                                          decoration: _isIconHovered ? TextDecoration.underline : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(double logoSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column with logo
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          child: Image.asset(
            widget.project.logo,
            width: logoSize,
            height: logoSize,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: AppDimensions.spacingL),
        // Right column with content
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double logoSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row with logo and title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              child: Image.asset(
                widget.project.logo,
                width: logoSize,
                height: logoSize,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: AppDimensions.spacingM),
            Expanded(
              child: ShaderMask(
                shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  widget.project.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.spacingM),
        // Content below
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title for desktop layout only
        if (!_isMobileLayout(context)) ...[
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: Text(
              widget.project.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacingS),
        ],
        Text(
          widget.project.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            fontSize: _isMobileLayout(context) ? 14 : null,
          ),
        ),
        SizedBox(height: AppDimensions.spacingM),
        if (widget.project.features.isNotEmpty) ...[
          Text(
            'Features',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textPrimary,
              fontSize: _isMobileLayout(context) ? 14 : null,
            ),
          ),
          SizedBox(height: AppDimensions.spacingS),
          Wrap(
            spacing: AppDimensions.spacingS,
            runSpacing: AppDimensions.spacingS,
            children: widget.project.features.map((feature) {
              final color = getRandomAccentColor();
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _isMobileLayout(context) ? AppDimensions.spacingS : AppDimensions.spacingM,
                  vertical: AppDimensions.spacingXS,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.withAlpha(color, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  feature,
                  style: TextStyle(
                    color: color,
                    fontSize: _isMobileLayout(context) ? 12 : 14,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
        if (widget.project.tools?.isNotEmpty ?? false) ...[
          SizedBox(height: AppDimensions.spacingM),
          Text(
            'Tools',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textPrimary,
              fontSize: _isMobileLayout(context) ? 14 : null,
            ),
          ),
          SizedBox(height: AppDimensions.spacingS),
          Wrap(
            spacing: AppDimensions.spacingS,
            runSpacing: AppDimensions.spacingS,
            children: (widget.project.tools ?? []).map((tool) {
              final color = getRandomAccentColor();
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _isMobileLayout(context) ? AppDimensions.spacingS : AppDimensions.spacingM,
                  vertical: AppDimensions.spacingXS,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.withAlpha(color, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tool,
                  style: TextStyle(
                    color: color,
                    fontSize: _isMobileLayout(context) ? 12 : 14,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
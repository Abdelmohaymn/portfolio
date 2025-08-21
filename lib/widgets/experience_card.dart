import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/models/experience.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceCard extends StatefulWidget {
  final Experience experience;

  const ExperienceCard({
    super.key,
    required this.experience,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;
  bool _isPlayStoreHovered = false;
  bool _isAppStoreHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: _glowAnimation.value)
                    : AppColors.cardBorder,
                width: 1.5,
              ),
              gradient: _isHovered
                  ? LinearGradient(
                      colors: [
                        AppColors.cardBackground,
                        AppColors.primary.withValues(alpha: 0.05 * _glowAnimation.value),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2 * _glowAnimation.value),
                        blurRadius: 12 * _glowAnimation.value,
                        spreadRadius: 2 * _glowAnimation.value,
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
                        child: Image.asset(
                          widget.experience.companyLogo,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: AppDimensions.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.experience.jobTitle,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ShaderMask(
                              shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                              child: Text(
                                widget.experience.companyName,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.spacingL),
                  ...widget.experience.achievements.map(
                    (achievement) => Padding(
                      padding: EdgeInsets.only(bottom: AppDimensions.spacingM),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: AppDimensions.spacingM),
                          Expanded(
                            child: Text(
                              achievement,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textTertiary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.spacingM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacingM,
                          vertical: AppDimensions.spacingXS,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusS),
                        ),
                        child: Text(
                          '${widget.experience.startDate} - ${widget.experience.endDate}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (widget.experience.googlePlayLink != null ||
                          widget.experience.appStoreLink != null)
                        Row(
                          children: [
                            if (widget.experience.googlePlayLink != null)
                              MouseRegion(
                                onEnter: (_) => setState(() => _isPlayStoreHovered = true),
                                onExit: (_) => setState(() => _isPlayStoreHovered = false),
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => _launchURL(widget.experience.googlePlayLink!),
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 200),
                                    scale: _isPlayStoreHovered ? 1.1 : 1.0,
                                    child: ShaderMask(
                                      shaderCallback: (bounds) => (_isPlayStoreHovered ? AppColors.primaryGradient : LinearGradient(
                                        colors: [Colors.white, Colors.white],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )).createShader(bounds),
                                      child: SvgPicture.asset(
                                        'assets/icons/google_play.svg',
                                        width: 32,
                                        height: 32,
                                        colorFilter: ColorFilter.mode(
                                          _isPlayStoreHovered
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.experience.appStoreLink != null) ...[
                              SizedBox(width: AppDimensions.spacingM),
                              MouseRegion(
                                onEnter: (_) => setState(() => _isAppStoreHovered = true),
                                onExit: (_) => setState(() => _isAppStoreHovered = false),
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => _launchURL(widget.experience.appStoreLink!),
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 200),
                                    scale: _isAppStoreHovered ? 1.1 : 1.0,
                                    child: ShaderMask(
                                      shaderCallback: (bounds) => (_isPlayStoreHovered ? AppColors.primaryGradient : LinearGradient(
                                        colors: [Colors.white, Colors.white],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )).createShader(bounds),
                                      child: SvgPicture.asset(
                                        'assets/icons/google_play.svg', // Replace with App Store icon
                                        width: 32,
                                        height: 32,
                                        colorFilter: ColorFilter.mode(
                                          _isAppStoreHovered
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

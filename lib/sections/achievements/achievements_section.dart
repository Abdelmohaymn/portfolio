import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:portfolio/widgets/shader_text_parser.dart';
import 'package:url_launcher/url_launcher.dart';

class AchievementsSection extends StatefulWidget {
  const AchievementsSection({super.key});

  @override
  State<AchievementsSection> createState() => _AchievementsSectionState();
}

class _AchievementsSectionState extends State<AchievementsSection> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  double _dragStartPosition = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_isDragging) return; // Don't auto-play while dragging

      if (_currentPage < MockData.achievements.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    });
  }

  void _pauseAutoPlay() {
    _timer?.cancel();
  }

  void _resumeAutoPlay() {
    if (!_isDragging) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _onPanStart(DragStartDetails details) {
    _isDragging = true;
    _dragStartPosition = details.globalPosition.dx;
    _pauseAutoPlay();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    // Optional: You can add visual feedback here if needed
    // For example, slightly transform the current page based on drag distance
  }

  void _onPanEnd(DragEndDetails details) {
    _isDragging = false;

    const double threshold = 50.0; // Minimum drag distance to trigger page change
    final double dragDistance = details.globalPosition.dx - _dragStartPosition;

    if (dragDistance.abs() > threshold) {
      if (dragDistance > 0) {
        // Dragging right - go to previous page
        if (_currentPage > 0) {
          _currentPage--;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      } else {
        // Dragging left - go to next page
        if (_currentPage < MockData.achievements.length - 1) {
          _currentPage++;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }

    // Resume auto-play after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _resumeAutoPlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppDimensions.mobileBreakpoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppDimensions.sectionPaddingHorizontalMobile : AppDimensions.sectionPaddingHorizontal,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.scaffoldBackground,
            AppColors.withAlpha(AppColors.surface, 0.3),
          ],
        ),
      ),
      child: Column(
        children: [
          Align(
              alignment: AlignmentDirectional.topStart,
              child: const SectionHeader(title: AppStrings.achievementsTitle)),
          SizedBox(height: AppDimensions.spacingXXL),
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            onTapDown: (_) => _pauseAutoPlay(),
            onTapUp: (_) => Future.delayed(const Duration(milliseconds: 500), _resumeAutoPlay),
            onTapCancel: () => Future.delayed(const Duration(milliseconds: 500), _resumeAutoPlay),
            child: MouseRegion(
              onEnter: (_) => _pauseAutoPlay(),
              onExit: (_) => _resumeAutoPlay(),
              child: SizedBox(
                height: 650, // Increased height for better image display
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: MockData.achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = MockData.achievements[index];
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _currentPage == index ? 1.0 : 0.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                            child: Text(
                              achievement.title,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacingL),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: achievement.points.map((point) => Padding(
                              padding: EdgeInsets.only(bottom: AppDimensions.spacingM),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimensions.spacingM),
                                  Expanded(
                                    child: ShaderTextParser(
                                      text: point,
                                      baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      gradientColors: [AppColors.gradientStart, AppColors.gradientEnd],
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ),
                          SizedBox(height: AppDimensions.spacingXL),
                          Expanded(
                            child: Container(
                              width: 1000,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.withAlpha(AppColors.primary, 0.2),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
                                child: Image.asset(
                                  achievement.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacingL),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              MockData.achievements.length,
                  (index) => Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(horizontal: AppDimensions.spacingXS),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _currentPage == index
                      ? AppColors.primaryGradient
                      : null,
                  color: _currentPage == index ? null : AppColors.cardBorder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
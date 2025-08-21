import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/section_header.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < MockData.achievements.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
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
          SizedBox(
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
                                child: Text(
                                  point,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: AppDimensions.spacingXL),
                      MouseRegion(
                        cursor: achievement.link != null
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        child: GestureDetector(
                          onTap: achievement.link != null
                              ? () => _launchURL(achievement.link!)
                              : null,
                          child: Container(
                            width: 1000,
                            height: 500,
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
                      ),
                    ],
                  ),
                );
              },
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

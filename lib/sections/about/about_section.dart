import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/index.dart';

import '../../widgets/shader_text_parser.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppDimensions.mobileBreakpoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? AppDimensions.sectionPaddingHorizontalMobile
            : AppDimensions.sectionPaddingHorizontal,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.scaffoldBackground,
            AppColors.withAlpha(AppColors.surface, 0.1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: AppStrings.aboutTitle),
          SizedBox(height: AppDimensions.spacingXXL),
          if (isMobile)
            _buildMobileLayout(context)
          else
            _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.aboutSubtitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
              ),
              SizedBox(height: AppDimensions.spacingXL),
              ShaderTextParser(
                text: MockData.aboutDescription, // Your text from DB with ## markers
                baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.6,
                ),
                gradientColors:[AppColors.gradientStart, AppColors.gradientEnd],
              ),
              SizedBox(height: AppDimensions.spacingXL),
              ShaderTextParser(
                text: MockData.aboutHighlights, // Your text from DB with ## markers
                baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.6,
                ),
                gradientColors:[AppColors.gradientStart, AppColors.gradientEnd],
              ),
              SizedBox(height: AppDimensions.spacingXL),
              ShaderTextParser(
                text: MockData.aboutHighlights2, // Your text from DB with ## markers
                baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.6,
                ),
                gradientColors:[AppColors.gradientStart, AppColors.gradientEnd],
              ),
            ],
          ),
        ),
        SizedBox(width: AppDimensions.spacingXXL),
        Expanded(
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
              color: AppColors.cardBackgroundAlt,
              border: Border.all(
                color: AppColors.cardBorder,
                width: 1.5,
              ),
              boxShadow: [
                // Outer glow
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  // Use your primary color
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: Offset(0, 0),
                ),
                // Inner glow effect
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 40,
                  spreadRadius: 10,
                  offset: Offset(0, 0),
                ),
                // Soft shadow for depth
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(AppDimensions.spacingXS),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusL - AppDimensions.spacingXS),
              child: Image.asset(
                'assets/images/about.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
            gradient: AppColors.primaryGradient,
          ),
          padding: EdgeInsets.all(AppDimensions.spacingXS),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusL - AppDimensions.spacingXS),
            child: Image.asset(
              'assets/images/about.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: AppDimensions.spacingXXL),
        Text(
          AppStrings.aboutSubtitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        SizedBox(height: AppDimensions.spacingXL),
        ShaderTextParser(
          text: MockData.aboutDescription, // Your text from DB with ## markers
          baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textTertiary,
                height: 1.6,
              ),
          gradientColors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        SizedBox(height: AppDimensions.spacingXL),
        ShaderTextParser(
          text: MockData.aboutHighlights,
          baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textTertiary,
                height: 1.6,
              ),
          gradientColors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        SizedBox(height: AppDimensions.spacingXL),
        ShaderTextParser(
          text: MockData.aboutHighlights2,
          baseStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textTertiary,
            height: 1.6,
          ),
          gradientColors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
      ],
    );
  }
}

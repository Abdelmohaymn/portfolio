import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/index.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
              Text(
                AppStrings.aboutDescription,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.6,
                ),
              ),
              SizedBox(height: AppDimensions.spacingXL),
              Text(
                AppStrings.aboutHighlights,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.6,
                ),
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
              //gradient: AppColors.primaryGradient,
              color: AppColors.cardBackgroundAlt,
              border: Border.all(
                color: AppColors.cardBorder,
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.all(AppDimensions.spacingXS),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL - AppDimensions.spacingXS),
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
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL - AppDimensions.spacingXS),
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
        Text(
          AppStrings.aboutDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textTertiary,
            height: 1.6,
          ),
        ),
        SizedBox(height: AppDimensions.spacingXL),
        Text(
          AppStrings.aboutHighlights,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textTertiary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

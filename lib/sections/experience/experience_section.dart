import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/index.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
          const SectionHeader(title: AppStrings.experienceTitle),
          SizedBox(height: AppDimensions.spacingXXL),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: MockData.experiences.length,
            separatorBuilder: (context, index) => SizedBox(height: AppDimensions.spacingXL),
            itemBuilder: (context, index) => ExperienceCard(
              experience: MockData.experiences[index],
            ),
          ),
        ],
      ),
    );
  }
}

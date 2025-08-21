import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: AppStrings.projectsTitle),
          SizedBox(height: AppDimensions.spacingXXL),
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final cardWidth = isMobile
                  ? maxWidth
                  : (maxWidth - AppDimensions.spacingXL) / 2;

              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 1400,
                  ),
                  child: Wrap(
                    spacing: AppDimensions.spacingXL,
                    runSpacing: AppDimensions.spacingXXL,
                    alignment: WrapAlignment.start,
                    children: MockData.projects.map((project) => SizedBox(
                      width: cardWidth,
                      child: ProjectCard(project: project),
                    )).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

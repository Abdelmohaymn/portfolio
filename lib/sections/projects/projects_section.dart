import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/section_header.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppDimensions.mobileBreakpoint;
    final isTablet = size.width >= AppDimensions.mobileBreakpoint && size.width < AppDimensions.tabletBreakpoint;

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
              final int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
              final double maxContentWidth = 1400;

              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: MasonryGridView.count(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: AppDimensions.spacingL,
                    crossAxisSpacing: AppDimensions.spacingL,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: MockData.projects.length,
                    itemBuilder: (context, index) {
                      final project = MockData.projects[index];
                      return ProjectCard(project: project);
                    },
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

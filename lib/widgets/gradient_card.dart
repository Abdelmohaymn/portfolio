import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/dimensions.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;

  const GradientCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppDimensions.borderRadiusXL,
        ),
        border: Border.all(
          color: borderColor ?? AppColors.cardBorder,
        ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}

class GradientCardWithIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final List<String>? tags;
  final List<Widget>? actions;
  final double? iconSize;

  const GradientCardWithIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    this.tags,
    this.actions,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Header
          Container(
            width: iconSize ?? AppDimensions.iconSizeXXL,
            height: iconSize ?? AppDimensions.iconSizeXXL,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: AppDimensions.iconSizeL,
            ),
          ),
          SizedBox(height: AppDimensions.spacingL),
          
          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppDimensions.spacingS),
          
          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          
          // Tags
          if (tags != null) ...[
            SizedBox(height: AppDimensions.spacingL),
            Wrap(
              spacing: AppDimensions.spacingS,
              runSpacing: AppDimensions.spacingS,
              children: tags!.map((tag) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingS,
                  vertical: AppDimensions.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXXL),
                  border: Border.all(
                    color: iconColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  tag,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
          
          // Actions
          if (actions != null) ...[
            SizedBox(height: AppDimensions.spacingL),
            Row(
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }
} 
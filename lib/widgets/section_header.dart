import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/dimensions.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;

  const SectionHeader({
    super.key,
    required this.title,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.spacingM),
        Container(
          width: width ?? AppDimensions.accentLineWidth,
          height: height ?? AppDimensions.accentLineHeight,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusS),
          ),
        ),
      ],
    );
  }
} 
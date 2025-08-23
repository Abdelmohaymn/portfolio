import 'package:flutter/material.dart';
import 'package:portfolio/constants/index.dart';

class GradientBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double? width;

  const GradientBorderButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 48,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        gradient: AppColors.primaryGradient,
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            minimumSize: Size(width ?? double.infinity, height),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

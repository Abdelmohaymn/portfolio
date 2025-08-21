import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/dimensions.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  final double? height;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return Container(
        width: width,
        height: height ?? AppDimensions.buttonHeight,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
            ),
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide.none,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.buttonPaddingHorizontal,
                  vertical: AppDimensions.buttonPaddingVertical,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
                ),
              ),
              child: _buildButtonContent(),
            ),
          ),
        ),
      );
    }

    return Container(
      width: width,
      height: height ?? AppDimensions.buttonHeight,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: AppDimensions.spacingS),
          Text(text),
        ],
      );
    }
    return Text(text);
  }
}

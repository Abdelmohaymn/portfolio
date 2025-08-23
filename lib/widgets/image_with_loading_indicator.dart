import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ImageWithLoadingIndicator extends StatefulWidget {
  final String imagePath;

  const ImageWithLoadingIndicator({
    super.key,
    required this.imagePath,
  });

  @override
  _ImageWithLoadingIndicatorState createState() => _ImageWithLoadingIndicatorState();
}

class _ImageWithLoadingIndicatorState extends State<ImageWithLoadingIndicator> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Placeholder container while loading
        if (_isLoading)
          Container(
            height: 300, // Set a reasonable default height
            color: AppColors.scaffoldBackground.withOpacity(0.3),
          ),

        // Actual image
        Image.asset(
          widget.imagePath,
          fit: BoxFit.contain,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              });
              return child;
            }

            if (frame == null) {
              return Container(
                height: 300,
                color: AppColors.scaffoldBackground.withOpacity(0.3),
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              });
              return child;
            }
          },
          errorBuilder: (context, error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _hasError = true;
                });
              }
            });

            return Container(
              height: 300,
              color: AppColors.scaffoldBackground.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),

        // Loading indicator
        if (_isLoading && !_hasError)
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryGradient.colors.first,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Loading image...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
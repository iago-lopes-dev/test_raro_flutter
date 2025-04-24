import 'package:project_by_iago/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerBox extends StatelessWidget {
  final double height;
  final double width;

  const CustomShimmerBox({this.height = 20, this.width = 100, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Shimmer.fromColors(
          baseColor: AppColors.silver,
          highlightColor: AppColors.grayFont,
          child: Container(
            height: height,
            width: width > constraints.maxWidth ? constraints.maxWidth : width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

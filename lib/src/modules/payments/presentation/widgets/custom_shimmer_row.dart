import 'package:project_by_iago/src/core/base/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerRow extends StatelessWidget {
  final int itemCount;
  final double height;
  final List<double> widths;

  const CustomShimmerRow({
    this.itemCount = 3,
    this.height = 20,
    this.widths = const [80, 100],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(itemCount, (_) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widths
                .map((w) => _shimmerBox(w))
                .toList(),
          ),
        );
      }),
    );
  }

  Widget _shimmerBox(double width) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray,
      highlightColor: AppColors.grayFont,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
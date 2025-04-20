import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRow extends StatelessWidget {
  final int itemCount;
  final double height;
  final List<double> widths;

  const ShimmerRow({
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
  ///TODO(Ogai): Conferir esse shimmer nos cards

  Widget _shimmerBox(double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
import 'package:base_project/src/core/base/constants/app_colors.dart';
import 'package:base_project/src/core/base/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entity/payments_schedule_entity.dart';

class CustomScheduleCard extends StatelessWidget {
  final PaymentsScheduleEntity? schedule;
  final bool isLoading;
  final bool isNextPayment;

  const CustomScheduleCard({
    required this.isLoading,
    this.schedule,
    this.isNextPayment = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading ? _buildSkeleton() : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDate(schedule!.paymentDate),
              style: AppTextStyles.get16w400(),
            ),
            SizedBox.fromSize(size: const Size(40, 0)),
            Text(
              "\$ ${schedule!.principal.toString()}",
              style: AppTextStyles.get16w400(),
            ),
          ],
        ),
        isNextPayment
            ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "Next",
                  style: AppTextStyles.get14w400(AppColors.blueBackground),
                ),
              ),
            )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _buildSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(1, (_) => _buildShimmerRow()),
    );
  }

  Widget _buildShimmerRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_shimmerBox(width: 100), _shimmerBox(width: 100)],
      ),
    );
  }

  Widget _shimmerBox({required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 20,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}

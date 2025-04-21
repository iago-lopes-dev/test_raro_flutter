import 'package:base_project/src/core/base/constants/app_colors.dart';
import 'package:base_project/src/core/base/constants/app_text_styles.dart';
import 'package:base_project/src/core/utils/json_helper.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/converter_helper.dart';
import '../../../domain/entity/payments_summary_entity.dart';

class CustomSummaryCards extends StatelessWidget {
  final PaymentsState state;

  const CustomSummaryCards({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    if (state is PaymentsInitialState || state is PaymentsErrorState) {
      return const SizedBox.shrink();
    }

    final summaries =
        state is PaymentsSuccessState
            ? (state as PaymentsSuccessState).paymentsInfo.summary
            : JsonHelper.getMockSummariesFromJson();

    return SizedBox(
      height: 130,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        scrollDirection: Axis.horizontal,
        itemCount: summaries.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          return state is PaymentsLoadingState
              ? _buildSkeletonCard(summaries[index])
              : _buildContentCard(summaries[index]);
        },
      ),
    );
  }

  Widget _buildContentCard(PaymentsSummaryEntity summary) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.label,
              style: AppTextStyles.get12w400(AppColors.grayFont),
            ),
            const SizedBox(height: 8),
            Text(
              ConverterHelper.currencyFormatter(summary.value),
              style: AppTextStyles.get16w600(AppColors.blackFont),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonCard(PaymentsSummaryEntity summary) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(summary.label, style: AppTextStyles.get12w400()),
            _shimmerBox(height: 20, width: 100),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray,
      highlightColor: AppColors.grayFont,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

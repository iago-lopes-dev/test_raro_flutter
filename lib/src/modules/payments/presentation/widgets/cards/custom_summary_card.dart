import 'package:flutter/material.dart';
import 'package:project_by_iago/src/core/base/constants/app_colors.dart';
import 'package:project_by_iago/src/core/base/constants/app_text_styles.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_shimmer_box.dart';

import '../../../../../core/utils/helpers/converter_helper.dart';
import '../../../domain/entity/payments_summary_entity.dart';

class CustomSummaryCard extends StatelessWidget {
  final PaymentsState state;

  const CustomSummaryCard({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final List<PaymentsSummaryEntity> summaries = state.paymentsInfo.summary;

    // if (state is PaymentsLoadingState || state is PaymentsSuccessState) {
    if (state is PaymentsInitialState || state is PaymentsErrorState) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 120,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            itemCount: summaries.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              return SizedBox(
                width: constraints.maxWidth * 0.45,
                child:
                    state is PaymentsLoadingState
                        ? _buildSkeletonCard(summaries[index])
                        : _buildContentCard(summaries[index]),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContentCard(PaymentsSummaryEntity summary) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(summary.label, style: AppTextStyles.get12w400()),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Text(
                        "\$",
                        style: AppTextStyles.get10w400(AppColors.blackFont),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ConverterHelper.thousandSeparatorFormatter(
                      summary.value,
                    ),
                    style: AppTextStyles.get16w400(AppColors.blackFont),
                  ),
                ],
              ),
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
            CustomShimmerBox(),
          ],
        ),
      ),
    );
  }
}

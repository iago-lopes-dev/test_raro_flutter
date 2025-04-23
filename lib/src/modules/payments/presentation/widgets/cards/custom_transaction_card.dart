import 'package:flutter/material.dart';
import 'package:project_by_iago/src/core/base/constants/app_colors.dart';
import 'package:project_by_iago/src/core/base/constants/app_text_styles.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_shimmer_box.dart';

import '../../../data/model/model.dart';

class CustomTransactionCard extends StatelessWidget {
  final PaymentsTransactionsModel transaction;
  final List<PaymentsTransactionHeadersModel> visibleFields;
  final bool isLoading;

  const CustomTransactionCard({
    required this.transaction,
    required this.visibleFields,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading ? _buildSkeletonCard() : _buildContentCard(),
      ),
    );
  }

  Widget _buildContentCard() {
    final Map<String, dynamic> cardItems = transaction.toMap();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxCrossAxisExtent = constraints.maxWidth / 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
            mainAxisExtent: 60,
          ),
          itemCount: visibleFields.length,
          itemBuilder: (_, index) {
            final String value = cardItems[visibleFields[index].key] ?? '--';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visibleFields[index].label,
                  style: AppTextStyles.get12w400(),
                ),
                Text(
                  value,
                  style: AppTextStyles.get16w400(AppColors.blackFont),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        2,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: List.generate(
                  visibleFields.length,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visibleFields[index].label,
                        style: AppTextStyles.get12w400(),
                      ),
                      CustomShimmerBox(width: 140),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

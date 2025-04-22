import 'package:project_by_iago/src/core/base/constants/app_colors.dart';
import 'package:project_by_iago/src/core/base/constants/app_text_styles.dart';
import 'package:project_by_iago/src/core/utils/adapters/transaction_card_adapter.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entity/payments_transactions_entity.dart';
import '../../../domain/entity/payments_transactions_filter_entity.dart';

class CustomTransactionCard extends StatelessWidget {
  final PaymentsTransactionsEntity transaction;
  final List<PaymentsTransactionFilterEntity> visibleFields;
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
    final cardItems = TransactionCardAdapter.fromTransaction(
      transaction: transaction.toMap(),
      visibleFields:
          visibleFields.map((f) => {"key": f.key, "label": f.label}).toList(),
    );

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
          itemCount: cardItems.length,
          itemBuilder: (_, index) {
            final item = cardItems[index];
            return _buildRow(item["label"] ?? "", item["value"] ?? "");
          },
        );
      }
    );
  }

  Widget _buildRow(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.get12w400()),
        Text(value, style: AppTextStyles.get16w400()),
      ],
    );
  }

  Widget _buildSkeletonCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(2, (_) => _buildShimmerRow()),
    );
  }

  Widget _buildShimmerRow() {
    return Padding(
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
                  _shimmerBox(width: 140),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double width}) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray,
      highlightColor: AppColors.grayFont,
      child: Container(
        height: 24,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

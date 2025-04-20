import 'package:base_project/src/core/base/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/entity/payments_transactions_entity.dart';

class CustomTransactionCard extends StatelessWidget {
  final PaymentsTransactionsEntity? transactions;
  final List<String> visibleFields;
  final bool isLoading;

  const CustomTransactionCard({
    this.transactions,
    this.visibleFields = const [],
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading ? _buildSkeleton() : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final widgets = <Widget>[];

    if (visibleFields.contains("processDate")) {
      widgets.add(_buildRow("Process date", _formatDate(transactions!.processDate)));
      widgets.add(const SizedBox(height: 12));
    }
    if (visibleFields.contains("actualPaymentAmount")) {
      widgets.add(
        _buildRow(
          "Amount",
          "\$${transactions!.actualPaymentAmount.toStringAsFixed(2)}",
        ),
      );
      widgets.add(const SizedBox(height: 12));
    }
    if (visibleFields.contains("paymentType")) {
      widgets.add(_buildRow("Type", transactions!.paymentType));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildSkeleton() {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Data", style: AppTextStyles.get12w400()),
              _shimmerBox(width: 140),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Data", style: AppTextStyles.get12w400()),
              _shimmerBox(width: 140),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 24,
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

import 'package:flutter/material.dart';
import 'package:project_by_iago/src/core/theme/app_colors.dart';
import 'package:project_by_iago/src/core/theme/app_text_styles.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_shimmer_box.dart';

import '../../../../../core/utils/converter_helper.dart';

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
    final Map<String, dynamic> cardItems = transaction.toMap();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxCrossAxisExtent = constraints.maxWidth / 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxCrossAxisExtent,
                mainAxisExtent: 60,
              ),
              itemCount: visibleFields.length,
              itemBuilder: (_, index) {
                    !isLoading ? cardItems[visibleFields[index].key] : "";
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      visibleFields[index].label,
                      style: AppTextStyles.get12w400(),
                    ),
                    !isLoading
                        ? Text(
                      ConverterHelper.getFormattedTransactionValue(transaction, visibleFields[index].key),
                          // value,
                          style: AppTextStyles.get16w400(AppColors.blackFont),
                        )
                        : CustomShimmerBox(width: 140),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

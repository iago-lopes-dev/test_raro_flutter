import 'package:flutter/material.dart';
import 'package:project_by_iago/src/core/theme/app_colors.dart';
import 'package:project_by_iago/src/core/theme/app_text_styles.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_shimmer_box.dart';

import '../../../../../core/utils/converter_helper.dart';
import '../../../domain/entity/payments_summary_entity.dart';

class CustomSummaryCard extends StatelessWidget {
  final PaymentsSummaryEntity summary;
  final bool isLoading;

  const CustomSummaryCard({
    required this.summary,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.label,
              style: AppTextStyles.get12w400(),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            isLoading
                ? CustomShimmerBox()
                : Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0, -4),
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
}

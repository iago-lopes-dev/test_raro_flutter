import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_by_iago/src/core/theme/app_colors.dart';
import 'package:project_by_iago/src/core/theme/app_text_styles.dart';
import 'package:project_by_iago/src/core/core.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_shimmer_box.dart';

import '../../../domain/entity/payments_schedule_entity.dart';

class CustomScheduleCard extends StatelessWidget {
  final PaymentsScheduleEntity scheduled;
  final bool isLoading;
  final bool isNextPayment;

  const CustomScheduleCard({
    required this.scheduled,
    required this.isLoading,
    this.isNextPayment = false,
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
        child:
            isLoading
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomShimmerBox(width: 120),
                    CustomShimmerBox(width: 120),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat(
                            'MM/dd/yyyy',
                          ).format(scheduled.paymentDate),
                          style: AppTextStyles.get16w400(AppColors.blackFont),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox.fromSize(size: const Size(50, 0)),
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0, -4),
                                  child: Text(
                                    "\$",
                                    style: AppTextStyles.get10w400(
                                      AppColors.blackFont,
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text:
                                    ConverterHelper.thousandSeparatorFormatter(
                                      scheduled.principal,
                                    ),
                                style: AppTextStyles.get16w400(
                                  AppColors.blackFont,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isNextPayment
                        ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.grayLight,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 12,
                            ),
                            child: Text(
                              "Next",
                              style: AppTextStyles.get14w400(
                                AppColors.blueBackground,
                              ),
                            ),
                          ),
                        )
                        : SizedBox.shrink(),
                  ],
                ),
      ),
    );
  }
}

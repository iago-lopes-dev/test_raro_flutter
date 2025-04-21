import 'package:project_by_iago/src/core/base/constants/app_text_styles.dart';
import 'package:project_by_iago/src/core/utils/json_helper.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/cards/custom_schedule_card.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/payments_schedule_entity.dart';

class ScheduleList extends StatelessWidget {
  final PaymentsState state;

  const ScheduleList({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final bool isLoading = state is PaymentsLoadingState;

    final List<PaymentsScheduleEntity> paymentsScheduled =
        state is PaymentsSuccessState
            ? (state as PaymentsSuccessState).paymentsInfo.paymentsScheduled
            : JsonHelper.getMockScheduledFromJson();

    final PaymentsScheduleEntity nextPaymentItem = paymentsScheduled.reduce(
      (scheduledA, scheduledB) =>
          scheduledA.paymentDate
                      .difference(currentDate)
                      .abs()
                      .compareTo(
                        scheduledB.paymentDate.difference(currentDate).abs(),
                      ) <
                  0
              ? scheduledA
              : scheduledB,
    );

    return state.paymentsInfo.paymentsScheduled.isEmpty
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Text(
            "Once your loan is booked your payment schedule will appear here. This process may take 1-2 business days.",
            textAlign: TextAlign.center,
            style: AppTextStyles.get14w400italic(),
          ),
        )
        : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: paymentsScheduled.length,
          itemBuilder: (_, index) {
            final isNextPayment = paymentsScheduled[index] == nextPaymentItem;
            return CustomScheduleCard(
              schedule: paymentsScheduled[index],
              isLoading: isLoading,
              isNextPayment: isNextPayment,
            );
          },
        );
  }
}

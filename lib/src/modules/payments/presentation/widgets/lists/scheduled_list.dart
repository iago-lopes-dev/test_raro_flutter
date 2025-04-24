import 'package:flutter/material.dart';
import 'package:project_by_iago/src/core/theme/app_text_styles.dart';
import 'package:project_by_iago/src/core/utils/extensions.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/cards/custom_schedule_card.dart';

import '../../../domain/entity/payments_schedule_entity.dart';

class ScheduledList extends StatelessWidget {
  final PaymentsState state;

  const ScheduledList({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoading = state is PaymentsLoadingState;
    final List<PaymentsScheduleEntity> paymentsScheduled =
        state.paymentsInfo.paymentsScheduled;

    if (state.paymentsInfo.paymentsScheduled.isEmpty ||
        state is PaymentsInitialState ||
        state is PaymentsErrorState) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Text(
            "Once your loan is booked your payment schedule will appear here. This process may take 1-2 business days.",
            textAlign: TextAlign.center,
            style: AppTextStyles.get14w400italic(),
          ),
        ),
      );
    }

    final PaymentsScheduleEntity nextPaymentItem =
        paymentsScheduled.getNextPayment();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: paymentsScheduled.length,
        (context, index) {
          final bool isNextPayment =
              paymentsScheduled[index] == nextPaymentItem;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomScheduleCard(
              scheduled: paymentsScheduled[index],
              isLoading: isLoading,
              isNextPayment: isNextPayment,
            ),
          );
        },
      ),
    );
  }
}

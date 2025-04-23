import 'package:flutter/material.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/cards/custom_summary_card.dart';

import '../../../domain/entity/payments_summary_entity.dart';

class SummariesList extends StatelessWidget {
  final PaymentsState state;

  const SummariesList({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoading = state is PaymentsLoadingState;
    final List<PaymentsSummaryEntity> summaries = state.paymentsInfo.summary;
    if (state is PaymentsInitialState ||
        state is PaymentsErrorState ||
        summaries.isEmpty) {
      return const SizedBox(height: 0);
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
                child: CustomSummaryCard(
                  summary: summaries[index],
                  isLoading: isLoading,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

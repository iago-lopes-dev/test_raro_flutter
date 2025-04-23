import 'package:flutter/material.dart';
import 'package:project_by_iago/src/core/utils/helpers/json_helper.dart';
import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/cards/custom_summary_card.dart';

class SummariesList extends StatelessWidget {
  final PaymentsState state;

  const SummariesList({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    if (state is PaymentsInitialState || state is PaymentsErrorState) {
      return const SizedBox.shrink();
    }

    final List<PaymentsSummaryModel> summaries =
        state is PaymentsSuccessState
            ? (state as PaymentsSuccessState).paymentsInfo.summary
                .map((e) => e as PaymentsSummaryModel)
                .toList()
            : JsonHelper.getMockSummariesFromJson();

    return SizedBox(
      height: 130,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            itemCount: summaries.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              return SizedBox(
                width: constraints.maxWidth * 0.4,
                child: CustomSummaryCard(
                  state: state,
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// TODO (Ogai): Conferir dados do card com figma
}

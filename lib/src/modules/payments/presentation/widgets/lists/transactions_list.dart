import 'package:base_project/src/core/base/constants/app_text_styles.dart';
import 'package:base_project/src/core/utils/payments_transaction_helper.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/cards/custom_transaction_card.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/payments_transactions_entity.dart';
import '../../../domain/entity/payments_transactions_filter_entity.dart';

class TransactionsList extends StatelessWidget {
  final PaymentsState state;

  const TransactionsList({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoading = state is PaymentsLoadingState;

    final List<PaymentsTransactionFilterEntity> visibleFields =
        state is PaymentsSuccessState
            ? (state as PaymentsSuccessState).visibleTransactionFields
            : [];

    final List<PaymentsTransactionsEntity> listToRender =
        PaymentsTransactionHelper.getFilteredTransactionsToRender(state: state);

    return state.paymentsInfo.transactions.isEmpty
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Text(
            "Once you begin your payments they will appear here. This process may take 1-2 business days.",
            textAlign: TextAlign.center,
            style: AppTextStyles.get14w400italic(),
          ),
        )
        : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: listToRender.length,
          itemBuilder: (_, index) {
            return CustomTransactionCard(
              transaction: listToRender[index],
              visibleFields: visibleFields,
              isLoading: isLoading,
            );
          },
        );
  }
}

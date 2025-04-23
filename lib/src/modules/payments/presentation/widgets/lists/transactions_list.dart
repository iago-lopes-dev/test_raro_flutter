import 'package:flutter/material.dart';
import 'package:project_by_iago/src/core/base/constants/app_text_styles.dart';
import 'package:project_by_iago/src/core/utils/mappers/payments_transaction_mapper.dart';
import 'package:project_by_iago/src/modules/payments/data/data.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/cards/custom_transaction_card.dart';

class TransactionsList extends StatelessWidget {
  final PaymentsState state;

  const TransactionsList({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoading = state is PaymentsLoadingState;
    final List<PaymentsTransactionsModel> transactions =
        PaymentsTransactionMapper().fromEntityList(
          state.paymentsInfo.transactions,
        );

    final List<PaymentsTransactionFilterEntity> visibleFields =
        state.visibleTransactionFields;

    if (state.paymentsInfo.transactions.isEmpty ||
        state is PaymentsInitialState ||
        state is PaymentsErrorState) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
        child: Text(
          "Once you begin your payments they will appear here. This process may take 1-2 business days.",
          textAlign: TextAlign.center,
          style: AppTextStyles.get14w400italic(),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: transactions.length,
      itemBuilder: (_, index) {
        return CustomTransactionCard(
          transaction: transactions[index],
          visibleFields: visibleFields,
          isLoading: isLoading,
        );
      },
    );
  }
}

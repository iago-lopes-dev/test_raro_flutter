import 'package:base_project/src/core/utils/json_helper.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';

import '../../modules/payments/domain/entity/payments_transactions_entity.dart';

class PaymentsTransactionHelper {
  static List<PaymentsTransactionsEntity> getFilteredTransactionsToRender({
    required PaymentsState state,
  }) {
    if (state is! PaymentsSuccess) {
      return JsonHelper.getMockTransactionsFromJson();
    }

    final paymentsTransactions = state.paymentsInfo.transactions;
    final visibleFields = state.visibleTransactionFields;

    if (visibleFields.isEmpty ||
        state.selectedTabIndex >= visibleFields.length) {
      return paymentsTransactions;
    }

    final selectedLabel = visibleFields[state.selectedTabIndex].label;

    return paymentsTransactions
        .where((e) => e.paymentType == selectedLabel)
        .toList();
  }
}

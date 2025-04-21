import 'package:base_project/src/core/utils/json_helper.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';

import '../../modules/payments/domain/entity/payments_transactions_entity.dart';
import '../../modules/payments/domain/entity/payments_transactions_filter_entity.dart';

class PaymentsTransactionHelper {
  static List<PaymentsTransactionsEntity> getFilteredTransactionsToRender({
    required PaymentsState state,
  }) {
    if (state is! PaymentsSuccessState) {
      return JsonHelper.getMockTransactionsFromJson();
    }

    final List<PaymentsTransactionsEntity> paymentsTransactions =
        state.paymentsInfo.transactions;
    final List<PaymentsTransactionFilterEntity> visibleFields =
        state.visibleTransactionFields;

    if (visibleFields.isEmpty || state.isTransactionsSelected) {
      return paymentsTransactions;
    }

    final String selectedLabel = visibleFields[state.selectedTabIndex].label;

    return paymentsTransactions
        .where((e) => e.paymentType == selectedLabel)
        .toList();
  }
}

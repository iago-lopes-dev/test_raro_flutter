import 'package:base_project/src/modules/payments/presentation/widgets/cards/custom_transaction_card.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/payments_transactions_entity.dart';

class TransactionsList extends StatelessWidget {
  final List<PaymentsTransactionsEntity> data;
  final List<String> visibleFields;
  final ValueNotifier<int> selectedTabIndex;
  final bool isLoading;

  const TransactionsList({
    required this.data,
    required this.selectedTabIndex,
    required this.visibleFields,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabIndex = selectedTabIndex.value;

    final filteredItems =
        tabIndex == 0
            ? data.where((e) => e.paymentType == "PaymentType1").toList()
            : data.where((e) => e.paymentType != "PaymentType1").toList();

    if (isLoading) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: 5,
        itemBuilder: (_, index) => const CustomTransactionCard(isLoading: true),
      );
    }

    return filteredItems.isEmpty
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Text(
            textAlign: TextAlign.center,
            tabIndex == 0
                ? "Once your loan is booked your payment schedule will appear here. This process may take 1-2 business days."
                : "Once you begin your payments they will appear here. This process may take 1-2 business days.",
            style: TextStyle(
              color: Color(0xFF868C98BF),
              fontSize: 14,
              fontWeight: FontWeight.w400,

              ///TODO(Ogai): Alterar fonte
              // fontFamily: FontFamilies.lato,
              fontStyle: FontStyle.italic,
            ),
          ),
        )
        : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: filteredItems.length,
          itemBuilder: (_, index) {
            final item = filteredItems[index];
            return CustomTransactionCard(transactions: item, visibleFields: visibleFields ,isLoading: isLoading);
          },
        );
  }
}

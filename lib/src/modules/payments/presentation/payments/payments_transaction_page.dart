import 'package:base_project/src/modules/payments/presentation/payments/payments_transaction_view.dart';
import 'package:flutter/cupertino.dart';

class PaymentsTransactionPage extends StatefulWidget {
  const PaymentsTransactionPage({super.key});

  @override
  State<PaymentsTransactionPage> createState() =>
      _PaymentsTransactionsPageState();
}

class _PaymentsTransactionsPageState extends State<PaymentsTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return PaymentsTransactionView();
  }
}

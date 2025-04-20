import 'package:flutter/material.dart';

import 'modules/payments/presentation/payments/payments_transaction_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test of Iago',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF232F69)),
        useMaterial3: true,
      ),
      home: const PaymentsTransactionPage(),
    );
  }
}

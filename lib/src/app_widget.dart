import 'package:project_by_iago/src/core/base/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'modules/payments/presentation/page/payments_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test by Iago',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueBackground),
        useMaterial3: true,
      ),
      home: const PaymentsPage(),
    );
  }
}

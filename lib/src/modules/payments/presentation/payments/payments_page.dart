import 'package:base_project/src/core/di/payments_module_injector.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/payments/payments_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaymentsBloc>(),
      child: const PaymentsView(),
    );
  }
}

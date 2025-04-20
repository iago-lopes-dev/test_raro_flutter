import 'dart:async';

import 'package:base_project/src/core/base/constants/app_colors.dart';
import 'package:base_project/src/core/di/payments_module_injector.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/cards/custom_summary_card.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/custom_bottom_sheet.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/custom_tab_selector.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/lists/transactions_list.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/lists/schedule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTransactionView extends StatefulWidget {
  const PaymentsTransactionView({super.key});

  @override
  State<PaymentsTransactionView> createState() =>
      _PaymentsTransactionViewState();
}

class _PaymentsTransactionViewState extends State<PaymentsTransactionView> {
  final ValueNotifier<int> selectedTabIndex = ValueNotifier(0);
  late final PaymentsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = sl<PaymentsBloc>();
    bloc.add(FetchPaymentsEvent());

    selectedTabIndex.addListener(() {
      bloc.add(FetchPaymentsEvent());
    });
  }

  Future<void> _refresh() async {
    bloc.add(FetchPaymentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsBloc, PaymentsState>(
      bloc: bloc,
      builder: (context, state) {
        // state = PaymentsInitial();
        state = PaymentsLoading();
        // state = PaymentsInitial();
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: _buildAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSummaryCards(state: state),
              _buildClickHere(),
              const SizedBox(height: 16),
              CustomTabSelector(
                selectedTabIndex: selectedTabIndex,
                onMorePressed: () {
                  final state = bloc.state;
                  if (state is PaymentsSuccess) {
                    showBottomSheet(context, state.visibleTransactionFields);
                  }
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ValueListenableBuilder<int>(
                    valueListenable: selectedTabIndex,
                    builder: (_, tabIndex, __) {
                      if (state is PaymentsLoading) {
                        return tabIndex == 0
                            ? ScheduleList(
                              selectedTabIndex: selectedTabIndex,
                              data: [],
                              isLoading: true,
                            )
                            : TransactionsList(
                              selectedTabIndex: selectedTabIndex,
                              data: [],
                              isLoading: true,
                              visibleFields: [],
                            );
                      } else if (state is PaymentsSuccess) {
                        return tabIndex == 0
                            ? ScheduleList(
                              selectedTabIndex: selectedTabIndex,
                              data: state.paymentsInfo.paymentsScheduled,
                              isLoading: false,
                            )
                            : TransactionsList(
                              selectedTabIndex: selectedTabIndex,
                              data: state.paymentsInfo.transactions,
                              isLoading: false,
                              visibleFields: state.visibleTransactionFields,
                            );
                      } else if (state is PaymentsError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF232F69),
      elevation: 0,
      centerTitle: true,
      title: const Text("Payments", style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: Colors.white),
          onPressed: () {
            final state = bloc.state;
            if (state is PaymentsSuccess) {
              showBottomSheet(context, state.visibleTransactionFields);
            }
          },
        ),
      ],
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF232F69),
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildClickHere() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Do you want to make a payment? "),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Click here",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(BuildContext context, List<String> selectedFields) {
    unawaited(
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        context: context,
        builder: (_) {
          return TransactionsColumnFilterBottomSheet(
            selectedFields: selectedFields,
            onSave: (updateFields) {
              bloc.add(UpdateVisibleTransactionFieldsEvent(updateFields));
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}

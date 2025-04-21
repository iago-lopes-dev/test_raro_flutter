import 'dart:async';

import 'package:base_project/src/core/base/constants/app_colors.dart';
import 'package:base_project/src/core/di/payments_module_injector.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/change_tab_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/cards/custom_summary_card.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/custom_bottom_sheet_modal.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/custom_tab_selector.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/lists/transactions_list.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/lists/schedule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsView extends StatefulWidget {
  const PaymentsView({super.key});

  @override
  State<PaymentsView> createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<PaymentsView> {
  late final PaymentsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = sl<PaymentsBloc>();
    bloc.add(FetchPaymentsEvent());
  }

  Future<void> _refresh() async {
    bloc.add(RefreshPaymentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsBloc, PaymentsState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: _buildAppBar(state),
          body: state is PaymentsSuccess
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSummaryCards(state: state),
              _buildCallToAction(),
              const SizedBox(height: 16),
              CustomTabSelector(
                state: state,
                onTabChanged: (index) {
                  context
                      .read<PaymentsBloc>()
                      .add(ChangeTabEvent(index));
                },
                onMorePressed: () => _showBottomSheet(context, state),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: _buildTabContent(state),
                ),
              ),
            ],
          )
              : _buildLoadingOrError(state),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(PaymentsState state) {
    return AppBar(
      backgroundColor: const Color(0xFF232F69),
      elevation: 0,
      centerTitle: true,
      title: const Text("Payments", style: TextStyle(color: AppColors.white)),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: AppColors.white),
          onPressed: () => _showBottomSheet(context, state),
        ),
      ],
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF232F69),
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildCallToAction() {
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
              style: TextStyle(color: AppColors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(PaymentsSuccess state) {
    final tabIndex = state.selectedTabIndex;
    return tabIndex == 0
        ? ScheduleList(state: state)
        : TransactionsList(state: state);
  }

  Widget _buildLoadingOrError(PaymentsState state) {
    if (state is PaymentsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PaymentsError) {
      return Center(child: Text('Error: ${state.message}'));
    } else {
      return const Center(child: Text('Unexpected state.'));
    }
  }

  void _showBottomSheet(BuildContext context, PaymentsState state) async {
    final selectedFields = await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (_) {
        return CustomBottomSheetModal(
          title: "Additional information",
          state: state,
        );
      },
    );

    if (selectedFields != null) {
      bloc.add(UpdateVisibleTransactionFieldsEvent(selectedFields));
    }
  }
}

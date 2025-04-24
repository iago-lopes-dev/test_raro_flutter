import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_by_iago/src/core/theme/app_colors.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_app_bar.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_tab_selector.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/lists/scheduled_list.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/lists/summaries_list.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/lists/transactions_list.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/modals/custom_bottom_sheet_modal.dart';

import '../../data/repository/payment_repository_impl.dart';
import '../../infra/datasource/payments_datasource_impl.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late final PaymentsBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = PaymentsBloc(
      GetPaymentsUseCase(PaymentsRepositoryImpl(PaymentsDatasourceImpl())),
    );

    bloc.add(FetchPaymentsEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    bloc.add(RefreshPaymentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<PaymentsBloc, PaymentsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.defaultBackground,
            appBar: CustomAppBar(title: "Payments"),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: SummariesList(state: state)),
                  SliverToBoxAdapter(
                    child: _buildCallToAction(
                      state.paymentsInfo.paymentsScheduled.isNotEmpty ||
                          state.paymentsInfo.transactions.isNotEmpty,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(
                    child: CustomTabSelector(
                      state: state,
                      onMorePressed: () => _showBottomSheet(context, state),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  state.isScheduleSelected
                      ? ScheduledList(state: state)
                      : TransactionsList(state: state),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCallToAction(bool isLoaded) {
    return Visibility(
      visible: isLoaded,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Do you want to make a payment? "),
            Tooltip(
              message: "Click here",
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  "Click here",
                  style: TextStyle(color: AppColors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, PaymentsState state) async {
    final List<PaymentsTransactionFilterEntity> selectedFields =
        await showModalBottomSheet(
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

    bloc.add(UpdateVisibleTransactionFieldsEvent(selectedFields));
  }
}

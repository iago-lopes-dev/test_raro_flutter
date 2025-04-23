import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_by_iago/src/core/base/constants/app_colors.dart';
import 'package:project_by_iago/src/modules/payments/domain/domain.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/cards/custom_summary_card.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_tab_selector.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/lists/scheduled_list.dart';
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
            appBar: _buildAppBar(state),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSummaryCard(state: state),
                _buildCallToAction(),
                const SizedBox(height: 16),
                CustomTabSelector(
                  state: state,
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
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(PaymentsState state) {
    return AppBar(
      backgroundColor: AppColors.blueBackground,
      elevation: 0,
      centerTitle: true,
      title: const Text("Payments", style: TextStyle(color: AppColors.white)),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: AppColors.white),
          onPressed: () {},
        ),
      ],
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.blueBackground,
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

  Widget _buildTabContent(PaymentsState state) {
    return state.isScheduleSelected
        ? ScheduledList(state: state)
        : TransactionsList(state: state);
  }

  void _showBottomSheet(BuildContext context, PaymentsState state) async {
    final List<PaymentsTransactionFilterEntity> selectedFields = await showModalBottomSheet(
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

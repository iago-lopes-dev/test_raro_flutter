import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_by_iago/src/core/base/enums/payments_tab_enum.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_tab_changed_event.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/buttons/custom_tab_button.dart';

class CustomTabSelector extends StatelessWidget {
  final PaymentsState state;
  final VoidCallback onMorePressed;

  const CustomTabSelector({
    required this.state,
    required this.onMorePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTabButton(
                  title: "SCHEDULE",
                  isSelected: state.isScheduleSelected,
                  onTap:
                      () => context.read<PaymentsBloc>().add(
                        PaymentsTabChangedEvent(PaymentsTabEnum.schedule),
                      ),
                ),
                CustomTabButton(
                  title: "TRANSACTIONS",
                  isSelected: state.isTransactionsSelected,
                  onTap:
                      () => context.read<PaymentsBloc>().add(
                        PaymentsTabChangedEvent(PaymentsTabEnum.transactions),
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed:
                state.isTransactionsSelected &&
                        state.visibleTransactionFields.isNotEmpty
                    ? onMorePressed
                    : null,
            tooltip: "More",
          ),
        ],
      ),
    );
  }
}

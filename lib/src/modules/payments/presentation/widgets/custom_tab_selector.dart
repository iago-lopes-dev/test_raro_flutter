import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:project_by_iago/src/modules/payments/presentation/bloc/payments_tab_changed_event.dart';
import 'package:project_by_iago/src/modules/payments/presentation/widgets/custom_tap_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          Visibility(
            visible: state.isTransactionsSelected,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: onMorePressed,
              tooltip: "More",
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/custom_tap_button.dart';
import 'package:flutter/material.dart';

class CustomTabSelector extends StatelessWidget {
  final PaymentsState state;
  final Function(int) onTabChanged;
  final VoidCallback onMorePressed;

  const CustomTabSelector({
    required this.state,
    required this.onTabChanged,
    required this.onMorePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int selectedTabIndex = state.selectedTabIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTabButton(
                  title: "SCHEDULE",
                  isSelected: selectedTabIndex == 0,
                  onTap: () => onTabChanged(0),
                ),
                const SizedBox(width: 16),
                CustomTabButton(
                  title: "TRANSACTIONS",
                  isSelected: selectedTabIndex == 1,
                  onTap: () => onTabChanged(1),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: onMorePressed,
          ),
        ],
      ),
    );
  }
}

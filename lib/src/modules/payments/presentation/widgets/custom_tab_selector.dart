import 'package:base_project/src/modules/payments/presentation/widgets/custom_tap_button.dart';
import 'package:flutter/material.dart';

class CustomTabSelector extends StatelessWidget {
  final ValueNotifier<int> selectedTabIndex;
  final VoidCallback onMorePressed;

  const CustomTabSelector({
    super.key,
    required this.selectedTabIndex,
    required this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: selectedTabIndex,
              builder: (context, value, _) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTabButton(
                    title: "SCHEDULE",
                    isSelected: value == 0,
                    onTap: () => selectedTabIndex.value = 0,
                  ),
                  const SizedBox(width: 16),
                  CustomTabButton(
                    title: "TRANSACTIONS",
                    isSelected: value == 1,
                    onTap: () => selectedTabIndex.value = 1,
                  ),
                ],
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: onMorePressed),
        ],
      ),
    );
  }
}

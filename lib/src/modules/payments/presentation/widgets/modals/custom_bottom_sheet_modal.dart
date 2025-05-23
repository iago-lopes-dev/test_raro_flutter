import "package:flutter/material.dart";
import "package:project_by_iago/src/core/theme/app_colors.dart";
import "package:project_by_iago/src/core/theme/app_text_styles.dart";
import "package:project_by_iago/src/modules/payments/domain/domain.dart";
import "package:project_by_iago/src/modules/payments/presentation/bloc/payments_state.dart";

class CustomBottomSheetModal extends StatefulWidget {
  final PaymentsState state;
  final String title;
  final EdgeInsets padding;
  final Color? color;

  const CustomBottomSheetModal({
    required this.state,
    this.title = "",
    this.padding = const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
    this.color,
    super.key,
  });

  @override
  State<CustomBottomSheetModal> createState() => _CustomBottomSheetModalState();
}

class _CustomBottomSheetModalState extends State<CustomBottomSheetModal> {
  late List<PaymentsTransactionFilterEntity> allFilters;
  late List<PaymentsTransactionFilterEntity> selectedFilters;

  @override
  void initState() {
    super.initState();
    allFilters = widget.state.paymentsInfo.transactionFilter;
    selectedFilters = List.from(
      (widget.state as PaymentsSuccessState).visibleTransactionFields,
    );
    for (var filter in allFilters.where((f) => f.isDefault)) {
      if (!selectedFilters.any((f) => f.label == filter.label)) {
        selectedFilters.add(filter);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, selectedFilters);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              minHeight: 0,
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 100,
            ),
            child: Container(
              padding: widget.padding,
              decoration: BoxDecoration(
                color: widget.color ?? AppColors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(24.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox.fromSize(size: Size(10, 10)),
                    buildHeader(),
                    SizedBox.fromSize(size: Size(10, 10)),
                    Column(
                      children:
                          allFilters
                              .map(
                                (filter) => CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: selectedFilters.any(
                                    (f) => f.label == filter.label,
                                  ),
                                  enabled: !filter.isDefault,
                                  activeColor: AppColors.green,
                                  checkColor: AppColors.white,
                                  title: Text(
                                    filter.label,
                                    style: AppTextStyles.get16w400(),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        if (!selectedFilters.any(
                                          (f) => f.label == filter.label,
                                        )) {
                                          selectedFilters.add(filter);
                                        }
                                      } else {
                                        selectedFilters.removeWhere(
                                          (f) => f.label == filter.label,
                                        );
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.get16w600(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: AppColors.grayFont),
          onPressed: () => Navigator.pop(context, selectedFilters),
        ),
      ],
    );
  }
}

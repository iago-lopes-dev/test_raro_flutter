import "package:base_project/src/modules/payments/presentation/widgets/custom_bottom_sheet_modal.dart";
import 'package:flutter/material.dart';

class TransactionsColumnFilterBottomSheet extends StatefulWidget {
  final List<String> selectedFields;
  final Function(List<String>) onSave;

  const TransactionsColumnFilterBottomSheet({
    super.key,
    required this.selectedFields,
    required this.onSave,
  });

  @override
  State<TransactionsColumnFilterBottomSheet> createState() =>
      _TransactionsColumnFilterBottomSheetState();
}

class _TransactionsColumnFilterBottomSheetState
    extends State<TransactionsColumnFilterBottomSheet> {
  late List<String> selected;

  final List<String> allFields = const [
    "Process Date",
    "Amount",
    "Type",
    "Principal",
    "Interest",
    "Late Fee",
    "Post Date",
    "Principal Balance",
  ];

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.selectedFields);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetModal(
      title: "Additional information",
      body: Column(
        children: allFields
            .map((field) => CheckboxListTile(
          value: selected.contains(field),
          activeColor: Colors.green,
          checkColor: Colors.white,
          title: Text(field, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          onChanged: (value) {
            setState(() {
              if (value == true) {
                selected.add(field);
              } else {
                selected.remove(field);
              }
            });
          },
        ))
            .toList(),
      ),
      // bottom: CustomButton(
      //   title: "Save",
      //   onTap: () {
      //     widget.onSave(selected);
      //     Navigator.pop(context);
      //   },
      //   width: double.infinity,
      // ),
    );
  }
}

import "package:flutter/material.dart";

class CustomBottomSheetModal extends StatefulWidget {
  final Widget body;
  final Widget? bottom;
  final Color? color;
  final String title;
  final EdgeInsets padding;
  final bool hasBackButton;
  final VoidCallback? onClose;

  const CustomBottomSheetModal({
    required this.body,
    this.bottom,
    this.color,
    this.title = "",
    this.padding = const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
    this.hasBackButton = true,
    this.onClose,
    super.key,
  });

  @override
  State<CustomBottomSheetModal> createState() => _CustomBottomSheetModalState();
}

class _CustomBottomSheetModalState extends State<CustomBottomSheetModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              color: widget.color ?? Colors.black,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(
                    24.0,
                  )),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox.fromSize(size: Size(10, 10)),
                  buildHeader(),
                  SizedBox.fromSize(size: Size(10, 10)),
                  widget.body,
                  buildBottom(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBottom() {
    return widget.bottom == null
        ? SizedBox.shrink()
        : Column(
      children: [
        SizedBox.fromSize(size: Size(10, 10)),SizedBox.fromSize(size: Size(10, 10)),
        widget.bottom!,
        SizedBox.fromSize(size: Size(10, 10)),
      ],
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: widget.hasBackButton
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        // Visibility(
        //   visible: widget.hasBackButton,
        //   child: CustomHoverIconButton(
        //     image: "arrowLeft",
        //     iconColor: AppColors.white,
        //     borderColor: AppColors.grayCharcoal,
        //     backgroundColor: AppColors.blackEerie,
        //     iconPadding: const EdgeInsets.all(8),
        //     onTap: widget.onClose ?? () => Navigator.pop(context),
        //   ),
        // ),
        Flexible(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            // style: TextStyle().walkway(size: 20),
          ),
        ),
        Visibility(
          visible: widget.hasBackButton,
          child: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

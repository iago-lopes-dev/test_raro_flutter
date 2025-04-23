import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_by_iago/src/core/theme/app_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onHelpPressed;

  const CustomAppBar({required this.title, this.onHelpPressed, super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blueBackground,
      elevation: 0,
      centerTitle: true,
      title: Text(widget.title, style: TextStyle(color: AppColors.white)),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: AppColors.white),
          onPressed: () => widget.onHelpPressed,
        ),
      ],
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.blueBackground,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}

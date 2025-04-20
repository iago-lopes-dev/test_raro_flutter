import 'package:base_project/src/core/base/constants/app_colors.dart';
import 'package:base_project/src/core/base/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyles.get14w500(
                isSelected ? AppColors.blackFont : AppColors.grayFont,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: isSelected ? AppColors.green : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

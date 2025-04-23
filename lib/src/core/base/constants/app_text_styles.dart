import 'package:flutter/material.dart';

import 'package:project_by_iago/src/core/base/constants/app_colors.dart';

abstract class AppTextStyles {
  static const Color defaultFontColor = AppColors.grayFont;
  static const double defaultFontSize = 12.0;
  static const FontWeight defaultFontWeight = FontWeight.w400;

  static TextStyle get10w400([Color? color, AppFontStyle? font]) => TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: color ?? defaultFontColor,
    fontFamily: font?.title ?? AppFontStyle.lato.title,
  );

  static TextStyle get12w400([Color? color, AppFontStyle? font]) => TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: color ?? defaultFontColor,
    fontFamily: font?.title ?? AppFontStyle.lato.title,
  );

  static TextStyle get14w400([Color? color, AppFontStyle? font]) => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: color ?? defaultFontColor,
    fontFamily: font?.title ?? AppFontStyle.lato.title,
  );

  static TextStyle get14w400italic([Color? color, AppFontStyle? font]) =>
      TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: color ?? defaultFontColor,
        fontFamily: font?.title ?? AppFontStyle.lato.title,
        fontStyle: FontStyle.italic,
      );

  static TextStyle get14w500([Color? color, AppFontStyle? font]) => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: color ?? defaultFontColor,
    fontFamily: font?.title ?? AppFontStyle.lato.title,
  );

  static TextStyle get14w600([Color? color, AppFontStyle? font]) => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: color ?? defaultFontColor,
    fontFamily: font?.title ?? AppFontStyle.lato.title,
  );

  static TextStyle get16w400([Color? color, AppFontStyle? font]) => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: color ?? defaultFontColor,
    fontFamily: font?.title ?? AppFontStyle.lato.title,
  );

  static TextStyle get16w600([Color? color, AppFontStyle? font]) => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: color ?? defaultFontColor,
    fontFamily: font?.title ?? AppFontStyle.lato.title,
  );
}

enum AppFontStyle {
  lato("Lato");

  final String title;

  const AppFontStyle(this.title);
}

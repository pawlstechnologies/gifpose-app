import 'package:flutter/material.dart';
import '../theme_tpye.dart';
import 'qost_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:qost/app.dart';
import 'package:qost/screens/main/viewmodel/base_view_model.dart';
import 'package:qost/utils/theme/font_util.dart';

class QostTextStyle {
  //Title
  static TextStyle title1(
      {double fontSize = 48,
      FontFamily fontFamily = FontFamily.sfProDisplay,
      FontWeight fontWeight = FontWeight.bold,
      Color? color}) {
    final baseVM =
        Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
    return TextStyle(
        fontFamily: fontFamily.name,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color);
  }
    static TextStyle title2(
      {double fontSize = 48,
      FontFamily fontFamily = FontFamily.coolvetica,
      FontWeight fontWeight = FontWeight.normal,
      Color? color}) {
    final baseVM =
        Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
    return TextStyle(
        fontFamily: fontFamily.name,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
       color: color ??
          ((baseVM.qostThemeMode == QostThemeMode.light)
              ? QostColors.textColor
              : QostColors.background),
        
        );
  }
   static TextStyle title3(
      {double fontSize = 32,
    FontFamily fontFamily = FontFamily.sfProDisplay,
      FontWeight fontWeight = FontWeight.normal,
      Color? color}) {
    final baseVM =
        Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
    return TextStyle(
        fontFamily: fontFamily.name,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color);
  }
    static TextStyle heading1(
      {double fontSize = 24,
      FontFamily fontFamily = FontFamily.sfProDisplay,
      FontWeight fontWeight = FontWeight.bold,
      Color? color}) {
    final baseVM =
        Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
    return TextStyle(
        fontFamily: fontFamily.toString(),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color ??
          ((baseVM.qostThemeMode == QostThemeMode.light)
              ? QostColors.textColor
              : QostColors.background),
        
        );
  }
    static TextStyle normal(
      {double fontSize = 16,
      FontFamily fontFamily = FontFamily.sfProDisplay,
      FontWeight fontWeight = FontWeight.bold,
      TextDecoration? decoration,
      Color? color}) {
    final baseVM =
        Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
    return TextStyle(
      decoration: decoration,
        fontFamily: fontFamily.toString(),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color ??
          ((baseVM.qostThemeMode == QostThemeMode.light)
              ? QostColors.textColor
              : QostColors.background),
        
        );
  }
    static TextStyle medium(
      {double fontSize = 14,
      FontFamily fontFamily = FontFamily.sfProDisplay,
      FontWeight fontWeight = FontWeight.bold,
           TextDecoration? decoration,
      Color? color}) {
    final baseVM =
        Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
    return TextStyle(
      
            decoration: decoration,
        fontFamily: fontFamily.toString(),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      
        color: color ??
          ((baseVM.qostThemeMode == QostThemeMode.light)
              ? QostColors.textColor
              : QostColors.background),
        
        );
  }
    static TextStyle small(
      {double fontSize =12,
      FontFamily fontFamily = FontFamily.sfProDisplay,
      FontWeight fontWeight = FontWeight.bold,
            TextDecoration? decoration,
      Color? color}) {
    final baseVM =
        Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
    return TextStyle(
            decoration: decoration,
        fontFamily: fontFamily.toString(),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color ??
          ((baseVM.qostThemeMode == QostThemeMode.light)
              ? QostColors.textColor
              : QostColors.background),
        
        );
  }

  // //Heading
  // static TextStyle heading1({
  //   double fontSize = 30,
  //   FontFamily fontFamily = FontFamily.sfProDisplay,
  //   FontWeight fontWeight = FontWeight.bold,
  //   Color? color,
  // }) {
  //   final baseVM =
  //       Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   return TextStyle(
  //     fontFamily: fontFamily.toString(),
  //     fontSize: fontSize.sp,
  //     fontWeight: fontWeight,
  //     color: color ??
  //         ((baseVM.parellexThemeMode == ParallexThemeMode.light)
  //             ? ParallexColors.black100
  //             : ParallexColors.white),
  //   );
  // }


  // static TextStyle heading7({
  //   double fontSize = 20,
  //   FontFamily fontFamily = FontFamily.roboto,
  //   FontWeight fontWeight = FontWeight.bold,
  //   Color? color,
  // }) {
  //   final baseVM =
  //       Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   return TextStyle(
  //     fontSize: fontSize.sp,
  //     fontWeight: fontWeight,
  //     color: color ??
  //         ((baseVM.parellexThemeMode == ParallexThemeMode.light)
  //             ? ParallexColors.black100
  //             : ParallexColors.white),
  //   );
  // }



}

import 'package:flutter/material.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/utils/theme/font_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GiftPoseTextStyle {
  //Title

    static TextStyle heading1(
      {double fontSize = 20,
      FontFamily fontFamily = FontFamily.urbanist,
      FontWeight fontWeight = FontWeight.bold,
      Color? color}) {
    return TextStyle(
        fontFamily: getFontFamily(fontFamily),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
              color: color ?? Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge?.color
        
        );
  }


   static TextStyle large(
      {double fontSize = 17,
      FontFamily fontFamily = FontFamily.urbanist,
      FontWeight fontWeight = FontWeight.bold,
      TextDecoration? decoration,
      Color? color}) {
    return TextStyle(
      decoration: decoration,
        fontFamily: getFontFamily(fontFamily),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
             color: color ?? Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge?.color
        
        );
  }
    static TextStyle normal(
      {double fontSize = 15,
      FontFamily fontFamily = FontFamily.urbanist,
      FontWeight fontWeight = FontWeight.bold,
      TextDecoration? decoration,
      Color? color}) {
    return TextStyle(
      decoration: decoration,
        fontFamily: getFontFamily(fontFamily),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color ?? Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge?.color
        
        );
  }
    static TextStyle medium(
      {double fontSize = 13,
      FontFamily fontFamily = FontFamily.urbanist,
      FontWeight fontWeight = FontWeight.normal,
           TextDecoration? decoration,
      Color? color}) {
    return TextStyle(
      
            decoration: decoration,
        fontFamily: getFontFamily(fontFamily),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      
       color: color ?? Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge?.color
        
        );
  }
    static TextStyle small(
      {double fontSize =12,
      FontFamily fontFamily = FontFamily.urbanist,
      FontWeight fontWeight = FontWeight.normal,
            TextDecoration? decoration,
      Color? color}) {
    return TextStyle(
            decoration: decoration,
        fontFamily: getFontFamily(fontFamily),
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
          color: color ??Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge?.color
        
        );
  }

  // //Heading
  // static TextStyle heading1({
  //   double fontSize = 30,
  //   FontFamily fontFamily = FontFamily.urbanist,
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

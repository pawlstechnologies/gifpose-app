import 'package:flutter/material.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
// import 'package:qost/utils/theme/qost_colors.dart';

import 'theme.dart';

class GiftPoseTheme {
  static ThemeData theme() {
    return ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
        }),
        fontFamily: getFontFamily(FontFamily.urbanist));
  }
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: GiftPoseColors.primaryColor,
    secondaryHeaderColor: GiftPoseColors.secondaryColor,
    hintColor: GiftPoseColors.hintText,
    scaffoldBackgroundColor: GiftPoseColors.background,
    dividerColor: GiftPoseColors.borderColor,
    textTheme:  TextTheme(
      bodyLarge: TextStyle(color: GiftPoseColors.textColor),
      bodyMedium: TextStyle(color: GiftPoseColors.textColor2),
      
    ),
    
    cardColor: GiftPoseColors.cardColor,
    // canvasColor:  GiftPoseColors.canvasColor,
    shadowColor: GiftPoseColors.containerBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: GiftPoseColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: GiftPoseColors.textColor),
    ),

  // other light theme settings
);

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: GiftPoseColors.primaryColor,
      dividerColor: GiftPoseColors.borderColor,
    // scaffoldBackgroundColor: GiftPoseColors.darkmodeBackground,
    hintColor: const Color(0xFFA1A2AE),
    
    // cardColor: GiftPoseColors.borderColorDark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: GiftPoseColors.lightBodyText),
      bodyMedium: TextStyle(color: GiftPoseColors.lightSubtitleTextColor),
    ),
    appBarTheme: const AppBarTheme(
      // backgroundColor: GiftPoseColors.darkmodeBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: GiftPoseColors.lightBodyText),
    ),
  // other dark theme settings
);
}

import 'package:flutter/material.dart';
import 'package:qost/utils/theme/qost_colors.dart';

import 'theme.dart';

class QostTheme {
  static ThemeData theme() {
    return ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
        }),
        fontFamily: getFontFamily(FontFamily.sfProDisplay));
  }
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: QostColors.primaryColor,
    secondaryHeaderColor: QostColors.secondaryColor,
    hintColor: QostColors.hintText,
    scaffoldBackgroundColor: QostColors.background,
    dividerColor: QostColors.softBorderColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: QostColors.textColor),
      bodyMedium: TextStyle(color: QostColors.subtitleTextColor),
    ),
    
    cardColor: QostColors.cardColor,
    canvasColor:  QostColors.canvasColor,
    shadowColor: QostColors.containerBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: QostColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: QostColors.textColor),
    ),

  // other light theme settings
);

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: QostColors.primaryColor,
      dividerColor: QostColors.softBorderColor,
    scaffoldBackgroundColor: QostColors.darkmodeBackground,
    hintColor: const Color(0xFFA1A2AE),
    cardColor: QostColors.borderColorDark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: QostColors.lightBodyText),
      bodyMedium: TextStyle(color: QostColors.lightSubtitleTextColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: QostColors.darkmodeBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: QostColors.lightBodyText),
    ),
  // other dark theme settings
);
}

import 'package:flutter/material.dart';
import 'package:giftpose/utils/theme_type.dart';
import 'package:provider/provider.dart';


extension ColorExtension on Color {
  Color withValues({int? red, int? green, int? blue, double? alpha}) {
    return Color.fromRGBO(
      red ?? this.red,
      green ?? this.green,
      blue ?? this.blue,
      alpha ?? this.opacity,
    );
  }
}

class GiftPoseColors {
  // Base colors - used as fallbacks and for static contexts
  static Color primaryColor = Color(0xFF3ACD27);

static Color greenColor = Color(0xFFCCFDC5);

  static Color containerBackground = Color(0xFFF6FFF5);
static Color dividerColorNew = Color(0x33EC5B13);


  static Color secondaryColor = Color(0xFF7FF270);
  
  static Color textColor = Color(0xFF0B051D);
  static Color textColor2 = Color(0xFF928F91);
    static Color textColor3 = Color(0xFF575252);
  
    static Color subtitleTextColor = Color(0xFF0B051D);
    static Color lightSubtitleTextColor = Color(0xADFFFFFF); // White with 68% opacity
  static Color linkColor = Color(0xFF4A4AF4);
  static Color softBorderColor = Color(0x284A4AF4);
  static Color softCardColor = Color(0x3D4A4AF4);
  static Color activeBorderColor = Color(0x3D4A4AF4);
  static Color inactiveBorderColor = Color(0x144A4AF4);
    static Color yelloColor = Color(0xFFFFFCF5);
  
  static Color dividerColor = Color(0xFFEDEDFE);
  static Color borderColor = Color(0xFFE2E2E2);
  static Color borderColor2 = Color(0xFFE7E8EB);
  static Color hintText = Color(0xA30B051D);
  static Color background = Color(0xFFFFFFFF);
  static Color errorColor = Color(0xFFFF3932);
  static Color borderColorLight = Color(0xFFF6FFF5);
  static Color cardColor =Color(0xFFFFFFFF);

  static Color lightBodyText = Colors.white;
  static Color green = Color(0xFF159D6F);
  
  
  // Theme-aware colors - these will change based on the current theme
  
  static Color getThemePrimaryColor() {
    // Same for both themes
    return primaryColor;
  }
  
  static Color getThemeSecondaryColor() {
    // Same for both themes
    return secondaryColor;
  }
  
  static Color getThemeLinkColor() {
    // Same for both themes
    return linkColor;
  }
  
  // static Color getThemeDividerColor() {
  //   final baseVM = Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   switch (baseVM.qostThemeMode) {
  //     case QostThemeMode.light:
  //       return dividerColor;
  //     case QostThemeMode.dark:
  //       return dividerColor.withValues(alpha: 0.3); // Adjust opacity for dark mode
  //     default:
  //       return dividerColor;
  //   }
  // }
  
  // static Color getThemeSoftBorderColor() {
  //   final baseVM = Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   switch (baseVM.qostThemeMode) {
  //     case QostThemeMode.light:
  //       return softBorderColor;
  //     case QostThemeMode.dark:
  //       return softBorderColor.withValues(alpha: 0.5); // More visible in dark mode
  //     default:
  //       return softBorderColor;
  //   }
  // }
  
  // static Color getThemeCardColor() {
  //   final baseVM = Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   switch (baseVM.qostThemeMode) {
  //     case QostThemeMode.light:
  //       return cardColor;
  //     case QostThemeMode.dark:
  //       return cardColor.withValues(alpha: 0.15); // More visible in dark mode
  //     default:
  //       return cardColor;
  //   }
  // }
  
  // static Color getThemeBackgroundColor() {
  //   final baseVM = Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   switch (baseVM.qostThemeMode) {
  //     case QostThemeMode.light:
  //       return background;
  //     case QostThemeMode.dark:
  //       return darkmodeBackground;
  //     default:
  //       return background;
  //   }
  // }
  // // Additional colors
  // static linearGradient = [Color(0xFF613EC8), Color(0xFF382473), Color(0xFF5B2EE0)];
  // static transparent = Color.fromARGB(0, 255, 255, 255);

  //  static Color getThemeColorBackground() {
  //   final baseVM =
  //       Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   switch (baseVM.qostThemeMode) {
  //     case QostThemeMode.light:
  //       return  Color(0xFFFEFEFE);
  //     case QostThemeMode.dark:
  //       return Color(0xFF05051D);

  //     default:
  //       return Color(0xFF151522);
  //   }
  // }


  //   static Color getThemeColorHeadingText() {
  //   final baseVM =
  //       Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   switch (baseVM.qostThemeMode) {
  //     case QostThemeMode.light:
  //       return Color(0xFF0B051D);
  //     case QostThemeMode.dark:
  //       return Color(0XFFFFFFFF);

  //     default:
  //       return Color(0xFF151522);
  //   }
  // }

  // static Color getThemeColorBodyText() {
  //   final baseVM =
  //       Provider.of<BaseViewmodel>(navigatorKey.currentContext!, listen: false);
  //   switch (baseVM.qostThemeMode) {
  //     case QostThemeMode.light:
  //       return Color(0xFF0B051D).withValues(alpha: 0.64);
  //     case QostThemeMode.dark:
  //       return Color(0XFFFFFFFF).withValues(alpha: 0.64);
  //     default:
  //       return Color(0xFF0B051D).withValues(alpha: 0.64);
  //   }
  // }



}

import 'package:flutter/material.dart';
import 'package:giftpose/screens/main_view/views/settings_page/help_center.dart';
import 'package:giftpose/screens/main_view/views/settings_page/language_view.dart';
import 'package:giftpose/utils/localization_provider.dart';


import 'package:giftpose/screens/main_view/views/dashboard_view.dart';
import 'package:giftpose/screens/main_view/views/notification_alert.dart';
import 'package:giftpose/screens/main_view/views/notification_view.dart';
import 'package:giftpose/screens/main_view/views/settings_view.dart';
import 'package:giftpose/screens/onboarding/views/consent_view.dart';
import 'package:giftpose/screens/onboarding/views/onboarding_view.dart';
import 'package:giftpose/screens/onboarding/views/postcode_view.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/widgets/loader_page.dart';



class Routers {
  static Route<dynamic> generateRoute(
      RouteSettings settings, BuildContext context) {
    Widget routeWidget;
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        routeWidget = SplashScreen();
        break;
      case AppRoutes.consentPage:
        routeWidget = ConsentScreen();
        break;
      case AppRoutes.postcodePage:
        routeWidget = PostcodeScreen();
        break;
            case AppRoutes.notificationsPage:
        routeWidget = NotificationView();
        break;
               case AppRoutes.notificationsAlert:
        routeWidget = NotificationAlert();
        break;
            case AppRoutes.settingsPage:
        routeWidget =  SettingsView();
        break;
            case AppRoutes.dashboard:
        routeWidget =  DashboardView();
        break;

            case AppRoutes.languagePage:
        routeWidget = LanguageView();
        break;
                case AppRoutes.helpCenter:
        routeWidget = HelpCenter();
        break;
        
    
                         case AppRoutes.settingsPage:
        routeWidget = SettingsView();
        break;

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'.tr(context)),
            ),
          ),
        );
    }

    return _createRoute(child: routeWidget, settings: settings);
  }

  static Route _createRoute({required Widget child, RouteSettings? settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}



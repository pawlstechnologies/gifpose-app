import 'package:flutter/material.dart';
import 'package:giftpose/screens/main_view/views/dashboard_view.dart';
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
        routeWidget = const SplashScreen();
        break;
      case AppRoutes.consentPage:
        routeWidget = const ConsentScreen();
        break;
      case AppRoutes.postcodePage:
        routeWidget = const PostcodeScreen();
        break;
            case AppRoutes.notificationsPage:
        routeWidget = const NotificationView();
        break;
            case AppRoutes.settingsPage:
        routeWidget =  SettingsView();
        break;
            case AppRoutes.dashboard:
        routeWidget =  DashboardView();
        break;
             case AppRoutes.loaderPage:
        routeWidget = const LoaderPage();
        break;
                 case AppRoutes.notificationsPage:
        routeWidget = NotificationView();
        break;
                         case AppRoutes.settingsPage:
        routeWidget = SettingsView();
        break;

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
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
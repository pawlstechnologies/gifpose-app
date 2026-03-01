import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/main_view/viewmodels/connectivit_viewmode.dart';
import 'package:giftpose/screens/onboarding/views/onboarding_view.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart';
import 'package:giftpose/services/secure_storage/sp_database_manager.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/router/router.dart';
import 'package:giftpose/utils/theme/theme.dart';

import 'package:provider/provider.dart';




final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
class GifteposeApp extends StatefulWidget {
  const GifteposeApp({super.key});

  @override
  State<GifteposeApp> createState() => _GifteposeAppState();
}

class _GifteposeAppState extends State<GifteposeApp> {
  Timer? _rootTimer;
@override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  final SecureStorageService secureStorageService =
      serviceLocator<SecureStorageService>();
  final SpDatabaseManager spDatabaseManager = SpDatabaseManager();

  void initializeTimer() async {
    final manager = await spDatabaseManager.getTimeoutManager() ?? false;
    _rootTimer?.cancel();
    _rootTimer = Timer(
      manager ? const Duration(minutes: 20) : const Duration(days: 100),
      () {
        // Handle timeout
      },
    );
  }

  void _handleUserInteraction([_]) {
    if (_rootTimer != null && !_rootTimer!.isActive) return;
    _rootTimer?.cancel();
    initializeTimer();
  }

  void updateTimeoutManager() async {
    await spDatabaseManager.saveTimeoutManager(manager: false);
  }

  // Future<void> determineTheMode() async {
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     final baseVM = Provider.of<BaseViewmodel>(context, listen: false);
  //     baseVM.loadTheCurrentDisplayMode();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers:[
  ChangeNotifierProvider(
            create: (context) => BaseViewmodel(),
          ),
  //         ChangeNotifierProvider(
  //           create: (context) => ExploreViewModel(),
  //         ),
  //            ChangeNotifierProvider(
  //           create: (context) => OrdersViewModel(),
  //         ),
  //           ChangeNotifierProvider(
  //             create: (context) => AuthViewModel(),
  //           ),
  //           ChangeNotifierProvider(
  //             create: (context) => ProfileViewModel(),
  //           ),
  //           ChangeNotifierProvider(
  //             create: (context) => WalletViewmodel(),
  //           ),
      
 
],

      child: GestureDetector(
        onTap: _handleUserInteraction,
        onPanDown: _handleUserInteraction,
        onScaleStart: _handleUserInteraction,
        behavior: HitTestBehavior.deferToChild,
        child: ScreenUtilInit(
          designSize: const Size(375, 874),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return AdaptiveTheme(
              light: GiftPoseTheme().lightTheme,
              dark: GiftPoseTheme().darkTheme,
              initial: AdaptiveThemeMode.system,
      builder: (ThemeData light, ThemeData dark) {
                return MaterialApp(
                  title: 'Qost Mobile',
                  debugShowCheckedModeBanner: false,
                  scaffoldMessengerKey: rootScaffoldMessengerKey,
                  navigatorKey: navigatorKey,
              //    theme: light,
        theme:GiftPoseTheme().lightTheme,
                      darkTheme:GiftPoseTheme().darkTheme,
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: ChangeNotifierProvider(
                        create: (context) => ConnectivityProvider(context),
                        lazy: false,
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: child!,
                        ),
                      ),
                    );
                  },
                  onGenerateRoute: (settings) =>
                      Routers.generateRoute(settings, context),
                  home: const SplashScreen(),
                );
              }
            );
          },
        ),
      ),
    );
  }
}
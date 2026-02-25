// import 'package:flutter/material.dart';
// import 'package:qost/screens/authentication/views/registration/basic_profile_setup_screen.dart';
// import 'package:qost/screens/authentication/views/registration/create_password_screen.dart';
// import 'package:qost/screens/authentication/views/registration/otp_screen.dart';
// import 'package:qost/screens/authentication/views/registration/registration_screen.dart';
// import 'package:qost/screens/authentication/views/sign_in/create_new_password_screen.dart';
// import 'package:qost/screens/authentication/views/sign_in/enter_otp_screen.dart';
// import 'package:qost/screens/authentication/views/sign_in/forgot_password_screen.dart';
// import 'package:qost/screens/authentication/views/sign_in/sigin_in_screen.dart';
// import 'package:qost/screens/explore/views/explore_screen.dart';
// import 'package:qost/screens/explore/views/product_details.dart';
// import 'package:qost/screens/explore/views/search_screen.dart';
// import 'package:qost/screens/explore/widgets/payment_successful_screen.dart';
// import 'package:qost/screens/main/views/main_screen.dart';
// import 'package:qost/screens/onboarding/views/onboarding_screen.dart';
// import 'package:qost/screens/onboarding/views/splash_screen.dart';

// import 'package:qost/screens/orders/views/orders_view.dart';
// import 'package:qost/screens/profile/views/bank_accounts_view.dart';
// import 'package:qost/screens/profile/views/card_view.dart';
// import 'package:qost/screens/profile/views/delivery_address_view.dart';
// import 'package:qost/screens/profile/views/personal_details_screen.dart';
// import 'package:qost/screens/profile/views/profile_screen.dart';
// import 'package:qost/screens/wallet/views/wallet_screen.dart';
// import 'package:qost/utils/router/app_routes.dart';


// class Routers {
//   static Route<dynamic> generateRoute(
//       RouteSettings settings, BuildContext context) {
//     Widget routeWidget;
//     final args = settings.arguments;

//     switch (settings.name) {
//       case AppRoutes.splash:
//         routeWidget = const SplashScreen();
//         break;
//       case AppRoutes.onboard:
//         routeWidget = const OnboardingScreen();
//         break;
//       case AppRoutes.mainScreen:
//         routeWidget = const MainScreen();
//         break;
//       case AppRoutes.registration:
//         routeWidget =  RegistrationScreen();
//         break;
//       case AppRoutes.otpScreen:
//         routeWidget =  OtpScreen();
//         break;
//       case AppRoutes.createPasswordScreen:
//         routeWidget =  CreatePasswordScreen();
//         break;
//       case AppRoutes.basicProfileSetupScreen:
//         routeWidget =  BasicProfileSetupScreen();
//         break;
//       case AppRoutes.signinScreen:
//         routeWidget =  SiginInScreen();
//         break;
//       case AppRoutes.forgotPasswordScreen:
//         routeWidget =  ForgotPasswordScreen();
//         break;
      
//       case AppRoutes.enterOtpScreen:
//         routeWidget =  EnterOtpScreen();
//         break;
//       case AppRoutes.createNewPasswordScreen:
//         routeWidget =  CreateNewPasswordScreen();
//         break;
//       case AppRoutes.exploreScreen:
//         routeWidget =  ExploreScreen();
//         break;
//       case AppRoutes.ordersScreen:
//         routeWidget =  OrdersScreen();
//         break;
//       case AppRoutes.walletScreen:
//         routeWidget =  WalletScreen();
//         break;
//       case AppRoutes.profileScreen:
//         routeWidget =  ProfileScreen();
//         break;
//       case AppRoutes.searchScreen:
//         routeWidget =  SearchScreen();
//         break;
//       case AppRoutes.paymentSuccessful:
//         final Map<String, dynamic> routeArgs = args as Map<String, dynamic>? ?? {};
//         routeWidget = PaymentSuccessfulScreen(
//           amount: routeArgs['amount'] ?? '',
//           productName: routeArgs['productName'] ?? '',
//         );
//         break;
//       case AppRoutes.personalDetailsScreen:
//         routeWidget =  PersonalDetailsScreen();
//         break;
//       case AppRoutes.deliveryAddressScreen:
//         routeWidget =  DeliveryAddressScreen();
//         break;
//       case AppRoutes.cardViewScreen:
//         routeWidget =  CardViewScreen();
//         break;
//       case AppRoutes.bankAccountScreen: 
//         routeWidget =  BankAccountScreen();
//         break;
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }

//     return _createRoute(child: routeWidget, settings: settings);
//   }

//   static Route _createRoute({required Widget child, RouteSettings? settings}) {
//     return PageRouteBuilder(
//       settings: settings,
//       pageBuilder: (context, animation, secondaryAnimation) => child,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//     );
//   }
// }
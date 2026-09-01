import 'package:flutter/material.dart';
import 'package:giftpose/screens/main_view/views/settings_page/about_page.dart';
import 'package:giftpose/screens/authentication/view/create_account.dart';
import 'package:giftpose/screens/authentication/view/enter_otp.dart';
import 'package:giftpose/screens/authentication/view/forgot_password_view.dart';
import 'package:giftpose/screens/authentication/view/password_changed.dart';
import 'package:giftpose/screens/authentication/view/reset_password_view.dart';
import 'package:giftpose/screens/authentication/view/sigin_in_view.dart';
import 'package:giftpose/screens/authentication/view/verify_email.dart';
import 'package:giftpose/screens/main_view/views/settings_page/help_center.dart';
import 'package:giftpose/screens/main_view/views/settings_page/language_view.dart';
import 'package:giftpose/screens/main_view/views/settings_page/premium_page.dart';
import 'package:giftpose/screens/main_view/views/settings_page/delete_account_page.dart';
import 'package:giftpose/screens/main_view/views/settings_page/billing_history_page.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/screens/main_view/views/dashboard_view.dart';
import 'package:giftpose/screens/main_view/views/notification_alert.dart';
import 'package:giftpose/screens/main_view/views/notification_view.dart';
import 'package:giftpose/screens/main_view/views/settings_view.dart';
import 'package:giftpose/screens/onboarding/views/consent_view.dart';
import 'package:giftpose/screens/onboarding/views/onboarding_view.dart';
import 'package:giftpose/screens/onboarding/views/postcode_view.dart';
import 'package:giftpose/screens/requester_flow/views/post_an_item.dart';
import 'package:giftpose/screens/requester_flow/views/request_posted_successfully.dart';
import 'package:giftpose/screens/requester_flow/views/request_item_details.dart';
import 'package:giftpose/screens/requester_flow/views/request_offers.dart';
import 'package:giftpose/screens/donor_flow/views/donor_chat.dart';
import 'package:giftpose/screens/donor_flow/views/donor_edit_category.dart';
import 'package:giftpose/screens/donor_flow/views/donor_edit_location.dart';
import 'package:giftpose/screens/donor_flow/views/donor_item_details.dart';
import 'package:giftpose/screens/donor_flow/views/donor_post_item.dart';
import 'package:giftpose/screens/donor_flow/views/donor_success.dart';
import 'package:giftpose/screens/donor_flow/views/donor_delivery_status.dart';
import 'package:giftpose/screens/donor_flow/views/interested_users.dart';
import 'package:giftpose/screens/donor_flow/views/my_donations.dart';
import 'package:giftpose/screens/donor_flow/views/requested_gift_details.dart';
import 'package:giftpose/utils/router/app_routes.dart';

class Routers {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
    BuildContext context,
  ) {
    Widget routeWidget;
    switch (settings.name) {
      case AppRoutes.splash:
        routeWidget = SplashScreen();
        break;
      case AppRoutes.consentPage:
        routeWidget = ConsentScreen();
        break;
      case AppRoutes.premiumSubscription:
        routeWidget = PremiumSubscriptionView();
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
        routeWidget = SettingsView();
        break;
      case AppRoutes.deleteAccountPage:
        routeWidget = const DeleteAccountPage();
        break;
      case AppRoutes.requestItem:
        routeWidget = const PostAnItemScreen();
        break;
      case AppRoutes.requestPosted:
        routeWidget = const RequestPostedSuccessfullyScreen();
        break;
      case AppRoutes.requestItemDetails:
        routeWidget = const RequestItemDetailsScreen();
        break;
      case AppRoutes.editRequestItem:
        routeWidget = const PostAnItemScreen(isEditing: true);
        break;
      case AppRoutes.requestOffers:
        routeWidget = const RequestOffersScreen();
        break;
      case AppRoutes.donorPostItem:
        routeWidget = const DonorPostItemScreen();
        break;
      case AppRoutes.donorPage:
        routeWidget = const DonorPostItemScreen();
        break;
      case AppRoutes.donorPostedSuccess:
        routeWidget = const DonorSuccessScreen();
        break;
      case AppRoutes.donorEditCategory:
        routeWidget = const DonorEditCategoryScreen();
        break;
      case AppRoutes.donorEditLocation:
        routeWidget = const DonorEditLocationScreen();
        break;
      case AppRoutes.donorMyDonations:
        routeWidget = const MyDonationsScreen();
        break;
      case AppRoutes.donorItemDetails:
        routeWidget = const DonorItemDetailsScreen();
        break;
      case AppRoutes.donorInterestedUsers:
        routeWidget = const InterestedUsersScreen();
        break;
      case AppRoutes.donorChat:
        routeWidget = const DonorChatScreen();
        break;
      case AppRoutes.donorRequestedGiftDetails:
        routeWidget = const RequestedGiftDetailsScreen();
        break;
      case AppRoutes.donorOfferItem:
        routeWidget = const DonorPostItemScreen(offeringRequestedItem: true);
        break;
      case AppRoutes.donorOfferSuccess:
        routeWidget = const DonorSuccessScreen(offer: true);
        break;
      case AppRoutes.donorDeliveryStatus:
        routeWidget = const DonorDeliveryStatusScreen();
        break;
      case AppRoutes.dashboard:
        routeWidget = DashboardView();
        break;
      case AppRoutes.createAccountPage:
        routeWidget = CreateAccountScreen();
        break;
      case AppRoutes.siginInPage:
        routeWidget = SigininScreen();
        break;

      case AppRoutes.verifyEmailScreen:
        routeWidget = VerifyEmailScreen();
        break;
      case AppRoutes.forgotPasswordScreen:
        routeWidget = ForgotPasswordScreen();
        break;
      case AppRoutes.passwordChanged:
        routeWidget = PasswordChangedScreen();
        break;
      case AppRoutes.resetPasswordScreen:
        routeWidget = ResetPasswordScreen();
        break;
      case AppRoutes.enterOtpScreen:
        routeWidget = EnterOtpScreen();
        break;
      case AppRoutes.languagePage:
        routeWidget = LanguageView();
        break;
      case AppRoutes.helpCenter:
        routeWidget = HelpCenter();
        break;
      case AppRoutes.billingHistory:
        routeWidget = const BillingHistoryPage();
        break;

      case AppRoutes.aboutPage:
        routeWidget = AboutPage();
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
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

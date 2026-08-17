import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:provider/provider.dart';
import 'package:giftpose/utils/network_data_response.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/screens/main_view/widgets/change_plan_modal.dart';


class PremiumSubscriptionView extends StatefulWidget {
  const PremiumSubscriptionView({super.key});

  @override
  State<PremiumSubscriptionView> createState() =>
      _PremiumSubscriptionViewState();
}

class _PremiumSubscriptionViewState extends State<PremiumSubscriptionView> {
  bool isYearlySelected = true;
  bool _isAgreedToTerms = false;
  bool _isTermsExpanded = true;
  bool _showLoginPrompt = false;
  bool _showNoHistoryPrompt = false;
  bool _showPaymentFailed = false;
  int _subscribeAttempts = 0;
  bool _showCancelPlanPage = false;
  final TextEditingController _cancelReasonController = TextEditingController();
  String? _cancelReasonError;

  Future<void> _launchTermsUrl() async {
    final Uri url = Uri.parse('https://giftpose.com/terms-of-use');
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        await launchUrl(url);
      }
    } catch (e) {
      print("Could not launch $url: $e");
    }
  }

  @override
  void dispose() {
    _cancelReasonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<DashboardViewmodel>(context, listen: false);
      viewModel.fetchSubscriptionList();
      viewModel.fetchCurrentSubscription();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, viewModel, child) {
        final isLoggedIn = viewModel.currentUser?.user?.email != null &&
            viewModel.currentUser!.user!.email.isNotEmpty;

        return GiftPoseBaseScaffold(
          showAppBar: false,
          includeVerticalPadding: false,
          includeHorizontalPadding: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (size) {
            return SafeArea(
              child: Builder(
                builder: (context) {
                  if (_showCancelPlanPage) {
                    return _buildCancelPlanView(context, viewModel);
                  }
                  if (_showPaymentFailed) {
                    return _buildPaymentFailedView(context, viewModel);
                  }
                  if (_showNoHistoryPrompt) {
                    return _buildNoHistoryPromptView(context, viewModel);
                  }
                  if (_showLoginPrompt) {
                    return _buildLoginPromptView(context, viewModel);
                  }
                  if (viewModel.isSubscribed || viewModel.isSubscriptionCancelled) {
                    if (!isLoggedIn) {
                      return _buildLoginPromptView(context, viewModel);
                    }
                    return _buildSubscriptionDetailsView(context, viewModel);
                  }
                  return _buildSubscribeView(context, viewModel);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoginPromptView(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showLoginPrompt = false;
                  });
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF1F1),
                    shape: BoxShape.circle,
                  ),
                  child:  Center(
                    child: InkWell(
                      onTap: (){
                          Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Please login to view your subscription status",
                  textAlign: TextAlign.center,
                  style: GiftPoseTextStyle.medium(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                GiftPoseButton(
                  title: "Login",
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.pushNamed(context, AppRoutes.siginInPage).then((_) {
                      final isLoggedIn = viewModel.currentUser?.user?.email != null &&
                          viewModel.currentUser!.user!.email.isNotEmpty;
                      if (isLoggedIn) {
                        setState(() {
                          _showLoginPrompt = false;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate(String? rawDate) {
    if (rawDate == null || rawDate.trim().isEmpty) return "";
    try {
      final parsed = DateTime.tryParse(rawDate);
      if (parsed != null) {
        return DateFormat("MMM dd, yyyy").format(parsed);
      }
    } catch (_) {}
    return rawDate;
  }

  void _handleViewHistory(BuildContext context, DashboardViewmodel viewModel) {
    final isLoggedIn = viewModel.currentUser?.user?.email != null &&
        viewModel.currentUser!.user!.email.isNotEmpty;
    if (!isLoggedIn) {
      setState(() {
        _showLoginPrompt = true;
      });
      return;
    }

    final hasListItems = viewModel.subscriptionListResponse?.data != null &&
        viewModel.subscriptionListResponse!.data!.isNotEmpty;
    final hasCurrentSub = viewModel.currentSubscriptionResponse?.data != null;

    if (hasListItems || hasCurrentSub) {
      Navigator.pushNamed(context, AppRoutes.billingHistory);
    } else {
      setState(() {
        _showNoHistoryPrompt = true;
      });
    }
  }

  void _handleSubscribe(DashboardViewmodel viewModel) {
    HapticFeedback.heavyImpact();
    final isLoggedIn = viewModel.currentUser?.user?.email != null &&
        viewModel.currentUser!.user!.email.isNotEmpty;

    if (!isLoggedIn) {
      Navigator.pushNamed(context, AppRoutes.siginInPage);
      return;
    }

    if (viewModel.activeTestCase == "B") {
      if (_subscribeAttempts == 0) {
        setState(() {
          _subscribeAttempts++;
          _showPaymentFailed = true;
        });
      } else {
        setState(() {
          _subscribeAttempts = 0;
        });
        viewModel.createSubscription(plan: isYearlySelected ? "annual" : "monthly");
      }
    } else {
      viewModel.createSubscription(plan: isYearlySelected ? "annual" : "monthly");
    }
  }

  Widget _buildNoHistoryPromptView(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showNoHistoryPrompt = false;
                  });
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF1F1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Uh-oh! You have no subscription history on this account",
                  textAlign: TextAlign.center,
                  style: GiftPoseTextStyle.medium(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                GiftPoseButton(
                  title: "Go back",
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    setState(() {
                      _showNoHistoryPrompt = false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentFailedView(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Payment Failed",
              style: GiftPoseTextStyle.large(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "We couldn't complete your transaction. Please check your payment details or try again.",
              textAlign: TextAlign.center,
              style: GiftPoseTextStyle.small(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            GiftPoseButton(
              title: "Try again.",
              onTap: () {
                HapticFeedback.heavyImpact();
                setState(() {
                  _showPaymentFailed = false;
                });
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                HapticFeedback.heavyImpact();
                setState(() {
                  _showPaymentFailed = false;
                });
                Navigator.pop(context);
              },
              child: Text(
                "Go to home page",
                style: GiftPoseTextStyle.medium(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscribeView(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    return Column(
      children: [
        // HEADER
        SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Assets.icons.back.svg(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),
              Text(
                "Premium Subscription",
                style: GiftPoseTextStyle.medium(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'history') {
                    _handleViewHistory(context, viewModel);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'history',
                    child: Text("View History"),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 15),

              /// PREMIUM IMAGE
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xff39D11F),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Assets.images.paymentImage.image(
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ),

                    Positioned(
                      top: -6,
                      right: -10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffF56D8A),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "AD FREE",
                          style: GiftPoseTextStyle.small(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// FEATURES
              _featureItem(
                context,
                icon: Assets.icons.adfree.svg(),
                title: "Ad-Free Browsing",
                subtitle:
                    "Remove all banners and pop-ups for a cleaner experience while browsing or listing.",
              ),

              _featureItem(
                context,
                icon: Assets.icons.supporter.svg(),
                title: "Supporter Badge",
                subtitle:
                    "A unique badge on your profile to show you're a dedicated community member.",
              ),

              _featureItem(
                context,
                icon: Assets.icons.premiumSvg.svg(),
                title: "Premium Support",
                subtitle:
                    "Enjoy fast, reliable support with priority access to our team whenever you need help.",
              ),

              _featureItem(
                context,
                icon: Assets.icons.unlimited.svg(),
                title: "Unlimited Smart Notification",
                subtitle:
                    "Choose how and when you get notified about your gift.",
              ),

              _featureItem(
                context,
                icon: Assets.icons.featured.svg(),
                title: "Featured Listings (coming soon)",
                subtitle:
                    "Give your items more visibility so they find a new home faster.",
              ),

              const SizedBox(height: 20),

              /// PLANS
              Row(
                children: [
                  Expanded(
                    child: _planCard(
                      selected: !isYearlySelected,
                      duration: "1 Month",
                      monthlyText: "£0.99/mo",
                      price: "£0.99",
                      onTap: () {
                        setState(() {
                          isYearlySelected = false;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _planCard(
                      selected: isYearlySelected,
                      duration: "12 Months",
                      oldPrice: "£11.99",
                      savings: "Save £1.99",
                      badge: "🔥 16% OFF",
                      price: "£9.99",
                      onTap: () {
                        setState(() {
                          isYearlySelected = true;
                        });
                      },
                    ),
                  ),
                ],
              ),

              /// TERMS DISCLAIMER & AGREEMENT
              _buildTermsDisclaimerWidget(context),

              const SizedBox(height: 15),
            ],
          ),
        ),

        /// SUBSCRIBE BUTTON
        GiftPoseButton(
          title: "Subscribe",
          isLoading: viewModel.createPaymentIntentResponse.status == Status.LOADING,
          backgroundColor: _isAgreedToTerms
              ? null
              : (Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade300),
          textColor: _isAgreedToTerms
              ? null
              : (Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade600
                  : Colors.grey.shade500),
          onTap: () {
            if (_isAgreedToTerms) {
              _handleSubscribe(viewModel);
            }
          },
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSubscriptionDetailsView(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    final bool isMonthly = viewModel.currentSubscriptionPlan == "monthly";
    final priceStr = isMonthly ? "£0.99 /month" : "£9.99 /year";
    final planBillingText = isMonthly ? "Billed Monthly" : "Billed Yearly";
    final priceLabel = isMonthly ? "£0.99" : "£9.99";

    return Column(
      children: [
        // HEADER
        SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Assets.icons.back.svg(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),
              Text(
                "Subscription Details".tr(context),
                style: GiftPoseTextStyle.medium(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              if (!viewModel.isSubscriptionCancelled)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'cancel') {
                      _showCancelConfirmationDialog(context, viewModel);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'cancel',
                      child: Text(
                        "Cancel Subscription".tr(context, listen: false),
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                )
              else
                const SizedBox(width: 40),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              if (viewModel.isSubscriptionCancelled) ...[
                // Canceled Subscription Card
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade100, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF1F1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.event_busy,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Subscription Cancelled".tr(context),
                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final rawNextDate = viewModel.currentSubscriptionResponse?.data?.currentPeriodEnd ??
                              viewModel.subscriptionListResponse?.data?.firstOrNull?.nextBillingDate;
                          var formattedDate = _getFormattedDate(rawNextDate);
                          if (formattedDate.isEmpty) {
                            formattedDate = DateFormat("MMM dd, yyyy").format(
                              DateTime.now().add(const Duration(days: 30)),
                            );
                          }
                          return Text(
                            "You are currently subscribed till $formattedDate but you will not be charged".tr(context),
                            textAlign: TextAlign.center,
                            style: GiftPoseTextStyle.small(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(160, 44),
                          side: const BorderSide(color: Color(0xff39D11F), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          setState(() {
                            viewModel.isSubscriptionCancelled = false;
                          });
                        },
                        child: Text(
                          "Subscribe Again".tr(context),
                          style: GiftPoseTextStyle.medium(
                            color: const Color(0xff39D11F),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Premium Plan Card (Active)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade200,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFF3D2C1D)
                                  : const Color(0xFFFFF1F1),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.diamond_outlined,
                                color: Color(0xFFC77C2A),
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Premium Plan".tr(context),
                                style: GiftPoseTextStyle.medium(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                              Text(
                                planBillingText.tr(context),
                                style: GiftPoseTextStyle.small(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Divider(
                          height: 1,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.grey.shade200,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price".tr(context),
                                style: GiftPoseTextStyle.small(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                priceStr,
                                style: GiftPoseTextStyle.medium(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Next Billing".tr(context),
                                style: GiftPoseTextStyle.small(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getFormattedDate(
                                  viewModel.currentSubscriptionResponse?.data?.currentPeriodEnd,
                                ),
                                style: GiftPoseTextStyle.medium(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Auto-renew bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.08)
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? const Color(0xFF1B382B)
                                        : const Color(0xffE6F4EA),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.sync,
                                      color: Color(0xff39D11F),
                                      size: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "AUTO-RENEW".tr(context),
                                      style: GiftPoseTextStyle.small(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "Enabled".tr(context),
                                      style: GiftPoseTextStyle.medium(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Theme.of(context).textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Switch(
                              value: true,
                              activeThumbColor: const Color(0xff39D11F),
                              onChanged: (val) {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (!viewModel.isSubscriptionCancelled) ...[
                const SizedBox(height: 16),

                // Change Plan & Help tiles
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          title: Text(
                            "Change Plan".tr(context),
                            style: GiftPoseTextStyle.medium(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                          trailing: Assets.icons.foward.svg(
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            _showChangePlanDialog(context, viewModel);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.grey.shade100,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.cancel_outlined,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          title: Text(
                            "Need help?".tr(context),
                            style: GiftPoseTextStyle.medium(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                          trailing: Assets.icons.foward.svg(
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(context, AppRoutes.helpCenter);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Billing History header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Billing History".tr(context),
                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.pushNamed(context, AppRoutes.billingHistory);
                    },
                    child: Text(
                      "View All".tr(context),
                      style: GiftPoseTextStyle.small(
                        color: const Color(0xff39D11F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Billing History item card
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.grey.shade200,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.08)
                                : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.grey.shade100,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "OCT",
                                style: GiftPoseTextStyle.small(
                                  fontSize: 10,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "24",
                                style: GiftPoseTextStyle.medium(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Premium Plan".tr(context),
                              style: GiftPoseTextStyle.medium(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              "$priceLabel/year",
                              style: GiftPoseTextStyle.small(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Benefits header
              Text(
                "Benefits".tr(context),
                style: GiftPoseTextStyle.medium(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 12),

              // Benefits items
              _featureItem(
                context,
                icon: Assets.icons.adfree.svg(),
                title: "Ad-Free Browsing".tr(context),
                subtitle:
                    "Remove all banners and pop-ups for a cleaner experience while browsing or listing.".tr(context),
              ),
              _featureItem(
                context,
                icon: Assets.icons.supporter.svg(),
                title: "Supporter Badge".tr(context),
                subtitle:
                    "A unique badge on your profile to show you're a dedicated community member.".tr(context),
              ),
              _featureItem(
                context,
                icon: Assets.icons.premiumSvg.svg(),
                title: "Premium Support".tr(context),
                subtitle:
                    "Enjoy fast, reliable support with priority access to our team whenever you need help.".tr(context),
              ),
              _featureItem(
                context,
                icon: Assets.icons.unlimited.svg(),
                title: "Unlimited Smart Notification".tr(context),
                subtitle:
                    "Choose how and when you get notified about your gift.".tr(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showChangePlanDialog(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    ChangePlanModal.show(context, viewModel);
  }

  void _showCancelConfirmationDialog(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).cardColor,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF1F1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Are you sure you want to Cancel your Subscription",
                    textAlign: TextAlign.center,
                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GiftPoseButton(
                    title: "Yes, Cancel",
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.pop(ctx); // Close confirmation dialog
                      setState(() {
                        _showCancelPlanPage = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      "No, Dont Cancel",
                      style: GiftPoseTextStyle.medium(
             
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancellationSuccessDialog(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).cardColor,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(ctx);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    "Your Subscription has been cancelled",
                    textAlign: TextAlign.center,
                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  GiftPoseButton(
                    title: "Close",
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsDisclaimerWidget(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final planRenewPeriod = isYearlySelected ? "YEARLY" : "MONTHLY";

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                _isAgreedToTerms = !_isAgreedToTerms;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _isAgreedToTerms ? const Color(0xff39D11F) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: _isAgreedToTerms
                      ? const Color(0xff39D11F)
                      : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                  width: 1.5,
                ),
              ),
              child: _isAgreedToTerms
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                            height: 1.35,
                          ),
                          children: [
                            const TextSpan(
                              text: "By subscribing, you request to start your service immediately ",
                            ),
                            const TextSpan(
                              text: "* ",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: "and acknowledge that you've read and agree to the Terms of Use (",
                            ),
                            TextSpan(
                              text: "https://giftpose.com/terms-of-use",
                              style: const TextStyle(
                                color: Color(0xff39D11F),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _launchTermsUrl,
                            ),
                            const TextSpan(
                              text: "). You authorise us to charge your designated payment method, or another on file inclusive of taxes.",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isTermsExpanded = !_isTermsExpanded;
                        });
                      },
                      child: Icon(
                        _isTermsExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                if (_isTermsExpanded) ...[
                  const SizedBox(height: 12),
                  Text(
                    "Also YOUR GiftPose SUBSCRIPTION RENEWS $planRenewPeriod UNTIL CANCELLED. YOU CAN CANCEL YOUR SUBSCRIPTION FROM THE SUBSCRIPTION DETAILS PAGE.",
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You may cancel your subscription within the anytime, but you will remain subscribed till the subscription expiry date.",
                    style: TextStyle(
                      fontSize: 10.5,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We'll notify you in advance if the price changes. Your Giftpose subscription is sold by Pawl Technologies LTD.",
                    style: TextStyle(
                      fontSize: 10.5,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureItem(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GiftPoseTextStyle.medium(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GiftPoseTextStyle.small(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _planCard({
    required bool selected,
    required String duration,
    required String price,
    String? oldPrice,
    String? savings,
    String? badge,
    String? monthlyText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? const Color(0xff39D11F) : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.03), blurRadius: 15),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (badge != null)
              Positioned(
                top: -14,
                left: 30,
                right: 30,
                child: Container(
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xff39D11F) : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    badge,
                    style: GiftPoseTextStyle.small(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      duration,
                      style: GiftPoseTextStyle.medium(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (oldPrice != null)
                      Text(
                        oldPrice,
                        style: GiftPoseTextStyle.small(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                    if (savings != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          savings,
                          style: GiftPoseTextStyle.small(
                            color: const Color(0xffC77C2A),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    const SizedBox(height: 6),

                    Text(
                      price,
                      style: GiftPoseTextStyle.large(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),

                    if (monthlyText != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        monthlyText,
                        style: GiftPoseTextStyle.small(color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelPlanView(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    final periodEndDate = _getFormattedDate(
      viewModel.currentSubscriptionResponse?.data?.currentPeriodEnd,
    );

    return Column(
      children: [
        // Header
        SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  setState(() {
                    _showCancelPlanPage = false;
                    _cancelReasonError = null;
                  });
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Assets.icons.back.svg(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "Cancel Plan".tr(context),
                style: GiftPoseTextStyle.medium(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              Text(
                "We're sorry to see you  go".tr(context),
                style: GiftPoseTextStyle.large(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: GiftPoseTextStyle.small(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: "You'll keep your benefits until the end of your current period on ".tr(context),
                    ),
                    TextSpan(
                      text: periodEndDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const TextSpan(text: "."),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                "Why are you cancelling".tr(context),
                style: GiftPoseTextStyle.small(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _cancelReasonError != null
                        ? Colors.redAccent
                        : (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.15)
                            : Colors.grey.shade300),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  controller: _cancelReasonController,
                  maxLines: 4,
                  style: GiftPoseTextStyle.medium(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 14,
                  ),
                  onChanged: (val) {
                    if (_cancelReasonError != null && val.trim().isNotEmpty) {
                      setState(() {
                        _cancelReasonError = null;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your reason".tr(context),
                    hintStyle: GiftPoseTextStyle.small(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              if (_cancelReasonError != null) ...[
                const SizedBox(height: 6),
                Text(
                  _cancelReasonError!,
                  style: GiftPoseTextStyle.small(
                    color: Colors.redAccent,
                    fontSize: 12,
                  ),
                ),
              ],

              const SizedBox(height: 28),

              Text(
                "Benefits you will lose access to".tr(context),
                style: GiftPoseTextStyle.medium(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 16),

              _cancelBenefitItem(context, "Ad-Free Browsing".tr(context)),
              _cancelBenefitItem(context, "Supporter Badge".tr(context)),
              _cancelBenefitItem(context, "Premium Support".tr(context)),
              _cancelBenefitItem(context, "Unlimited Smart Notification".tr(context)),
              _cancelBenefitItem(context, "Featured Listings (coming soon)".tr(context)),

              const SizedBox(height: 32),

              GiftPoseButton(
                title: "Keep my Plan".tr(context),
                onTap: () {
                  HapticFeedback.heavyImpact();
                  setState(() {
                    _showCancelPlanPage = false;
                    _cancelReasonController.clear();
                    _cancelReasonError = null;
                  });
                },
              ),

              const SizedBox(height: 12),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.grey.shade300,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  HapticFeedback.heavyImpact();
                  if (_cancelReasonController.text.trim().isEmpty) {
                    setState(() {
                      _cancelReasonError = "Please enter your reason for cancelling";
                    });
                    return;
                  }
                  setState(() {
                    _cancelReasonError = null;
                    _showCancelPlanPage = false;
                  });
                  await viewModel.cancelSubscription();
                  if (context.mounted) {
                    _showCancellationSuccessDialog(context, viewModel);
                  }
                },
                child: Text(
                  "Cancel my Subscription".tr(context),
                  style: GiftPoseTextStyle.medium(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cancelBenefitItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0xFFC0392B),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GiftPoseTextStyle.medium(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

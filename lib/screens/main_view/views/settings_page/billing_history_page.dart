import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:provider/provider.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/onboarding/models/subscription_list_response.dart';
import 'package:giftpose/utils/localization_provider.dart';

class BillingHistoryPage extends StatefulWidget {
  const BillingHistoryPage({super.key});

  @override
  State<BillingHistoryPage> createState() => _BillingHistoryPageState();
}

class _BillingHistoryPageState extends State<BillingHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardViewmodel>().fetchSubscriptionList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, viewModel, child) {
        final isLoggedIn = viewModel.currentUser?.user?.email != null &&
            viewModel.currentUser!.user!.email.isNotEmpty;

        if (!isLoggedIn) {
          return GiftPoseBaseScaffold(
            showAppBar: false,
            includeVerticalPadding: false,
            includeHorizontalPadding: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            builder: (size) {
              return SafeArea(
                child: Center(
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                          "Please login to view your billing history".tr(context),
                          textAlign: TextAlign.center,
                          style: GiftPoseTextStyle.medium(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GiftPoseButton(
                          title: "Login".tr(context),
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(context, AppRoutes.siginInPage);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        List<SubscriptionItem> items = [];
        if (viewModel.subscriptionListResponse?.data != null &&
            viewModel.subscriptionListResponse!.data!.isNotEmpty) {
          items = viewModel.subscriptionListResponse!.data!;
        } else if (viewModel.currentSubscriptionResponse?.data != null) {
          final subData = viewModel.currentSubscriptionResponse!.data!;
          final rawPlan = subData.plan ?? 'monthly';
          items = [
            SubscriptionItem(
              id: subData.id,
              deviceId: subData.deviceId,
              plan: rawPlan,
              status: subData.status,
              amount: rawPlan == 'monthly' ? '0.99' : '9.99',
              currency: '£',
              createdAt: subData.createdAt,
              nextBillingDate: subData.currentPeriodEnd,
              autoRenew: !(subData.cancelAtPeriodEnd ?? false),
            )
          ];
        }

        return GiftPoseBaseScaffold(
          showAppBar: false,
          includeVerticalPadding: false,
          includeHorizontalPadding: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (size) {
            return SafeArea(
              child: Column(
                children: [
                  // HEADER
                  SizedBox(
                    height: 56,
                    child: Row(
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
                        const SizedBox(width: 12),
                        Text(
                          "Billing History".tr(context),
                          style: GiftPoseTextStyle.medium(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  Expanded(
                    child: items.isEmpty
                        ? Center(
                            child: Text(
                              "No subscription history found.".tr(context),
                              style: GiftPoseTextStyle.medium(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: items.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              final rawPlan = item.plan ?? "monthly";
                              final planName = "${rawPlan.toUpperCase()} Plan";
                              final priceVal = item.amount ?? (rawPlan == 'monthly' ? '0.99' : '9.99');
                              final currencySymbol = item.currency ?? '£';
                              final amountStr = "$currencySymbol$priceVal/${rawPlan == 'monthly' ? 'month' : 'year'}";

                              String monthStr = "JUL";
                              String dayStr = "27";
                              final dateToParse = item.createdAt ?? item.nextBillingDate;
                              if (dateToParse != null && dateToParse.isNotEmpty) {
                                try {
                                  final dt = DateTime.parse(dateToParse);
                                  final months = [
                                    "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
                                    "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"
                                  ];
                                  monthStr = months[dt.month - 1];
                                  dayStr = dt.day.toString().padLeft(2, '0');
                                } catch (_) {}
                              }

                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
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
                                                monthStr,
                                                style: GiftPoseTextStyle.small(
                                                  fontSize: 10,
                                                  color: Theme.of(context).brightness == Brightness.dark
                                                      ? Colors.grey.shade400
                                                      : Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                dayStr,
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
                                              planName,
                                              style: GiftPoseTextStyle.medium(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                              ),
                                            ),
                                            Text(
                                              amountStr,
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
                                    if (item.status != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: item.status == 'active'
                                              ? const Color(0xffE6F4EA)
                                              : Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          item.status!.toUpperCase(),
                                          style: GiftPoseTextStyle.small(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: item.status == 'active'
                                                ? const Color(0xff137333)
                                                : Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

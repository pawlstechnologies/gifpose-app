import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class ChangePlanModal extends StatefulWidget {
  final DashboardViewmodel viewModel;

  const ChangePlanModal({
    super.key,
    required this.viewModel,
  });

  static Future<void> show(
    BuildContext context,
    DashboardViewmodel viewModel,
  ) {
    HapticFeedback.heavyImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ChangePlanModal(viewModel: viewModel),
    );
  }

  @override
  State<ChangePlanModal> createState() => _ChangePlanModalState();
}

class _ChangePlanModalState extends State<ChangePlanModal> {
  late String _selectedPlan;

  @override
  void initState() {
    super.initState();
    final current = widget.viewModel.currentSubscriptionPlan;
    if (current == "monthly") {
      // User currently has a monthly sub -> force selection to annual
      _selectedPlan = "annual";
    } else if (current == "annual" || current == "yearly") {
      // User currently has an annual sub -> force selection to monthly
      _selectedPlan = "monthly";
    } else {
      _selectedPlan = "annual";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activePlan = widget.viewModel.currentSubscriptionPlan;
    final isMonthlyCurrent = activePlan == "monthly";
    final isAnnualCurrent = activePlan == "annual" || activePlan == "yearly";

    const greenAccent = Color(0xFF27C036);
    const lightGreenBg = Color(0xFFEAF8EC);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag indicator handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const YMargin(12),

          // Header: Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24), // spacer for centering title
              Text(
                "Change Plan".tr(context),
                style: GiftPoseTextStyle.medium(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.close_rounded,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const YMargin(24),

          // Plan Selection Cards
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Monthly Card (1 Month)
              Expanded(
                child: GestureDetector(
                  onTap: isMonthlyCurrent
                      ? null // Cannot re-select monthly if already on monthly plan
                      : () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _selectedPlan = "monthly";
                          });
                        },
                  child: Opacity(
                    opacity: isMonthlyCurrent ? 0.7 : 1.0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E222D)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _selectedPlan == "monthly"
                                  ? greenAccent
                                  : (isDark
                                      ? Colors.white12
                                      : Colors.grey.shade200),
                              width: _selectedPlan == "monthly" ? 2 : 1,
                            ),
                            boxShadow: _selectedPlan == "monthly"
                                ? [
                                    BoxShadow(
                                      color: greenAccent.withValues(alpha: 0.15),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isMonthlyCurrent) const SizedBox(height: 12),
                              Text(
                                "1 Month".tr(context),
                                style: GiftPoseTextStyle.medium(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              const YMargin(16),
                              Text(
                                "£0.99",
                                style: GiftPoseTextStyle.medium(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              const YMargin(8),
                              Text(
                                "£0.99/mo",
                                style: GiftPoseTextStyle.small(
                                  fontSize: 13,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isMonthlyCurrent)
                          Positioned(
                            top: -12,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: lightGreenBg,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "Current Plan".tr(context),
                                  style: GiftPoseTextStyle.small(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: greenAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              const XMargin(14),

              // Annual Card (12 Months)
              Expanded(
                child: GestureDetector(
                  onTap: isAnnualCurrent
                      ? null // Cannot re-select annual if already on annual plan
                      : () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _selectedPlan = "annual";
                          });
                        },
                  child: Opacity(
                    opacity: isAnnualCurrent ? 0.7 : 1.0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E222D)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _selectedPlan == "annual"
                                  ? greenAccent
                                  : (isDark
                                      ? Colors.white12
                                      : Colors.grey.shade200),
                              width: _selectedPlan == "annual" ? 2 : 1,
                            ),
                            boxShadow: _selectedPlan == "annual"
                                ? [
                                    BoxShadow(
                                      color: greenAccent.withValues(alpha: 0.15),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isAnnualCurrent) const SizedBox(height: 12),
                              Text(
                                "12 Months".tr(context),
                                style: GiftPoseTextStyle.medium(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                              const YMargin(8),
                              Text(
                                "£11.99",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? Colors.grey.shade500
                                      : Colors.grey.shade600,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const YMargin(2),
                              Text(
                                "Save £1.99".tr(context),
                                style: GiftPoseTextStyle.small(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFC07C27),
                                ),
                              ),
                              const YMargin(4),
                              Text(
                                "£9.99",
                                style: GiftPoseTextStyle.medium(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: greenAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isAnnualCurrent)
                          Positioned(
                            top: -12,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: lightGreenBg,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "Current Plan".tr(context),
                                  style: GiftPoseTextStyle.small(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: greenAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const YMargin(32),

          // Green "Change" Action Button
          GiftPoseButton(
            title: "Change".tr(context),
            backgroundColor: greenAccent,
            textColor: Colors.white,
            onTap: () async {
              HapticFeedback.heavyImpact();
              Navigator.pop(context);
              widget.viewModel.currentSubscriptionPlan = _selectedPlan;
              await widget.viewModel.createSubscription(plan: _selectedPlan);
            },
          ),
          const YMargin(16),
        ],
      ),
    );
  }
}

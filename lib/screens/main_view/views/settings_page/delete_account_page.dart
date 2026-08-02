import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
        return GiftPoseBaseScaffold(
          showAppBar: false,
          includeVerticalPadding: false,
          includeHorizontalPadding: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (size) {
            return SafeArea(
              child: _isSubmitted
                  ? _buildRequestReceivedView(context, vm, isDark)
                  : _buildDeleteFormView(context, vm, isDark),
            );
          },
        );
      },
    );
  }

  /// State 1: Delete Account Form View
  Widget _buildDeleteFormView(
    BuildContext context,
    DashboardViewmodel vm,
    bool isDark,
  ) {
    final String displayName = vm.currentUser?.user?.fullname ??
        vm.currentUser?.user?.username ??
        "Customer";

    return Column(
      children: [
        // App Bar Header
        SizedBox(
          height: 56.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20.r,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Delete Account".tr(context),
                  style: GiftPoseTextStyle.heading1(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(12.h),

                // Headline
                Text(
                  "We're sorry to see you go.".tr(context),
                  style: GiftPoseTextStyle.heading1(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                YMargin(6.h),
                Text(
                  "Before we proceed, please be aware of the following:".tr(context),
                  style: GiftPoseTextStyle.small(
                    fontSize: 14.sp,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),

                YMargin(20.h),
                Text(
                  "Hi $displayName,".tr(context),
                  style: GiftPoseTextStyle.medium(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),

                YMargin(16.h),

                // Warning Card Container
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Item 1: Reuse email warning
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: const Color(0xFFC62828),
                            size: 24.r,
                          ),
                          XMargin(12.w),
                          Expanded(
                            child: Text(
                              "You cannot reuse your email or phone number for a new account.".tr(context),
                              style: GiftPoseTextStyle.small(
                                fontSize: 13.sp,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Divider(
                          height: 1,
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        ),
                      ),

                      // Item 2: Permanent deletion warning
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.disabled_by_default_rounded,
                            color: const Color(0xFFC62828),
                            size: 24.r,
                          ),
                          XMargin(12.w),
                          Expanded(
                            child: Text(
                              "Account deletion is permanent, and we cannot reactivate your account or recover data once it's deleted.".tr(context),
                              style: GiftPoseTextStyle.small(
                                fontSize: 13.sp,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Divider(
                          height: 1,
                          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        ),
                      ),

                      // Item 3: 14 days hold
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_filled_rounded,
                            color: const Color(0xFFE6A100),
                            size: 24.r,
                          ),
                          XMargin(12.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: GiftPoseTextStyle.small(
                                  fontSize: 13.sp,
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                ),
                                children: [
                                  TextSpan(text: "Your request will be placed on hold for ".tr(context)),
                                  TextSpan(
                                    text: "14 days".tr(context),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ", in case you changed your mind.".tr(context)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                YMargin(24.h),

                // Feedback Section Title
                Text(
                  "Feedback".tr(context),
                  style: GiftPoseTextStyle.heading1(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                YMargin(6.h),
                Text(
                  "We appreciate any feedback you're willing to share about your decision, as it helps us improve.".tr(context),
                  style: GiftPoseTextStyle.small(
                    fontSize: 13.sp,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),

                YMargin(16.h),
                Text(
                  "Kindly provide your feedback here:".tr(context),
                  style: GiftPoseTextStyle.small(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),

                YMargin(8.h),

                // Multiline Input Field
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                    ),
                  ),
                  child: TextField(
                    controller: _feedbackController,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    decoration: InputDecoration(
                      hintText: "Your thoughts...".tr(context),
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade400,
                      ),
                      contentPadding: EdgeInsets.all(14.r),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                YMargin(20.h),

                Text(
                  "Best Regards,".tr(context),
                  style: GiftPoseTextStyle.small(
                    fontSize: 13.sp,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                Text(
                  "GiftPose Support Team".tr(context),
                  style: GiftPoseTextStyle.small(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),

                YMargin(28.h),

                // Action Buttons
                GiftPoseButton(
                  title: "Submit".tr(context),
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    vm.requestAccountDeletion(feedback: _feedbackController.text);
                    setState(() {
                      _isSubmitted = true;
                    });
                  },
                ),

                YMargin(12.h),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    side: BorderSide(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel".tr(context),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),

                YMargin(28.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// State 2: Request Received View
  Widget _buildRequestReceivedView(
    BuildContext context,
    DashboardViewmodel vm,
    bool isDark,
  ) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circle Checkmark Icon
                  Container(
                    width: 72.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF333010) : const Color(0xFFFFF9C4),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: const Color(0xFF7CB342),
                        size: 38.r,
                      ),
                    ),
                  ),

                  YMargin(24.h),

                  Text(
                    "Request Recieved".tr(context),
                    style: GiftPoseTextStyle.heading1(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),

                  YMargin(12.h),

                  Text(
                    "Your request has been received. Please allow for 14 days for the completion of your request.".tr(context),
                    textAlign: TextAlign.center,
                    style: GiftPoseTextStyle.small(
                      fontSize: 14.sp,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
  
                    ),
                  ),

                  YMargin(32.h),

                  GiftPoseButton(
                    title: "Done".tr(context),
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

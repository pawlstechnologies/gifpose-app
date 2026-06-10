import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_message_field.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class ReportListingBottomsheet extends StatelessWidget {
    final String id;
  ReportListingBottomsheet({super.key, required this.id});



  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).dividerColor;
    
    // This variable will hold the value passed back from the dialog selection
    dynamic selectedReportValue;

    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.pop(context);
                    },
                    child: Assets.icons.close.svg(height: 30, width: 30),
                  ),
                  XMargin(10),
                ],
              ),
              YMargin(14),
              Assets.icons.report.svg(height: 40, width: 40),
              YMargin(18),

              Text(
                "Report Listing".tr(context),
                textAlign: TextAlign.center,
                style: GiftPoseTextStyle.small(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 14,
                ),
              ),
              YMargin(10),
              Text(
                "Are you sure you want to report this listing as prohibited".tr(
                  context,
                ),
                textAlign: TextAlign.center,
                style: GiftPoseTextStyle.small(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 12,
                ),
              ),
              YMargin(15),

              // --- The Report Button Tapped Action ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GiftPoseButton(
                  title: "Report",
                  textColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: () async {
                    HapticFeedback.heavyImpact();
                    
                    // 1. Open the dialog when report button is pressed
                    final selectedValue = await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Theme.of(dialogContext).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  "Select a Reason".tr(dialogContext),
                                  textAlign: TextAlign.center,
                                  style: GiftPoseTextStyle.small(
                                    color: Theme.of(dialogContext).textTheme.bodyLarge?.color,
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                YMargin(15),
                                // 2. Show the list of report reasons inside the dialog
                                ...List.generate(
                                  vm.fetchReportListResponse.data?.data.length ?? 0,
                                  (index) {
                                    final options = vm.fetchReportListResponse.data?.data[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        HapticFeedback.lightImpact();
                                        // 3. When one of them is tapped, dismiss dialog and pass option back
                                        Navigator.pop(dialogContext, options);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                        child: Text(
                                          options?.label ?? "",
                                          textAlign: TextAlign.center,
                                          style: GiftPoseTextStyle.small(
                                            color: Theme.of(dialogContext).textTheme.bodyLarge?.color,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    // 4. Assign the returned value to your variable
                    if (selectedValue != null) {
                      selectedReportValue = selectedValue;
                      print("Assigned to variable: ${selectedReportValue?.label}");
                                   HapticFeedback.heavyImpact();
                    Navigator.pop(context);
                      vm.reportListing(context: context, id: id, reason: selectedReportValue);
                      
                      // Optional: Close the bottomsheet automatically too once selected
                      Navigator.pop(context, selectedReportValue);
                 
                    }
                  },
                ),
              ),
              YMargin(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: GiftPoseButton(
                  title: "Cancel",
                  borderColor: textColor,
                  textColor: textColor,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  buttonType: GiftPoseButtonType.border,
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    HapticFeedback.heavyImpact();
                    Navigator.pop(context);
                  },
                ),
              ),
              YMargin(20),
            ],
          ),
        );
      },
    );
  }
}
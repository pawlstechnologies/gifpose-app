import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart';
import 'package:giftpose/utils/constants/storage_keys.dart';
import 'package:giftpose/utils/locator.dart';

class SettingsBottomsheet extends StatelessWidget {
  SettingsBottomsheet({super.key});

 
  @override
  Widget build(BuildContext context) {
        final textColor = Theme.of(context).dividerColor;
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
                child: Assets.icons.close.svg(height: 30,width: 30),
              ),
              XMargin(10)
            ],
          ),
          YMargin(14),
          Assets.icons.hide.svg(height: 40,width: 40),
          YMargin(18),
      
          Text("Delete Account".tr(context),
            textAlign: TextAlign.center,
      
            style: GiftPoseTextStyle.small(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 14,
            ),
          ),
          YMargin(10),
          Text("Are you sure you want to Delete your account?".tr(context),
            textAlign: TextAlign.center,
      
            style: GiftPoseTextStyle.small(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 12,
            ),
          ),
               YMargin(15),
                    Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
            child: GiftPoseButton(
                                      title: "Delete",
                                        textColor: Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                        onTap: () {
                                          HapticFeedback.heavyImpact();
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                            context, 
                                            AppRoutes.deleteAccountPage,
                                          );
                                        },
                                      ),
          ),
                                    YMargin(10),
               Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                        child: GiftPoseButton(
                        title: "Cancel",
                           borderColor: textColor,
                           
                             textColor: Theme.of(context).textTheme.bodyLarge?.color,
                               backgroundColor: 
                                           Theme.of(
                                                context,
                                              ).scaffoldBackgroundColor,
                                          buttonType: GiftPoseButtonType.border,
                        onTap: () {
                         HapticFeedback.heavyImpact();
                      
                                       Navigator.pop(context);
                                      
                        },
                                          ),
                      ),
                      YMargin(20),
        
         
        ],
      ),
    );
  }
}

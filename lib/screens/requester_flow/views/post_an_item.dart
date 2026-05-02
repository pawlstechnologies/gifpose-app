import 'package:flutter/material.dart';
import 'package:giftpose/screens/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_message_field.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

class PostAnItemScreen extends StatelessWidget {
  const PostAnItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, vm, child) {
        return GiftPoseBaseScaffold(
          includeVerticalPadding: false,
          showAppBar: false,
          hasGradient: true,

          builder: (size) {
            return Column(
              children: [
                YMargin(40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // Adjust the value for more/less rounding
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Assets.icons.back.svg(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      "Gift Details".tr(context),
                      textAlign: TextAlign.center,

                      style: GiftPoseTextStyle.normal(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(height: 50, width: 50),
                  ],
                ),

                YMargin(10),

                /// SMART ASSISTANT
                Container(
                  color: GiftPoseColors.yelloColor,

                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 6,
                    ),

                    leading: Assets.images.star.image(),

                    title: Text(
                      "Upload an Image(s) and we will automatically fill in  details for you"
                          .tr(context),
                      style: GiftPoseTextStyle.normal(
                        color: GiftPoseColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                YMargin(25),

                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: Theme.of(context).dividerColor,
                    strokeWidth: 1.5,
                    dashPattern: const [6, 4],
                    radius: const Radius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.heavyImpact();
         
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                            ),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: 30,
                              color: GiftPoseColors.primaryColor,
                            ),
                          ),
                          YMargin(14),
                          Text(
                            "Click here to upload your image".tr(context),
                            style: GiftPoseTextStyle.normal(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),


                          Text(
                            "Up to 10 Images supported".tr(context),
                            style: GiftPoseTextStyle.normal(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),

                        ],
                      ),
                    ),
                    
                  ),
                ),
                YMargin(20),
                    GiftPoseTextField(
                      controller: vm.usernameCtrl,
                      hintText: "Enter Item Name".tr(context),
                      fieldName: "Item Name".tr(context),
             
                    ),
                        GiftPoseMessageTextField(
          controller:  vm.usernameCtrl,
          fieldName: "Item Description".tr(context),

          hintText: "Enter Item Description".tr(context),

          onChanged: (value) async {},
        ),


        YMargin(100),
        GiftPoseButton(
          title: "Post".tr(context),
          onTap: () {
            HapticFeedback.heavyImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostAnItemScreen(),
              ),
            );
          },
        ),
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/views/settings_page/category_widget_page.dart';
import 'package:giftpose/screens/main_view/widgets/faq_widget.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class HelpCenter extends StatelessWidget {
  HelpCenter({super.key});
  final searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: true,
      includeVerticalPadding: false,
      includeHorizontalPadding: true,
      centerTitle: true,
      appBarLeadingWidget: InkWell(
        onTap: () {
          HapticFeedback.heavyImpact();
          Navigator.pop(context);
        },
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ), // Adjust the value for more/less rounding
          ),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Assets.icons.back.svg(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ),

      hasGradient: true, 
      appBarTitleWidget: Text("Help Center".tr(context),
        textAlign: TextAlign.center,

      style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return ListView(
          shrinkWrap: true,
          children: [
         YMargin(18),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
             
              color: GiftPoseColors.containerBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(24),

                  Text("How can we help?".tr(context),
                    textAlign: TextAlign.left,

                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w500,
                      color: GiftPoseColors.textColor,
                      fontSize: 22,
                    ),
                  ),

                  YMargin(16),
                  GiftPoseTextField(
                    controller: searchCtrl,

                    hintText: "Search for categories",
                    prefixIcon: Assets.icons.search.svg(),
                    onChanged: (value) async {},
                  ),
                
                ],
              ),
            ),

            YMargin(24),
            Text("Categories".tr(context),

              style: GiftPoseTextStyle.small(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            YMargin(10),

            InkWell(
              onTap: () {
                HapticFeedback.heavyImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                       CategoryWidgetDetails(title: "Recieving".tr(context)),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Assets.icons.location.svg(),
                  title: Text("Recieving".tr(context),

                    style: GiftPoseTextStyle.small(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Fundraising and financial gifts".tr(context),

                      style: GiftPoseTextStyle.small(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  trailing: Assets.icons.foward.svg(),
                ),
              ),
            ),
            YMargin(12),
             InkWell(
            onTap: () {
                     HapticFeedback.heavyImpact();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         PostcodeScreen(fromDashboard: true),
                      //   ),
                      // );
                    
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Assets.icons.location.svg(),
                      title: Text("Gifting".tr(context),
                          
                        style: GiftPoseTextStyle.small(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                            child: Text("coming soon".tr(context),
                          
                          style: GiftPoseTextStyle.small(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                      trailing: Assets.icons.foward.svg(),
                    ),
                  ),
                ),
                YMargin(12),
                  InkWell(
            onTap: () {
                     HapticFeedback.heavyImpact();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         PostcodeScreen(fromDashboard: true),
                      //   ),
                      // );
                    
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Assets.icons.location.svg(),
                      title: Text("Requesting".tr(context),
                          
                        style: GiftPoseTextStyle.small(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("coming soon".tr(context),
                          
                          style: GiftPoseTextStyle.small(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                      trailing: Assets.icons.foward.svg(),
                    ),
                  ),
                ),
                YMargin(39),

                 Text("Frequently Asked Questions".tr(context),

              style: GiftPoseTextStyle.small(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 18
              ),
            ),
            YMargin(18),
            GiftPoseFAQWidget(),

       YMargin(79),




          ],
        );
      },
    );
  }
}

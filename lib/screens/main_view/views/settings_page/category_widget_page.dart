import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/views/settings_page/article_page.dart';
import 'package:giftpose/screens/main_view/widgets/faq_widget.dart';
import 'package:giftpose/screens/main_view/widgets/need_help_bottomsheet.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/bottom_sheet.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class CategoryWidgetDetails extends StatelessWidget {
  final String title;
  CategoryWidgetDetails({super.key, required this.title});
  final searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: true,
      includeVerticalPadding: false,
      includeHorizontalPadding: false,
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
      appBarTitleWidget: Text(
        title,
        textAlign: TextAlign.center,

        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return ListView(
          shrinkWrap: true,
          children: [
            YMargin(19),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 17.0,
                vertical: 12.0,
              ),
              color: GiftPoseColors.containerBackground,
              child: Column(
                children: [
                  Assets.icons.heart.svg(),

                  Text("Learn about fundraising, managing your gifts, and tax documentation.".tr(context),
                    textAlign: TextAlign.center,

                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w500,
                      color: GiftPoseColors.textColor,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Articles".tr(context),

                style: GiftPoseTextStyle.small(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
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
                        ArticlePage(title: "Contacting a Gift Giver".tr(context)),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                    title: Text("Contacting a Gift Giver".tr(context),

                      style: GiftPoseTextStyle.small(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("Step-by-step guide.".tr(context),

                        style: GiftPoseTextStyle.small(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    trailing: Assets.icons.foward.svg(),
                  ),
                ),
              ),
            ),
            YMargin(12),
   
            YMargin(25),
          

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: GiftPoseColors.greenColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                         YMargin(24),
                    Text("Still need help?".tr(context),

                      style: GiftPoseTextStyle.small(
                        color: GiftPoseColors.textColor,
                        fontSize: 18,
                      ),
                    ),
                    YMargin(4),
                    Padding(
               padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text("Our support team is available 24/7 for inquiries.".tr(context),
                        textAlign: TextAlign.center,
                      
                        style: GiftPoseTextStyle.small(
                          color: GiftPoseColors.textColor2,
                          fontSize: 14,
                        ),
                      ),
                    ), 
                    YMargin(16),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
         
                      child: GiftPoseButton(title: "Contact Support", onTap: (){
                          //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    
      MyBottomSheet.showDismissibleBottomSheet(
        bottomAction: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        
       
        context: context,
        height: MediaQuery.of(context).size.height / 1.05,
        children: [NeedHelpBottomsheet()],
      );
  
                      }),
                    ),
                     YMargin(16),
                  ],
                ),
              ),
            ),
              YMargin(86),
          ],
        );
      },
    );
  }
}

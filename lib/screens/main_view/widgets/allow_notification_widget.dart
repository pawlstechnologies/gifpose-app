import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class AllowNotificationWidget extends StatelessWidget {
  const AllowNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
         return Consumer<DashboardViewmodel>(
          builder: (context, viewModel, child) {
        return Column(
          children: [
              Assets.icons.allowNotifications.svg(),
              Text(
            "Allow Notification",
            textAlign: TextAlign.center,
        
            style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
          ),
          YMargin(2),
        Text(
            "Get timely updated and never miss out",
            textAlign: TextAlign.center,
        
            style: GiftPoseTextStyle.small(),
          ),
            YMargin(23),
        
          GiftPoseButton(title: "Accept", onTap: (){
                  viewModel.fetchAlertCategory();
            HapticFeedback.selectionClick();
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.notificationsAlert);
            
          }),
          YMargin(10),
         GiftPoseButton(
              buttonType: GiftPoseButtonType.border,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          
          title: "Cancel", onTap: (){
          
            HapticFeedback.selectionClick();
        
            Navigator.pop(context);
        
          },
          textColor: Theme.of(context).textTheme.bodyLarge?.color,
          borderColor: Theme.of(context).dividerColor,
          ),
          ],
        );
      }
    );
  }
}
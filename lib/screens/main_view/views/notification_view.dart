import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/widgets/allow_notification_widget.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/bottom_sheet.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(Duration(seconds: 2), () {});
      MyBottomSheet.showDismissibleBottomSheet(
        bottomAction: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
       
        context: context,
        height: MediaQuery.of(context).size.height / 2.6,
        children: [AllowNotificationWidget()],
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      includeHorizontalPadding: false,

      showAppBar: true,
      includeVerticalPadding: false,
      centerTitle: true,
      appBarLeadingWidget: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.pop(context);
        },
        child: Assets.icons.back.svg(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),

      hasGradient: true,
      appBarTitleWidget: Text(
        "Notification",
        textAlign: TextAlign.center,

        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return ListView(children: [
          






        
          ],
        );
      },
    );
  }
}

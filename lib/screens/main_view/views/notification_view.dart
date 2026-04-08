import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/widgets/allow_notification_widget.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/bottom_sheet.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class NotificationView extends StatefulWidget {
  NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   Future.delayed(Duration(seconds: 2), () {});
    //   MyBottomSheet.showDismissibleBottomSheet(
    //     bottomAction: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //     ),

    //     context: context,
    //     height: MediaQuery.of(context).size.height / 2.6,
    //     children: [AllowNotificationWidget()],
    //   );
    // });
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
      appBarTitleWidget: Text("Notification".tr(context),
        textAlign: TextAlign.center,

 style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return ListView(children: [
          






        
          ],
        );
      },
    );
  }
}
// Individual List Item Widget
class CategoryListItem extends StatelessWidget {
  final FetchItemsNearMeData response;


  CategoryListItem({super.key, required this.response, });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: response.thumbnail ?? '',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade200,
                child: Icon(Icons.error, color: Colors.grey),
              ),
              placeholder: (context, url) => Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade100,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    response.name ?? 'No name',
                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  YMargin(8),

                  // Location with Icon
                  Row(
                    children: [
                      Assets.icons.location.svg(
                        height: 14,
                        width: 14,
                      ),
                      XMargin(4),
                      Expanded(
                        child: Text(
                 "United Kingdom",
                          style: GiftPoseTextStyle.small(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  YMargin(8),

         
               
                ],
              ),
            ),
          ),

          // Arrow Icon
          Padding(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
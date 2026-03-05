import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class TransportWidgets extends StatelessWidget {
  final String location;
  bool? isTappedPublic;
  final Widget icon;
  final bool isTapped;
  final String title;
 TransportWidgets({
    super.key,
    required this.icon,
    required this.title,
    required this.isTapped, required this.location,  this.isTappedPublic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,

      child: Column(
        children: [
          icon,
          YMargin(6),
          Text(
            title,
            textAlign: TextAlign.center,

            maxLines: 2,

            style: GiftPoseTextStyle.small(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: isTapped
                  ? GiftPoseColors.primaryColor
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          YMargin(8),
          isTappedPublic ==true ?SizedBox.shrink():
          isTapped?
           Text(
            location,
            textAlign: TextAlign.center,

            maxLines: 2,

            style: GiftPoseTextStyle.small(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: isTapped
                  ? GiftPoseColors.primaryColor
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ): SizedBox.shrink(),

        ],
      ),
    );
  }
}

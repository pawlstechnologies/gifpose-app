import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/views/dashboard_view.dart';
import 'package:giftpose/screens/main_view/widgets/transport_widgets.dart';
import 'package:giftpose/utils/mediaquery.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class DetailsPage extends StatefulWidget {
  final CategoryProducts? category;

  const DetailsPage({super.key, this.category});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isTappedPrivate = false;
  bool isTappedPublic = false;
  bool isTappedWalking = false;
  bool isTappedCycling = false;
  bool isTappedVehicle = false;
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).dividerColor;

    return GiftPoseBaseScaffold(
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
        "Gift Details",
        textAlign: TextAlign.center,

        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return ListView(
          children: [
            YMargin(15),
            Assets.images.images1.image(),
            YMargin(30),
            Text(
              widget.category?.name ?? "",
              style: GiftPoseTextStyle.heading1(fontWeight: FontWeight.w500),
            ),
            YMargin(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Assets.icons.location.svg(
                      color: GiftPoseColors.primaryColor,
                    ),
                    XMargin(8),
                    Text(
                      widget.category?.location ?? "",
                      style: GiftPoseTextStyle.small(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  "2 miles away",
                  style: GiftPoseTextStyle.small(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            YMargin(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        isTappedPrivate = true;
                        isTappedCycling = false;
                        isTappedPublic = false;
                        isTappedVehicle = false;
                        isTappedWalking = false;
                        setState(() {});
                      },
                      child: TransportWidgets(
                        isTapped: isTappedPrivate,
                        icon: Assets.icons.privateVehicle.svg(
                          color: isTappedPrivate
                              ? GiftPoseColors.primaryColor
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        title: "Private Vehicle",
                      ),
                    ),
                    YMargin(10),
                    isTappedPrivate
                        ? Text(
                            "24 mins",
                            textAlign: TextAlign.center,

                            maxLines: 2,

                            style: GiftPoseTextStyle.small(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color:  GiftPoseColors.primaryColor,
                       
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                XMargin(24),
                InkWell(
                  onTap: () {
                    isTappedPrivate = false;
                    isTappedCycling = false;
                    isTappedPublic = true;
                    isTappedVehicle = false;
                    setState(() {});
                    isTappedWalking = false;
                  },
                  child: TransportWidgets(
                    isTapped: isTappedPublic,
                    icon: Assets.icons.publicTransport.svg(
                      color: isTappedPublic
                          ? GiftPoseColors.primaryColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    title: "Public Transport",
                  ),
                ),

                XMargin(24),
                InkWell(
                  onTap: () {
                    isTappedPrivate = false;
                    isTappedCycling = false;
                    isTappedPublic = false;
                    isTappedVehicle = false;
                    isTappedWalking = true;
                    setState(() {});
                  },
                  child: TransportWidgets(
                    isTapped: isTappedWalking,
                    icon: Assets.icons.walking.svg(
                      color: isTappedWalking
                          ? GiftPoseColors.primaryColor
                              : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    title: "Walking",
                  ),
                ),
                XMargin(24),
                InkWell(
                  onTap: () {
                    isTappedPrivate = false;
                    isTappedCycling = true;
                    isTappedPublic = false;
                    isTappedVehicle = false;
                    isTappedWalking = false;
                    setState(() {});
                  },
                  child: TransportWidgets(
                    isTapped: isTappedCycling,
                    icon: Assets.icons.cycling.svg(
                      color: isTappedCycling
                          ? GiftPoseColors.primaryColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    title: "Cycling",
                  ),
                ),
                XMargin(24),
                InkWell(
                  onTap: () {
                    isTappedPrivate = false;
                    isTappedCycling = false;
                    isTappedPublic = false;
                    isTappedVehicle = true;
                    isTappedWalking = false;
                    setState(() {});
                  },
                  child: TransportWidgets(
                    isTapped: isTappedVehicle,
                    icon: Assets.icons.vehicleHire.svg(
                      color: isTappedVehicle
                          ? GiftPoseColors.primaryColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    title: "Vehicle Hire",
                  ),
                ),
              ],
            ),
            isTappedPublic ? YMargin(20) : SizedBox.shrink(),
            isTappedPublic
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 17),
                    width: width(context),
                    color: GiftPoseColors.containerBackground,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Assets.icons.train.svg(),
                                XMargin(5),
                                Text(
                                  "Train: 12mins",
                                  textAlign: TextAlign.justify,

                                  style: GiftPoseTextStyle.small(
                                    fontWeight: FontWeight.w400,
                                    color: GiftPoseColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                      

                            Row(
                              children: [
                                Assets.icons.train.svg(),
                                XMargin(5),
                                Text(
                                  "Train: 12mins",
                                  textAlign: TextAlign.justify,

                                  style: GiftPoseTextStyle.small(
                                    fontWeight: FontWeight.w400,
                                    color: GiftPoseColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                              YMargin(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Assets.icons.train.svg(),
                                XMargin(5),
                                Text(
                                  "Train: 12mins",
                                  textAlign: TextAlign.justify,

                                  style: GiftPoseTextStyle.small(
                                    fontWeight: FontWeight.w400,
                                    color: GiftPoseColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Assets.icons.train.svg(),
                                XMargin(5),
                                Text(
                                  "Train: 12mins",
                                  textAlign: TextAlign.justify,

                                  style: GiftPoseTextStyle.small(
                                    fontWeight: FontWeight.w400,
                                    color: GiftPoseColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            YMargin(30),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet  purus sit amet  Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet  purus sit amet ",
              textAlign: TextAlign.justify,

              style: GiftPoseTextStyle.small(fontWeight: FontWeight.w400 ,color:Theme.of(context).textTheme.bodyMedium?.color,),
            ),
            YMargin(10),

            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet  purus sit amet  Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet  purus sit amet ",
              textAlign: TextAlign.justify,

              style: GiftPoseTextStyle.small(fontWeight: FontWeight.w400,color:     Theme.of(context).textTheme.bodyMedium?.color,),
            ),

            YMargin(18),
            GiftPoseButton(
              title: "Mark as Taken",
              borderColor: textColor!,
              buttonType: GiftPoseButtonType.border,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              fontSize: 14,
              textColor: Theme.of(context).textTheme.bodyLarge?.color,
              onTap: () {
                HapticFeedback.selectionClick();
              },
            ),
            YMargin(24),
            GiftPoseButton(
              title: "Visit Freebies",
              textColor:  Theme.of(context).scaffoldBackgroundColor,
              onTap: () {
                HapticFeedback.selectionClick();
              },
            ),
          ],
        );
      },
    );
  }
}

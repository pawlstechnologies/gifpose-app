import 'package:cached_network_image/cached_network_image.dart';
import 'package:giftpose/screens/main_view/widgets/hide_listing_bottomsheet.dart';
import 'package:giftpose/screens/main_view/widgets/report_listing_bottomsheet.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/views/dashboard_view.dart';
import 'package:giftpose/screens/main_view/widgets/transport_widgets.dart';
import 'package:giftpose/utils/mediaquery.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/bottom_sheet.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:giftpose/utils/widgets/webview_screen.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String? location;

  DetailsPage({super.key, required this.location});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isTappedPrivate = false;
  bool isTappedPublic = false;
  bool isTappedWalking = false;
  bool isTappedCycling = false;
  bool isTappedVehicle = false;
  bool _isNavigating = false;
  int selectedImageIndex = 0;

  bool isMarked = false;
  bool hideListing = false;
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).dividerColor;

    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
        return GiftPoseBaseScaffold(
          showAppBar: false,
          includeVerticalPadding: false,
          includeHorizontalPadding: false,
          centerTitle: true,
          appBarLeadingWidget: InkWell(
            onTap: () {
              HapticFeedback.heavyImpact();
              Navigator.pop(context);
            },
            child: Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
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
            "Gift Details".tr(context),
            textAlign: TextAlign.center,

            style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
          ),

          builder: (size) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        YMargin(30),

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
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
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

                        GestureDetector(
                          onTap: () {
                            final dataResponse =
                                vm.fetchItemsByIdMeResponse.data;
                            if (dataResponse == null) return;
                            final responseData = dataResponse.data;
                            final heroImage =
                                responseData.imageUrls.length >
                                    selectedImageIndex
                                ? responseData.imageUrls[selectedImageIndex]
                                : null;
                            if (heroImage != null &&
                                heroImage.toString().isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      InteractiveViewer(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: heroImage.toString(),
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) =>
                                                Container(
                                                  color: Colors.grey.shade100,
                                                  child: Center(
                                                    child:
                                                        CupertinoActivityIndicator(),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                      child: Icon(
                                                        Icons.error,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -15,
                                        right: -15,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl:
                                  vm
                                      .fetchItemsByIdMeResponse
                                      .data
                                      ?.data
                                      .imageUrls[selectedImageIndex] ??
                                  '',
                              width: double.infinity,
                              height: 277.w,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(
                                width: double.infinity,
                                height: 102.w,
                                color: Colors.grey.shade200,
                                child: Icon(Icons.error, color: Colors.grey),
                              ),
                              placeholder: (context, url) => Container(
                                width: double.infinity,
                                height: 102.w,
                                color: Colors.grey.shade100,
                                child: Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -20),
                          child: Container(
                            width: width(context),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YMargin(14),

                                Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: SizedBox(
                                    height: 80.w,
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          vm
                                                  .fetchItemsByIdMeResponse
                                                  .data
                                                  ?.data
                                                  ?.imageUrls
                                                  .length ??
                                              0,
                                          (index) {
                                            final imageUrl =
                                                vm
                                                    .fetchItemsByIdMeResponse
                                                    .data
                                                    ?.data
                                                    ?.imageUrls[index] ??
                                                '';

                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedImageIndex = index;
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  right: 15.w,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl: imageUrl,
                                                    width: 60.w,
                                                    height: 60.w,
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                              width: 92.w,
                                                              height: 86.w,
                                                              color: Colors
                                                                  .grey
                                                                  .shade200,
                                                              child: Icon(
                                                                Icons.error,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                    placeholder:
                                                        (
                                                          context,
                                                          url,
                                                        ) => Container(
                                                          width: 92.w,
                                                          height: 86.w,
                                                          color: Colors
                                                              .grey
                                                              .shade100,
                                                          child: Center(
                                                            child:
                                                                CupertinoActivityIndicator(),
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                YMargin(14),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    vm
                                            .fetchItemsByIdMeResponse
                                            .data
                                            ?.data
                                            ?.name ??
                                        "",
                                    style: GiftPoseTextStyle.normal(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                YMargin(10),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Assets.icons.location.svg(
                                            color: GiftPoseColors.primaryColor,
                                          ),
                                          XMargin(8),
                                          Text(
                                            widget.location ?? "",
                                            style: GiftPoseTextStyle.small(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${vm.fetchItemsByIdMeResponse.data?.data?.distanceInMiles ?? 0} miles away"
                                            .tr(context),
                                        style: GiftPoseTextStyle.small(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                YMargin(25),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              location:
                                                  vm
                                                      .fetchItemsByIdMeResponse
                                                      .data
                                                      ?.data
                                                      ?.estimatedTravelTime
                                                      ?.carPrivate ??
                                                  "",
                                              isTapped: isTappedPrivate,
                                              icon: Assets.icons.privateVehicle
                                                  .svg(
                                                    color: isTappedPrivate
                                                        ? GiftPoseColors
                                                              .primaryColor
                                                        : Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.color,
                                                  ),
                                              title: "Private Vehicle".tr(
                                                context,
                                              ),
                                            ),
                                          ),
                                          YMargin(10),
                                          // isTappedPrivate
                                          //     ? Text(
                                          //           vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.carPrivate ?? "",
                                          //         textAlign: TextAlign.center,

                                    //         maxLines: 2,

                                    //         style: GiftPoseTextStyle.small(
                                    //           fontSize: 10,
                                    //           fontWeight: FontWeight.w400,
                                    //           color:  GiftPoseColors.primaryColor,

                                          //         ),
                                          //       )
                                          //     : SizedBox.shrink(),
                                        ],
                                      ),
                                      XMargin(20),
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
                                          location:
                                              vm
                                                  .fetchItemsByIdMeResponse
                                                  .data
                                                  ?.data
                                                  ?.estimatedTravelTime
                                                  ?.publicTransport ??
                                              "",
                                          isTapped: isTappedPublic,
                                          isTappedPublic: true,
                                          icon: Assets.icons.publicTransport
                                              .svg(
                                                color: isTappedPublic
                                                    ? GiftPoseColors
                                                          .primaryColor
                                                    : Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.color,
                                              ),
                                          title: "Public Transport".tr(context),
                                        ),
                                      ),

                                      XMargin(20),
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
                                          location:
                                              vm
                                                  .fetchItemsByIdMeResponse
                                                  .data
                                                  ?.data
                                                  ?.estimatedTravelTime
                                                  ?.walking ??
                                              "",
                                          isTapped: isTappedWalking,
                                          icon: Assets.icons.walking.svg(
                                            color: isTappedWalking
                                                ? GiftPoseColors.primaryColor
                                                : Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium?.color,
                                          ),
                                          title: "Walking".tr(context),
                                        ),
                                      ),
                                      XMargin(20),
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
                                          location:
                                              vm
                                                  .fetchItemsByIdMeResponse
                                                  .data
                                                  ?.data
                                                  ?.estimatedTravelTime
                                                  ?.cycling ??
                                              "",
                                          isTapped: isTappedCycling,
                                          icon: Assets.icons.cycling.svg(
                                            color: isTappedCycling
                                                ? GiftPoseColors.primaryColor
                                                : Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium?.color,
                                          ),
                                          title: "Cycling".tr(context),
                                        ),
                                      ),
                                      XMargin(20),
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
                                          location:
                                              vm
                                                  .fetchItemsByIdMeResponse
                                                  .data
                                                  ?.data
                                                  ?.estimatedTravelTime
                                                  ?.carHire ??
                                              "",
                                          isTapped: isTappedVehicle,
                                          icon: Assets.icons.vehicleHire.svg(
                                            color: isTappedVehicle
                                                ? GiftPoseColors.primaryColor
                                                : Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium?.color,
                                          ),
                                          title: "Vehicle Hire",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                isTappedPublic
                                    ? YMargin(20)
                                    : SizedBox.shrink(),
                                isTappedPublic
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 9,
                                          horizontal: 15,
                                        ),
                                        width: width(context),
                                        color:
                                            GiftPoseColors.containerBackground,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Assets.icons.train.svg(),
                                                    XMargin(5),
                                                    Text(
                                                      "Train:".tr(context) +
                                                          " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                      textAlign:
                                                          TextAlign.justify,

                                                style: GiftPoseTextStyle.small(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GiftPoseColors.textColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                                Row(
                                                  children: [
                                                    Assets.icons.train.svg(),
                                                    XMargin(5),
                                                    Text(
                                                      "Tram:".tr(context) +
                                                          " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                      textAlign:
                                                          TextAlign.justify,

                                                      style:
                                                          GiftPoseTextStyle.small(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                GiftPoseColors
                                                                    .textColor,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            YMargin(20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Assets.icons.train.svg(),
                                                    XMargin(5),
                                                    Text(
                                                      "Underground:".tr(
                                                            context,
                                                          ) +
                                                          " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                      textAlign:
                                                          TextAlign.justify,

                                                      style:
                                                          GiftPoseTextStyle.small(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                GiftPoseColors
                                                                    .textColor,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Assets.icons.train.svg(),
                                                    XMargin(5),
                                                    Text(
                                                      "Bus:".tr(context) +
                                                          " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                      textAlign:
                                                          TextAlign.justify,

                                                      style:
                                                          GiftPoseTextStyle.small(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                GiftPoseColors
                                                                    .textColor,
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

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    "${vm.fetchItemsByIdMeResponse.data?.data?.description}"
                                        .tr(context),
                                    textAlign: TextAlign.justify,

                                    style: GiftPoseTextStyle.small(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        YMargin(24),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hideListing = !hideListing;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Hide listing".tr(context),
                      textAlign: TextAlign.left,

                      style: GiftPoseTextStyle.small(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ),
                _isNavigating
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: GiftPoseButton(
                          title: !isMarked
                              ? "Mark as Taken"
                              : "Marked as Taken",
                          borderColor: textColor,
                          buttonType: GiftPoseButtonType.border,
                          prefixIcon: isMarked
                              ? Assets.icons.mark.svg()
                              : SizedBox.shrink(),
                          backgroundColor: !isMarked
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 14,
                          textColor: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.color,
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            isMarked = !isMarked;
                            setState(() {
                              vm.markItem(id: vm.fetchItemsByIdMeResponse.data?.data.id ?? "");

                            });
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                YMargin(24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: GiftPoseButton(
                    title: "Ask for Gift Item",
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WebViewScreen(
                            url:
                                vm.fetchItemsByIdMeResponse.data?.data.url ??
                                "",
                            title: "GiftPose",
                          ),
                        ),
                      );
                      setState(() => _isNavigating = true);
                    },
                  ),
                ),
                hideListing
                    ? Column(
                        children: [
                          YMargin(13),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: GiftPoseButton(
                              title: "Hide Listing",
                              borderColor: textColor,
                              textColor: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                              backgroundColor: Theme.of(
                                context,
                              ).scaffoldBackgroundColor,
                              buttonType: GiftPoseButtonType.border,
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) => HideListingBottomsheet(
                                    id:
                                        vm
                                            .fetchItemsByIdMeResponse
                                            .data
                                            ?.data
                                            .id ??
                                        "",
                                  ),
                                );
                              },
                            ),
                          ),
                          YMargin(12),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: GiftPoseButton(
                              title: "Report listing",
                              borderColor: textColor,

                              textColor: Colors.red,
                              backgroundColor: Theme.of(
                                context,
                              ).scaffoldBackgroundColor,
                              buttonType: GiftPoseButtonType.text,
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) => ReportListingBottomsheet(),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                YMargin(40),
              ],
            );
          },
        );
      },
    );
  }
}

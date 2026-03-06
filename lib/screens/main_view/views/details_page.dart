import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:giftpose/utils/widgets/webview_screen.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String location;

  const DetailsPage({super.key, required this.location});

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

    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  YMargin(15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl:
                          vm
                              .fetchItemsByIdMeResponse
                              .data
                              ?.data
                              ?.imageUrls[0] ??
                          '',
                      width: double.infinity,
                      height: 277.w,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 102.w,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.error, color: Colors.grey),
                      ),
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        height: 102.w,
                        color: Colors.grey.shade100,
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Container(
                      width: width(context),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              YMargin(14),

                              SizedBox(
                                height: 100.w,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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

                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: index == 2 ? 0 : 15.w,
                                        ), // up to 3 images
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: imageUrl,
                                            width: 92.w,
                                            height: 86.w,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                      width: 92.w,
                                                      height: 86.w,
                                                      color:
                                                          Colors.grey.shade200,
                                                      child: const Icon(
                                                        Icons.error,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            placeholder: (context, url) =>
                                                Container(
                                                  width: 92.w,
                                                  height: 86.w,
                                                  color: Colors.grey.shade100,
                                                  child: const Center(
                                                    child:
                                                        CupertinoActivityIndicator(),
                                                  ),
                                                ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              YMargin(14),
                              Text(
                                vm.fetchItemsByIdMeResponse.data?.data?.name ??
                                    "",
                                style: GiftPoseTextStyle.heading1(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              YMargin(10),
                              Row(
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
                                        widget.location,
                                        style: GiftPoseTextStyle.small(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${vm.fetchItemsByIdMeResponse.data?.data?.distanceInMiles ?? 0} miles away",
                                    style: GiftPoseTextStyle.small(
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                          location:
                                              vm
                                                  .fetchItemsByIdMeResponse
                                                  .data
                                                  ?.data
                                                  ?.estimatedTravelTime
                                                  ?.carPrivate ??
                                              "",
                                          isTapped: isTappedPrivate,
                                          icon: Assets.icons.privateVehicle.svg(
                                            color: isTappedPrivate
                                                ? GiftPoseColors.primaryColor
                                                : Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium?.color,
                                          ),
                                          title: "Private Vehicle",
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
                                      icon: Assets.icons.publicTransport.svg(
                                        color: isTappedPublic
                                            ? GiftPoseColors.primaryColor
                                            : Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.color,
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
                              isTappedPublic ? YMargin(20) : SizedBox.shrink(),
                              isTappedPublic
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 9,
                                        horizontal: 17,
                                      ),
                                      width: width(context),
                                      color: GiftPoseColors.containerBackground,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Assets.icons.train.svg(),
                                                  XMargin(5),
                                                  Text(
                                                    "Train: ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ""}",
                                                    textAlign:
                                                        TextAlign.justify,

                                                    style:
                                                        GiftPoseTextStyle.small(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: GiftPoseColors
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
                                                    "Tram ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ""}",
                                                    textAlign:
                                                        TextAlign.justify,

                                                    style:
                                                        GiftPoseTextStyle.small(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: GiftPoseColors
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Assets.icons.train.svg(),
                                                  XMargin(5),
                                                  Text(
                                                    "Underground: ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ""}",
                                                    textAlign:
                                                        TextAlign.justify,

                                                    style:
                                                        GiftPoseTextStyle.small(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: GiftPoseColors
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
                                                    "Bus: ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ""}",
                                                    textAlign:
                                                        TextAlign.justify,

                                                    style:
                                                        GiftPoseTextStyle.small(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: GiftPoseColors
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
                              YMargin(30),
                              Text(
                                "${vm.fetchItemsByIdMeResponse.data?.data?.description}",
                                textAlign: TextAlign.justify,

                                style: GiftPoseTextStyle.small(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                ),
                              ),
                              YMargin(10),

                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet  purus sit amet  Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet  purus sit amet ",
                                textAlign: TextAlign.justify,

                                style: GiftPoseTextStyle.small(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                ),
                              ),

                              YMargin(18),
                              GiftPoseButton(
                                title: "Mark as Taken",
                                borderColor: textColor!,
                                buttonType: GiftPoseButtonType.border,
                                backgroundColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                fontSize: 14,
                                textColor: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                },
                              ),
                              YMargin(24),
                              GiftPoseButton(
                                title: "Visit Freebies",
                                textColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => WebViewScreen(
                                        url:
                                            vm
                                                .fetchItemsByIdMeResponse
                                                .data
                                                ?.data
                                                .url ??
                                            "",
                                        title: "GiftPose",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  YMargin(24),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

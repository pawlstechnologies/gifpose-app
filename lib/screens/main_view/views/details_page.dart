import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).dividerColor;

    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
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
          appBarTitleWidget: Text("Gift Details".tr(context),
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
                              ?.imageUrls[selectedImageIndex] ??
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
                              height: 100.w,
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
                                          padding: EdgeInsets.only(right: 15.w),
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
                                                  (
                                                    context,
                                                    url,
                                                    error,
                                                  ) => Container(
                                                    width: 92.w,
                                                    height: 86.w,
                                                    color: Colors.grey.shade200,
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                    width: 92.w,
                                                    height: 86.w,
                                                    color: Colors.grey.shade100,
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
                              vm.fetchItemsByIdMeResponse.data?.data?.name ??
                                  "",
                              style: GiftPoseTextStyle.heading1(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Text("${vm.fetchItemsByIdMeResponse.data?.data?.distanceInMiles ?? 0} miles away".tr(context),
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
                              horizontal: 20.0,
                            ),
                  
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YMargin(14),
                  
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: SizedBox(
                                    height: 100.w,
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
                                                padding: EdgeInsets.only(right: 15.w),
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
                                                        (
                                                          context,
                                                          url,
                                                          error,
                                                        ) => Container(
                                                          width: 92.w,
                                                          height: 86.w,
                                                          color: Colors.grey.shade200,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    vm.fetchItemsByIdMeResponse.data?.data?.name ??
                                        "",
                                    style: GiftPoseTextStyle.heading1(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                YMargin(10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Assets.icons.train.svg(),
                                              XMargin(5),
                                              Text("Train:".tr(context) + " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                textAlign: TextAlign.justify,

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
                                              Text("Tram:".tr(context) + " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                textAlign: TextAlign.justify,

                                                style: GiftPoseTextStyle.small(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GiftPoseColors.textColor,
                                                ),
                                              ),
                                            ],
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
                                ),
                                YMargin(25),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Assets.icons.train.svg(),
                                              XMargin(5),
                                              Text("Underground:".tr(context) + " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                textAlign: TextAlign.justify,

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
                                              Text("Bus:".tr(context) + " ${vm.fetchItemsByIdMeResponse.data?.data?.estimatedTravelTime?.publicTransport ?? ''} mins",
                                                textAlign: TextAlign.justify,

                                                style: GiftPoseTextStyle.small(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GiftPoseColors.textColor,
                                                ),
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
                                          title: "Walking",
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
                                          title: "Cycling",
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
                                )
                              : SizedBox.shrink(),
                          YMargin(30),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Text("${vm.fetchItemsByIdMeResponse.data?.data?.description}".tr(context),
                              textAlign: TextAlign.justify,

                              style: GiftPoseTextStyle.small(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                          YMargin(10),

                          YMargin(18),
                          _isNavigating
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: GiftPoseButton(
                                    title: "Ask for Gift Item",
                                    textColor: Theme.of(
                                      context,
                                    ).scaffoldBackgroundColor,
                                    onTap: () {
                                     HapticFeedback.heavyImpact();
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
                                      setState(() => _isNavigating = true);
                                    },
                                  ),
                                )
                              : SizedBox.shrink(),
                          YMargin(24),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: GiftPoseButton(
                              title: "Ask for Gift Item",
                              textColor: Theme.of(
                                context,
                              ).scaffoldBackgroundColor,
                              onTap: () {
                               HapticFeedback.heavyImpact();
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
                                setState(() => _isNavigating = true);
                              },
                            ),
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

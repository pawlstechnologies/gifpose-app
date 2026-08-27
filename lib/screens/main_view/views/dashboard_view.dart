// screens/main_view/views/dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/views/search_page.dart';
import 'package:giftpose/screens/main_view/widgets/allow_notification_widget.dart';
import 'package:giftpose/screens/main_view/widgets/gridview.dart';
import 'package:giftpose/screens/main_view/widgets/listview.dart';
import 'package:giftpose/screens/onboarding/views/postcode_view.dart';
import 'package:giftpose/services/clipboard_service.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/services/network_services/network_response.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/router/utils.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/bottom_sheet.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';
import '../viewmodels/dashboard_viewmodel.dart';

class DashboardView extends StatefulWidget {
  DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final searchCtrl = TextEditingController();
  bool isList = false;
  final ScrollController _scrollController = ScrollController();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    searchCtrl.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(
        () => context.read<DashboardViewmodel>().fetchItemsNearMe(),
      );
      Future.microtask(() => context.read<DashboardViewmodel>().getDeviceId());
      Future.microtask(() => context.read<DashboardViewmodel>().getFcmToken());
      Future.microtask(
        () => context.read<DashboardViewmodel>().checkUserSession(context),
      );
      Future.microtask(
        () => context.read<DashboardViewmodel>().fetchAlertList(),
      );
      Future.microtask(
        () => context.read<DashboardViewmodel>().fetchCurrentSubscription(),
      );
      Future.microtask(
        () => context.read<DashboardViewmodel>().fetchSubscriptionList(),
      );

      Future.delayed(Duration(seconds: 2), () {});
    });
    Future.delayed(Duration(seconds: 2), () {
      _scrollController.addListener(_onScroll);
    });

    // Initial data fetch
  }

  /// REMOVE OVERLAY
  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// SHOW OVERLAY
  void showOverlay(DashboardViewmodel vm) {
    removeOverlay();

    _overlayEntry = _createOverlay(vm);

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// CREATE OVERLAY
  OverlayEntry _createOverlay(DashboardViewmodel vm) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 40,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 55),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: BoxConstraints(maxHeight: 250),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 0,
                itemBuilder: (context, index) {
                  // final item = vm.searchPredictionResponse.data?.data[index];

                  return ListTile(
                    title: Text( ""),
                    onTap: () {
                      if (!vm.selectedKeywords.contains("d")) {
                        // vm.toggleKeyword(item?.name ?? "");
                      }

                      // searchCtrl.text = item?.name ?? "";

                      removeOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchCtrl.dispose();
    _searchFocus.dispose();
    removeOverlay();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DashboardViewmodel>().loadNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8); // Load more at 80% scroll
  }

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: true,
      builder: (size) {
        return Consumer<DashboardViewmodel>(
          builder: (context, viewModel, child) {
            print(viewModel.fcmToken);
            return RefreshIndicator(
              onRefresh: viewModel.refreshItems,
              color: GiftPoseColors.primaryColor,
              child: Column(
                children: [
                  YMargin(35),

                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            viewModel.miles =
                                viewModel
                                    .fetchItemsNearMeResponse
                                    .data
                                    ?.userLocation
                                    .setMile ??
                                15;
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.settingsPage,
                            );
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
                              padding: EdgeInsets.all(12.0),
                              child: Assets.icons.settingsicon.svg(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                        ),
                        Text("All Gifts".tr(context),
                          style: GiftPoseTextStyle.normal(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isList = !isList;
                                });
                              },
                              child: !isList
                                  ? Assets.icons.grid.svg(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    )
                                  : Assets.icons.hamburger.svg(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                            ),
                            XMargin(28),
                           Stack(
  clipBehavior: Clip.none,
  children: [
    InkWell(
      onTap: () {
        HapticFeedback.heavyImpact();
        Navigator.pushNamed(
          context,
          AppRoutes.notificationsPage,
        );
      },
      child: Assets.icons.notificationIcon.svg(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    ),

    // 🔴 Badge
    viewModel.fetchNotificationResponse.data?.data.unreadCount ==0?SizedBox.shrink():
    Positioned(
      right: -4,
      top: -13,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        constraints: const BoxConstraints(
          minWidth: 18,
          minHeight: 18,
        ),
        child: Center(
          child: Text(
            (viewModel.fetchNotificationResponse.data?.data.unreadCount ?? 0).toString(), 
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ],
)
                          ],
                        ),
                      ],
                    ),
                  ),

                  YMargin(10),

                  // Search Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CompositedTransformTarget(
                      link: _layerLink,
                      child: GiftPoseTextField(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                        },
                        controller: searchCtrl,
                        focusNode: _searchFocus,
                        hintText: "Search for items",
                        prefixIcon: Assets.icons.search.svg(),
                        textFieldBottomPadding: 15,
                      ),
                    ),
                  ),



                  // Location Row
                  InkWell(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PostcodeScreen(fromDashboard: true),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.location.svg(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        XMargin(3),
                        Text(
                          viewModel
                                  .fetchItemsNearMeResponse
                                  .data
                                  ?.userLocation
                                  .postcode ??
                              "Update Location",
                          textAlign: TextAlign.center,
                          style: GiftPoseTextStyle.medium(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        XMargin(3),
                        Assets.icons.down.svg(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ],
                    ),
                  ),

                  YMargin(15),

                  //    Notification Banner
                  InkWell(
                    onTap: () {
                      viewModel.fetchAlertCategory();
                      HapticFeedback.heavyImpact();

                      Navigator.pushNamed(
                        context,
                        AppRoutes.notificationsAlert,
                      );

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 17.0,
                        vertical: 16.0,
                      ),
                      color: GiftPoseColors.containerBackground,
                      child: Row(
                        children: [
                          Assets.icons.not.svg(),
                          XMargin(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Get notified on items of interest".tr(context),
                                  style: GiftPoseTextStyle.normal(
                                    fontSize: 14,
                                    color: GiftPoseColors.textColor3,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                YMargin(4),
                     
                               Text(
  (() {
    final response = viewModel.fetchAlertListResponse;
    final list = response?.data?.data;

    if (list == null || list.isEmpty) {
      return "You are currently receiving all alerts. Click to get alerts ONLY for gifts you want to find."
          .tr(context);
    }

    final keywords = list.first.keywords;

    if (keywords == null || keywords.isEmpty) {
      return "You are currently receiving all alerts. Click to get alerts ONLY for gifts you want to find."
          .tr(context);
    }

    return "Active".tr(context) +
        ": ${keywords.join(", ")}";
  })(),

                                  style: GiftPoseTextStyle.small(
                                    fontSize: 10,
                                    color: GiftPoseColors.textColor2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Assets.icons.foward.svg(),
                        ],
                      ),
                    ),
                  ),

                  // Content Area (Grid or List with pagination)
                  Expanded(child: _buildContent(viewModel)),

                  YMargin(18),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildContent(DashboardViewmodel viewModel) {
    List<FetchItemsNearMeData> displayItems = viewModel.items;
    if (searchCtrl.text.isNotEmpty) {
      final query = searchCtrl.text.toLowerCase();
      displayItems = displayItems.where((item) {
        return (item.name?.toLowerCase().contains(query) ?? false) ||
               (item.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Handle loading state
    if (isApiResponseLoading(viewModel.fetchItemsNearMeResponse) &&
        viewModel.items.isEmpty) {
      return Center(
        child: CircularProgressIndicator(color: GiftPoseColors.primaryColor),
      );
    }

    // Handle error state
    if (viewModel.fetchItemsNearMeResponse.status == false &&
        viewModel.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            YMargin(16),
            Text('Error: '.tr(context),
              style: GiftPoseTextStyle.medium(),
              textAlign: TextAlign.center,
            ),
            YMargin(16),
            ElevatedButton(
              onPressed: () => viewModel.refreshItems(),
              style: ElevatedButton.styleFrom(
                backgroundColor: GiftPoseColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Retry'.tr(context)),
            ),
          ],
        ),
      );
    }

    // Handle empty state
    if (displayItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            YMargin(16),
            Text('No items found'.tr(context), style: GiftPoseTextStyle.large()),
            YMargin(8),
            Text('Try adjusting your search or location'.tr(context),
              style: GiftPoseTextStyle.small(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final defaultLocation = UserLocation(
      deviceId: viewModel.deviceId ?? "",
      postcode: "Update Location",
      city: "",
      setMile: 15,
    );
    final userLocation = viewModel.fetchItemsNearMeResponse.data?.userLocation ?? defaultLocation;

    // Show grid or list with pagination
    if (isList) {
      return ListViewWidget(
        scrollController: _scrollController,
        userLocation: userLocation,
        hasReachedMax: viewModel.hasReachedMax,
        isLoadingMore: viewModel.isLoadingMore,
        // items: displayItems,
      );
    } else {
      return CategoryGrid(
        userLocation: userLocation,
        scrollController: _scrollController,
        items: displayItems,
        hasReachedMax: viewModel.hasReachedMax,
        isLoadingMore: viewModel.isLoadingMore,
        crossAxisCount: 2,
        childAspectRatio: 0.78,
        spacing: 8,
      );
    }
  }
}

class CategoryProducts {
  final AssetGenImage icon;
  final String name;
  final String location;

  CategoryProducts({
    required this.icon,
    required this.name,
    required this.location,
  });
}

final List<CategoryProducts> categories = [
  CategoryProducts(
    icon: Assets.images.dash1,
    name: 'Phones',
    location: "United Kingdom",
  ),
  CategoryProducts(
    icon: Assets.images.dash2,
    name: 'Phone Accessories',
    location: "United Kingdom",
  ),
  CategoryProducts(
    icon: Assets.images.dash3,
    name: 'Neatly Used Shoes ',
    location: "United Kingdom",
  ),
  CategoryProducts(
    icon: Assets.images.dash4,
    name: 'Neatly Used Shoes ',
    location: "United Kingdom",
  ),
];

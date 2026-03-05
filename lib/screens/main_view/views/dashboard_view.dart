// screens/main_view/views/dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/views/search_page.dart';
import 'package:giftpose/screens/main_view/widgets/allow_notification_widget.dart';
import 'package:giftpose/screens/main_view/widgets/gridview.dart';
import 'package:giftpose/screens/main_view/widgets/listview.dart';
import 'package:giftpose/screens/onboarding/views/postcode_view.dart';
import 'package:giftpose/services/network_services/network_response.dart';
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
  const DashboardView({super.key});

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardViewmodel>().fetchItemsNearMe();
          Future.microtask(() =>
    context.read<DashboardViewmodel>().getDeviceId()
  );


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
Future.delayed(const Duration(seconds: 2), () {
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
          offset: const Offset(0, 55),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 250),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount:
                    vm.searchPredictionResponse.data?.data.length ?? 0,
                itemBuilder: (context, index) {

                  final item =
                      vm.searchPredictionResponse.data?.data[index];

                  return ListTile(
                    title: Text(item?.name ?? ""),
                    onTap: () {

                      if (!vm.selectedKeywords.contains(item?.name)) {
                        vm.toggleKeyword(item?.name ?? "");
                      }
                      

                      searchCtrl.text = item?.name ?? "";

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
      hasGradient: true,
      builder: (size) {
        return Consumer<DashboardViewmodel>(
          builder: (context, viewModel, child) {
            return RefreshIndicator(
              onRefresh: viewModel.refreshItems,
              color: GiftPoseColors.primaryColor,
              child: Column(
                children: [
                  YMargin(25),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            viewModel.miles = viewModel.fetchItemsNearMeResponse.data?.userLocation.setMile?? 15;
                            HapticFeedback.selectionClick();
                            Navigator.pushNamed(context, AppRoutes.settingsPage);
                          },
                          child: Assets.icons.settingsicon.svg(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        Text(
                          "All Gifts",
                          style: GiftPoseTextStyle.large(fontWeight: FontWeight.w500),
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
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    )
                                  : Assets.icons.hamburger.svg(
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                            ),
                            XMargin(32),
                            InkWell(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                Navigator.pushNamed(context, AppRoutes.notificationsPage);
                          
                              },
                              child: Assets.icons.notificationIcon.svg(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  YMargin(24),

                  // Search Field
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CompositedTransformTarget(
                      link: _layerLink,
                      child: GiftPoseTextField(
                        readOnly: true,
                        onTap: (){
                   // Navigate to a new screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SearchView(isList: isList,)),
);
                          HapticFeedback.selectionClick();
                        },
                        controller: searchCtrl,
                        focusNode: _searchFocus,
                        hintText: "Search for items",
                        prefixIcon: Assets.icons.search.svg(),

                       
                      ),
                    ),
                  ),

                  YMargin(12),

                  // Location Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.location.svg(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                         XMargin(3),
                      Text(
                        viewModel.fetchItemsNearMeResponse.data?.userLocation.postcode?? "S1 2AH",
                        textAlign: TextAlign.center,
                        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
                      ),
                      XMargin(3),
                      InkWell(
                        onTap: (){
                          HapticFeedback.selectionClick();
                             Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => PostcodeScreen(fromDashboard: true,)),
);

                        },
                        child: Assets.icons.down.svg(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),

                  YMargin(20),

                  // Notification Banner
                  Container(
                    color: GiftPoseColors.containerBackground,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 17.0,
                        vertical: 20.0,
                      ),
                      leading: Assets.icons.not.svg(),
                      title: Text(
                        "Get notified on product of interest",
                        textAlign: TextAlign.center,
                        style: GiftPoseTextStyle.normal(
                          fontSize: 15,
                          color: GiftPoseColors.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "You are currently receiving all alerts. Click to get alerts ONLY for gifts you want to find.",
                        textAlign: TextAlign.justify,
                        style: GiftPoseTextStyle.small(
                          color:GiftPoseColors.textColor2,
                        ),
                      ),
                      trailing: Assets.icons.foward.svg(),
                    ),
                  ),

                  // Content Area (Grid or List with pagination)
                  Expanded(
                    child: _buildContent(viewModel),
                  ),

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
    // Handle loading state
    if (isApiResponseLoading(viewModel.fetchItemsNearMeResponse) && 
        viewModel.items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: GiftPoseColors.primaryColor,
        ),
      );
    }

    // Handle error state
    if (viewModel.fetchItemsNearMeResponse.status ==false &&
        viewModel.items.isEmpty) {

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const YMargin(16),
            Text(
              'Error: ',
              style: GiftPoseTextStyle.medium(),
              textAlign: TextAlign.center,
            ),
            const YMargin(16),
            ElevatedButton(
              onPressed: () => viewModel.refreshItems(),
              style: ElevatedButton.styleFrom(
                backgroundColor: GiftPoseColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Handle empty state
    if (viewModel.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            const YMargin(16),
            Text(
              'No items found',
              style: GiftPoseTextStyle.large(),
            ),
            const YMargin(8),
            Text(
              'Try adjusting your search or location',
              style: GiftPoseTextStyle.small(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Show grid or list with pagination
    if (isList) {
      return ListViewWidget(
        scrollController: _scrollController,
        userLocation: viewModel.fetchItemsNearMeResponse.data!.userLocation,
        hasReachedMax: viewModel.hasReachedMax,
        isLoadingMore: viewModel.isLoadingMore, 
      );
    } else {
      return CategoryGrid(
        userLocation: viewModel.fetchItemsNearMeResponse.data!.userLocation,
        scrollController: _scrollController,
        items: viewModel.items,
        hasReachedMax: viewModel.hasReachedMax,
        isLoadingMore: viewModel.isLoadingMore,
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        spacing: 16,
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

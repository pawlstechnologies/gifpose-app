// screens/main_view/views/dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/widgets/gridview.dart';
import 'package:giftpose/screens/main_view/widgets/listview.dart';
import 'package:giftpose/services/network_services/network_response.dart';
import 'package:giftpose/utils/router/utils.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
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
  final postcodeCtrl = TextEditingController();
  bool isList = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardViewmodel>().fetchItemsNearMe();
          Future.microtask(() =>
    context.read<DashboardViewmodel>().getDeviceId()
  );
 context.read<DashboardViewmodel>().fetchAlertCategory();

    });
Future.delayed(const Duration(seconds: 2), () {
 _scrollController.addListener(_onScroll);
});
   
 
    
    // Initial data fetch
  
  }

  @override
  void dispose() {
    _scrollController.dispose();
    postcodeCtrl.dispose();
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
                                viewModel.fetchAlertCategory();
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GiftPoseTextField(
                      controller: postcodeCtrl,
                      hintText: "Search for items",
                      prefixIcon: Assets.icons.search.svg(),
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
                                  Navigator.pushNamed(context, AppRoutes.postcodePage);
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
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "You are currently receiving all alerts. Click to get alerts ONLY for gifts you want to find.",
                        textAlign: TextAlign.justify,
                        style: GiftPoseTextStyle.small(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
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

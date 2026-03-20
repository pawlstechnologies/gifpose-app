import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/widgets/search_gridview.dart';
import 'package:giftpose/screens/main_view/widgets/search_listview.dart';
import 'package:giftpose/services/network_services/network_response.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  final bool isList;

  const SearchView({super.key, this.isList = false});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchCtrl = TextEditingController();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _searchFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();


@override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    FocusScope.of(context).requestFocus(_searchFocus);
  });
}
  @override
  void dispose() {
    searchCtrl.dispose();
    _searchFocus.dispose();
    _scrollController.dispose();
    removeOverlay();
    super.dispose();
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void showOverlay(DashboardViewmodel vm) {
    removeOverlay();
    _overlayEntry = _createOverlay(vm);
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlay(DashboardViewmodel vm) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 40,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
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
                shrinkWrap: true,
                itemCount: vm.searchPredictionResponse.data?.data.length ?? 0,
                itemBuilder: (context, index) {
                  final item = vm.searchPredictionResponse.data?.data[index];
                  return ListTile(
                    title: Text(item?.name ?? ""),
                    onTap: () {
                      vm.search(context: context, keywords: [item?.name ?? ""]);
                      if (!vm.selectedKeywords.contains(item?.name)) {
                        vm.toggleKeyword(item?.name ?? "");
                      }
                      searchCtrl.text = item?.name ?? "";
                      _searchFocus.unfocus();
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
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      includeHorizontalPadding: false,
      showAppBar: true,
      includeVerticalPadding: false,
      centerTitle: true,
      // CRITICAL: This must be true for the body to shrink when keyboard appears
      resizeToAvoidBottomInset: true, 
      appBarLeadingWidget:  InkWell(
            onTap: () {
             HapticFeedback.heavyImpact();
              Navigator.pop(context);
            },
            child: Container(
      width: 200,
  height: 100,
  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(20), // Adjust the value for more/less rounding
  ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Assets.icons.back.svg(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
      hasGradient: true,
      appBarTitleWidget: Text(
        "Global Search",
        textAlign: TextAlign.center,
        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
      ),
      builder: (size) {
        return Consumer<DashboardViewmodel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                const YMargin(20),

                // Search Bar Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: GiftPoseTextField(
                      controller: searchCtrl,
                      focusNode: _searchFocus,
                      hintText: "Search for items",
                      prefixIcon: Assets.icons.search.svg(),
                      onChanged: (value) async {
                        if (value.trim().length > 2) {
                          await viewModel.searchPrediction(
                            context: context,
                            keywords: [value.trim()],
                          );
                          if ((viewModel.searchPredictionResponse.data?.data ?? []).isNotEmpty) {
                            showOverlay(viewModel);
                          }
                        } else {
                          removeOverlay();
                        }
                      },
                    ),
                  ),
                ),

                const YMargin(20),

                // Results Section: Expanded makes it take ONLY what's left
                // between the search bar and the top of the keyboard.
                Expanded(
                  child: _buildContent(viewModel),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildContent(DashboardViewmodel viewModel) {
    // 1. Loading State
    if (isApiResponseLoading(viewModel.globalSearchResponse) &&
        viewModel.itemsSearch.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: GiftPoseColors.primaryColor),
      );
    }

    // 2. Error State
    if (viewModel.globalSearchResponse.status == false &&
        viewModel.itemsSearch.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const YMargin(16),
            Text('Error: Try again', style: GiftPoseTextStyle.medium()),
            const YMargin(16),
            ElevatedButton(
              onPressed: () => viewModel.refreshItems(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // 3. Empty State
    if (viewModel.itemsSearch.isEmpty) {
      return Center(
        child: SingleChildScrollView( // Allows "No items found" to be scrollable if keyboard is huge
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No items found', style: GiftPoseTextStyle.large()),
              const YMargin(8),
              Text('Try adjusting your search', style: GiftPoseTextStyle.small(color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    // 4. Data Display (The Grid/List already have their own ScrollControllers)
    return widget.isList
        ? ListViewSearchWidget(
            scrollController: _scrollController,
            userLocation: viewModel.fetchItemsNearMeResponse.data?.userLocation.city,
            hasReachedMax: viewModel.hasReachedMax,
            isLoadingMore: viewModel.isLoadingMore,
            items: viewModel.itemsSearch,
          )
        : CategoryGridSearch(
            userLocation: viewModel.fetchItemsNearMeResponse.data?.userLocation.city,
            scrollController: _scrollController,
            items: viewModel.itemsSearch,
            hasReachedMax: viewModel.hasReachedMax,
            isLoadingMore: viewModel.isLoadingMore,
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            spacing: 16,
          );
  }
}
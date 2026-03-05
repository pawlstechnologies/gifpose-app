import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/widgets/gridview.dart';
import 'package:giftpose/screens/main_view/widgets/listview.dart';
import 'package:giftpose/screens/main_view/widgets/search_gridview.dart';
import 'package:giftpose/screens/main_view/widgets/search_listview.dart';
import 'package:giftpose/services/network_services/network_response.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
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
  void dispose() {
    searchCtrl.dispose();
    _searchFocus.dispose();
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
                      vm.search(context: context, keywords: [item?.name ?? ""]);

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
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      includeHorizontalPadding: false,
      showAppBar: true,
      includeVerticalPadding: false,
      centerTitle: true,
      appBarLeadingWidget: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Assets.icons.back.svg(
          color: Theme.of(context).textTheme.bodyLarge?.color,
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
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [

                const YMargin(40),

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

                          if ((viewModel.searchPredictionResponse.data?.data ?? [])
                              .isNotEmpty) {
                            showOverlay(viewModel);
                          }

                        } else {
                          removeOverlay();
                        }
                      },
                    ),
                  ),
                ),

                const YMargin(30),

                /// FIX: give child scrollable a height
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
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

    if (isApiResponseLoading(viewModel.globalSearchResponse) &&
        viewModel.itemsSearch.isEmpty) {

      return const Center(
        child: CircularProgressIndicator(
          color: GiftPoseColors.primaryColor,
        ),
      );
    }

    if (viewModel.globalSearchResponse.status == false &&
        viewModel.itemsSearch.isEmpty) {

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

    if (viewModel.itemsSearch.isEmpty) {

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

    if (widget.isList) {

      return ListViewSearchWidget(
        scrollController: _scrollController,
        userLocation: viewModel.fetchItemsNearMeResponse.data?.userLocation.city,
        hasReachedMax: viewModel.hasReachedMax,
        isLoadingMore: viewModel.isLoadingMore,
        items: viewModel.itemsSearch,
      );

    } else {

      return CategoryGridSearch(
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
}
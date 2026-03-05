import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/services/network_services/network_response.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_switch.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class NotificationAlert extends StatefulWidget {
  const NotificationAlert({super.key});

  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  bool push = false;
  final searchCtrl = TextEditingController();

  /// LOCAL SEARCH LIST
  List filteredCategories = [];

  /// Overlay variables
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _searchFocus = FocusNode();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final vm = context.read<DashboardViewmodel>();

      await vm.fetchAlertCategory();

      vm.selectedKeywords.clear();

      setState(() {
        filteredCategories =
            vm.fetchAlertCategoryResponse.data?.data.data ?? [];
      });
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    _searchFocus.dispose();
    removeOverlay();
    super.dispose();
  }

  /// LOCAL CATEGORY SEARCH
  void _localCategorySearch(String query, List categories) {
    if (query.isEmpty) {
      setState(() {
        filteredCategories = categories;
      });
      return;
    }

    setState(() {
      filteredCategories = categories.where((category) {
        final name = (category.name ?? "").toLowerCase();

        return name.contains(query.toLowerCase());
      }).toList();
    });
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

                itemCount: vm.searchPredictionResponse.data?.data.length ?? 0,

                itemBuilder: (context, index) {
                  final item = vm.searchPredictionResponse.data?.data[index];

                  return ListTile(
                    title: Text(item?.name ?? ""),

                    onTap: () {
                      final categories =
                          vm.fetchAlertCategoryResponse.data?.data.data ?? [];

                      _localCategorySearch(searchCtrl.text, categories);
                      if (!vm.selectedKeywords.contains(item?.name)) {
                        // vm.toggleKeyword(item?.name ?? "");
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
    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
        final categories = vm.fetchAlertCategoryResponse.data?.data.data ?? [];

        final isLoading = isApiResponseLoading(vm.fetchAlertCategoryResponse);

        final isSubCategoryLoading = isApiResponseLoading(
          vm.fetchAlertSubCategoryResponse,
        );

        return GiftPoseBaseScaffold(
          includeHorizontalPadding: false,
          includeVerticalPadding: false,
          showAppBar: true,
          centerTitle: true,
          hasGradient: true,

          appBarLeadingWidget: InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.pop(context);
            },
            child: Assets.icons.back.svg(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),

          appBarTitleWidget: Text(
            "Notification Alert",
            style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
          ),

          builder: (size) {
            return RefreshIndicator(
              onRefresh: () async {
                await vm.fetchAlertCategory();

                setState(() {
                  filteredCategories =
                      vm.fetchAlertCategoryResponse.data?.data.data ?? [];
                });
              },

              color: GiftPoseColors.primaryColor,

              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),

                children: [
                  const YMargin(14),

                  /// SMART ASSISTANT
                  Container(
                    color: GiftPoseColors.yelloColor,

                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 20,
                      ),

                      leading: Assets.images.star.image(),

                      title: Text(
                        "Smart Assistant",
                        style: GiftPoseTextStyle.normal(
                          color: GiftPoseColors.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      subtitle: Text(
                        "Let our AI assistant notify you with similar items.",
                        style: GiftPoseTextStyle.small(
                          color: GiftPoseColors.textColor2,
                        ),
                      ),

                      trailing: GiftPoseSwitch(
                        value: push,
                        onChanged: (value) {
                          setState(() => push = value);
                        },
                      ),
                    ),
                  ),

                  const YMargin(20),

                  /// SEARCH FIELD
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
                          if (value.length < 1) {
                            removeOverlay();
                          }

                          final categories =
                              vm.fetchAlertCategoryResponse.data?.data.data ??
                              [];
                          _localCategorySearch(value, categories);

                          if (value.trim().length > 2) {
                            await vm.searchPrediction(
                              context: context,
                              keywords: [value.trim()],
                            );

                            if ((vm.searchPredictionResponse.data?.data ?? [])
                                .isNotEmpty) {
                              showOverlay(vm);
                            }
                          } else {
                            removeOverlay();
                          }
                        },
                      ),
                    ),
                  ),

                  const YMargin(20),

                  /// SELECTED KEYWORDS
                  if (vm.selectedKeywords.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),

                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,

                        children: vm.selectedKeywords.map((keyword) {
                          return GestureDetector(
                            onTap: () {
                              vm.toggleKeyword(keyword);
                            },

                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10,
                              ),

                              decoration: BoxDecoration(
                                color: GiftPoseColors.greenColor,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: GiftPoseColors.primaryColor,
                                ),
                              ),

                              child: Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Text(
                                    keyword,
                                    style: GiftPoseTextStyle.medium(
                                      color: GiftPoseColors.primaryColor,
                                    ),
                                  ),

                                  const XMargin(10),

                                  Assets.icons.x.svg(height: 20, width: 20),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  const YMargin(20),

                  /// CATEGORIES TITLE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          "Categories",
                          style: GiftPoseTextStyle.normal(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const XMargin(20),
                        Assets.icons.line.svg(),
                      ],
                    ),
                  ),

                  Divider(color: Theme.of(context).dividerColor),

                  const YMargin(20),

                  /// CATEGORY + SUBCATEGORY PANEL
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildCategoryList(
                            vm,
                            filteredCategories,
                            isLoading,
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: _buildSubCategoryPanel(
                            vm,
                            isSubCategoryLoading,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const YMargin(20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GiftPoseButton(
                      title: "Submit",
                      onTap: () {
                        HapticFeedback.selectionClick();

                        vm.createNotificationAlerts(
                          context: context,
                          categories: vm.selectedCategory,
                          keywords: vm.selectedKeywords,
                          status: "active",
                        );
                      },
                    ),
                  ),

                  const YMargin(30),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// CATEGORY LIST
  Widget _buildCategoryList(
    DashboardViewmodel vm,
    List categories,
    bool isLoading,
  ) {
    if (isLoading && categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final options = categories[index];

        return GestureDetector(
          onTap: () {
            vm.selectOption(index);

            vm.fetchAlertSubCategory(categoryId: options.id ?? "");

            vm.selectedCategory.add(options.name);
          },

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),

            child: Row(
              children: [
                if (vm.selectedIndex == index) ...[
                  Assets.icons.lineh.svg(color: GiftPoseColors.primaryColor),
                  const SizedBox(width: 10),
                ],

                Expanded(
                  child: Text(
                    options.name ?? "Category",
                    style: GiftPoseTextStyle.small(
                      color: vm.selectedIndex == index
                          ? GiftPoseColors.primaryColor
                          : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// SUBCATEGORY PANEL
  Widget _buildSubCategoryPanel(
    DashboardViewmodel vm,
    bool isSubCategoryLoading,
  ) {
    final subcategories =
        vm.fetchAlertSubCategoryResponse.data?.data.subcategories ?? [];

    if (isSubCategoryLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (subcategories.isEmpty) {
      return Center(
        child: Text(
          "No Notification Preference Set Yet",
          style: GiftPoseTextStyle.small(),
        ),
      );
    }

    return ListView.builder(
      itemCount: subcategories.length,

      itemBuilder: (context, index) {
        final options = subcategories[index];
        final contents = options.contents ?? [];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                options.name ?? "",
                style: GiftPoseTextStyle.small(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),

              const YMargin(8),

              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: contents.map<Widget>((content) {
                  final isSelected = vm.selectedKeywords.contains(content.name);

                  return GestureDetector(
                    onTap: () {
                      vm.toggleKeyword(content.name ?? "");
                    },

                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),

                      child: Text(
                        content.name ?? "",
                        style: GiftPoseTextStyle.medium(
                          color: isSelected
                              ? Theme.of(context).textTheme.bodyMedium?.color
                              : Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

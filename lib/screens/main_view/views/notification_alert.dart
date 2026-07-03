import 'dart:async';
import 'package:giftpose/screens/main_view/widgets/premium_feature_modal.dart';
import 'package:giftpose/utils/localization_provider.dart';

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
  NotificationAlert({super.key});

  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  bool push = true;
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
          offset: Offset(0, 55),

          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),

            child: Consumer<DashboardViewmodel>(
              builder: (context, vm, child) {
                final contents = vm.searchPredictionResponse.data?.data.contents ?? [];
                return Container(
                  constraints: BoxConstraints(maxHeight: 250),

                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (contents.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: contents.length,

                            itemBuilder: (context, index) {
                              final item = contents[index];

                              return ListTile(
                                title: Text(item.name),

                                onTap: () {
                                  if (!vm.selectedKeywords.contains(item.name)) {
                                    vm.toggleKeyword(item.name);
                                  }
                                  removeOverlay();
                                },
                              );
                            },
                          ),
                        ),
                      if (searchCtrl.text.trim().isNotEmpty) ...[
                        if (contents.isNotEmpty)
                          Divider(height: 1, color: Theme.of(context).dividerColor),
                        ListTile(
                          leading: Icon(Icons.add, color: GiftPoseColors.primaryColor),
                          title: Text(
                            "Add keyword: \"${searchCtrl.text.trim()}\"",
                            style: TextStyle(
                              color: GiftPoseColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            final keyword = searchCtrl.text.trim();
                            if (keyword.isNotEmpty) {
                              bool added = true;
                              if (!vm.selectedKeywords.contains(keyword)) {
                                added = vm.toggleKeyword(keyword);
                              }
                              if (added) {
                                vm.createAlertList(
                                  selectedCategory: vm.selectedCategory,
                                  selectedKeywords: vm.selectedKeywords,
                                );
                              }
                            }
                            removeOverlay();
                          },
                        ),
                      ],
                    ],
                  ),
                );
              },
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
                padding: EdgeInsets.all(14.0),
                child: Assets.icons.back.svg(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),

          appBarTitleWidget:

           Text("Gift Notification".tr(context),
        style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
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
                physics: AlwaysScrollableScrollPhysics(),

                children: [
                  YMargin(14),

                  /// SMART ASSISTANT
                  Container(
                    color: GiftPoseColors.yelloColor,

                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 6,
                      ),

                      leading: Assets.images.star.image(),

                      title: Text("Smart Notifier".tr(context),
                        style: GiftPoseTextStyle.normal(
                          color: GiftPoseColors.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      subtitle: Text("Let our AI assistant notify you with similar items.".tr(context),
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

                  YMargin(20),

                  /// SEARCH FIELD
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),

                    child: CompositedTransformTarget(
                      link: _layerLink,

                      child: GiftPoseTextField(
                        controller: searchCtrl,
                        focusNode: _searchFocus,
                        hintText: "Enter the keyword you want to be notified of",
                        prefixIcon: Assets.icons.search.svg(),

                        onChanged: (value) async {
                          final trimmed = value.trim();
                          if (trimmed.isEmpty) {
                            removeOverlay();
                            return;
                          }

                          showOverlay(vm);

                          if (trimmed.length > 2) {
                            await vm.searchPrediction(
                              context: context,
                              keywords: [trimmed],
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  

                  /// SELECTED KEYWORDS
                  if (vm.selectedKeywords.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),

                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,

                        children: vm.selectedKeywords.map((keyword) {
            return InkWell(
onTap: () {
  // Capture the boolean here!
  final bool canAdd = vm.toggleKeyword(keyword);
  
  print("UI RECEIVED: $canAdd"); // If you don't see this, this code isn't running

  if (!canAdd) {
    print("TRIGGERING MODAL");
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PremiumFeaturesModal(),
    );
  }
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

                                  XMargin(10),

                                  Assets.icons.x.svg(height: 20, width: 20),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  YMargin(20),

                  /// CATEGORIES TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("Categories".tr(context),
                          style: GiftPoseTextStyle.normal(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        XMargin(20),
                        Assets.icons.line.svg(),
                      ],
                    ),
                  ),

                  Divider(color: Theme.of(context).dividerColor),

                  YMargin(20),

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

                  YMargin(20),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GiftPoseButton(
                      title: "Submit",
                      onTap: () {
                       HapticFeedback.heavyImpact();

                        vm.createNotificationAlerts(
                          context: context,
                          categories: vm.selectedCategory,
                          keywords: vm.selectedKeywords,
                          status: "active",
                        );
                      },
                    ),
                  ),

                  YMargin(30),
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
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final optionsCat = categories[index];

        return GestureDetector(
          onTap: () {
            vm.selectOption(index);

            vm.fetchAlertSubCategory(categoryId: optionsCat.id ?? "".tr(context));

            vm.selectedCategory.add(optionsCat.id);
          },

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),

            child: Row(
              children: [
                if (vm.selectedIndex == index) ...[
                  Assets.icons.lineh.svg(color: GiftPoseColors.primaryColor),
                  SizedBox(width: 10),
                ],

                Expanded(
                  child: Text(
                    optionsCat.name ?? "Category",
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
      return Center(child: CircularProgressIndicator());
    }

    if (subcategories.isEmpty) {
      return Center(
        child: Column(
          children: [
            Assets.icons.emptyNot.svg(),
            YMargin(5),
            Text("No Notification Preference Set Yet".tr(context),
              style: GiftPoseTextStyle.small(),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: subcategories.length,

      itemBuilder: (context, index) {
        final options = subcategories[index];
        final contents = options.contents ?? [];

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                options.name ?? "",
                style: GiftPoseTextStyle.small(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),

              YMargin(8),

              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: contents.map<Widget>((content) {
                  final isSelected = vm.selectedKeywords.contains(content.name);

                  return GestureDetector(
                    onTap: () {
                      vm.toggleKeyword(content.name ?? "".tr(context));
                    },

                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
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

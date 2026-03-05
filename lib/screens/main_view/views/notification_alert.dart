import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/services/network_services/network_response.dart';
import 'package:giftpose/utils/mediaquery.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
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

  @override
  void initState() {
    super.initState();

    /// Call API after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardViewmodel>().fetchAlertCategory();
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
        /// Safe data extraction with null checks
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
              onRefresh: () => vm.fetchAlertCategory(),
              color: GiftPoseColors.primaryColor,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const YMargin(14),

                  /// Smart Assistant Banner
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
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "Let our AI assistant notify you with similar items.",
                        style: GiftPoseTextStyle.small(),
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

                  /// Search
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GiftPoseTextField(
                      controller: searchCtrl,
                      hintText: "Search for items",
                      prefixIcon: Assets.icons.search.svg(),
                    ),
                  ),

                  const YMargin(20),

                  Text(
                    "Your Selected Keywords",
                    style: GiftPoseTextStyle.normal(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

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
                        XMargin(20),
                        Assets.icons.line.svg(),
                      ],
                    ),
                  ),
                  Divider(color: Theme.of(context).dividerColor),

                  const YMargin(20),

                  /// Categories and Subcategories Section
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// LEFT SIDE – CATEGORY LIST
                        Expanded(
                          flex: 1,
                          child: _buildCategoryList(vm, categories, isLoading),
                        ),

                        /// RIGHT SIDE – SUBCATEGORY PANEL
                        Expanded(
                          flex: 2,
                          child: _buildSubCategoryPanel(vm, isSubCategoryLoading),
                        ),
                      ],
                    ),
                  ),

                  const YMargin(20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Category List Builder
  Widget _buildCategoryList(
    DashboardViewmodel vm,
    List<dynamic> categories,
    bool isLoading,
  ) {
    if (isLoading && categories.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (categories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'No categories available',
            style: GiftPoseTextStyle.small(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final options = categories[index];

        return GestureDetector(
          onTap: () {
            vm.selectOption(index);
            vm.fetchAlertSubCategory(categoryId: options.id ?? "");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            child: Row(
              children: [
                if (vm.selectedIndex == index) ...[
                  Assets.icons.lineh.svg(
                    color: GiftPoseColors.primaryColor,
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    options.name ?? "Category",
                    style: GiftPoseTextStyle.small(
                      color: vm.selectedIndex == index
                          ? GiftPoseColors.primaryColor
                          : Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: vm.selectedIndex == index
                          ? FontWeight.w500
                          : FontWeight.w400,
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

  /// SubCategory Panel Builder - FIXED (only the crashing part)
  Widget _buildSubCategoryPanel(
    DashboardViewmodel vm,
    bool isSubCategoryLoading,
  ) {
    final subcategories = vm.fetchAlertSubCategoryResponse.data?.data.subcategories ?? [];
    
    if (vm.selectedIndex == -1) {
      return const Center(
        child: Text('Select a category'),
      );
    }

    if (isSubCategoryLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (subcategories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.emptyNot.svg(),
            const YMargin(10),
            Text(
              'No Notification Preference Set Yet',
              style: GiftPoseTextStyle.small(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: subcategories.length,
      itemBuilder: (context, index) {
        final options = subcategories[index];
        final contents = options.contents ?? [];

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                options.name ?? "",
                style: GiftPoseTextStyle.small(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const YMargin(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(contents.length, (indexs) {
                  final content = contents[indexs];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10,
                    ),
                    child: Text(
                      content.name ?? "",
                      style: GiftPoseTextStyle.small(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
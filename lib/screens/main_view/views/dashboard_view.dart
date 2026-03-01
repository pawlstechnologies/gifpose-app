import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/widgets/gridview.dart';
import 'package:giftpose/screens/main_view/widgets/listview.dart';
import 'package:giftpose/utils/router/utils.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class DashboardView extends StatefulWidget {
  DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final postcodeCtrl = TextEditingController();
  bool isList = false;

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      hasGradient: true,

      builder: (size) {
        return Column(
          children: [
            YMargin(25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   InkWell(
                        onTap: (){
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
                          isList = !isList;
                          setState(() {});
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
                      XMargin(32),
                      InkWell(
                        onTap: (){
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GiftPoseTextField(
                controller: postcodeCtrl,
                hintText: "Search for items",
                prefixIcon: Assets.icons.search.svg(),
              ),
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.location.svg(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                Text(
                  "S1 2AH ",
                  textAlign: TextAlign.center,

                  style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
                ),
                Assets.icons.down.svg(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ],
            ),

            YMargin(20),

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
                  "You are currently receiving all alerts. Click to  get alerts ONLY for gifts you want to find.",
                  textAlign: TextAlign.justify,

                  style: GiftPoseTextStyle.small(
                   color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                trailing: Assets.icons.foward.svg(),
              ),
            ),
            Expanded(
              child:
              isList?
              ListViewWidget(categories: categories):
               CategoryGrid(
                categories: categories,
                crossAxisCount: 2, // 2 columns
                childAspectRatio: 0.8, // Adjust based on your content
                spacing: 16,
              ),
            ),

            YMargin(18),
          ],
        );
      },
    );
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/views/details_page.dart';
import 'package:giftpose/screens/onboarding/models/notification_response.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/network_data_response.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime _dateOnlyLocal(DateTime dt) {
  final local = dt.toLocal();
  return DateTime(local.year, local.month, local.day);
}

class _NotificationSection {
  _NotificationSection(this.title, this.items);
  final String title;
  final List<Notifications> items;
}

List<_NotificationSection> _groupNotificationsByDate(
  BuildContext context,
  List<Notifications> notifications,
) {
  if (notifications.isEmpty) return [];

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  final sorted = List<Notifications>.from(notifications)
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  final todayItems = <Notifications>[];
  final yesterdayItems = <Notifications>[];
  final older = <DateTime, List<Notifications>>{};

  for (final n in sorted) {
    final d = _dateOnlyLocal(n.createdAt);
    if (d == today) {
      todayItems.add(n);
    } else if (d == yesterday) {
      yesterdayItems.add(n);
    } else {
      older.putIfAbsent(d, () => []).add(n);
    }
  }

  final sections = <_NotificationSection>[];
  if (todayItems.isNotEmpty) {
    sections.add(_NotificationSection('Today'.tr(context), todayItems));
  }
  if (yesterdayItems.isNotEmpty) {
    sections.add(_NotificationSection('Yesterday'.tr(context), yesterdayItems));
  }

  final locale = Localizations.localeOf(context).toString();
  final dateFormat = DateFormat.yMMMd(locale);
  final olderDates = older.keys.toList()..sort((a, b) => b.compareTo(a));
  for (final d in olderDates) {
    sections.add(_NotificationSection(dateFormat.format(d), older[d]!));
  }

  return sections;
}

class NotificationView extends StatefulWidget {
  NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DashboardViewmodel>().fetchNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
       return Consumer<DashboardViewmodel>(
          builder: (context, vm, child) {
        return GiftPoseBaseScaffold(
          includeHorizontalPadding: false,
        
          showAppBar: true,
          includeVerticalPadding: false,
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
          appBarTitleWidget: Text("Notification".tr(context),
            textAlign: TextAlign.center,
        
         style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
          ),
        
          builder: (size) {
            final notifications =
                vm.fetchNotificationResponse.data?.data.notifications ?? [];
       

            if (vm.fetchNotificationResponse.status == Status.LOADING) {
              return Center(
                child: CircularProgressIndicator(
                  color: GiftPoseColors.primaryColor,
                  strokeWidth: 2,
                ),
              );
            }

            if (notifications.isEmpty) {
              return Center(
                child: Text(
                  'No notifications'.tr(context),
                  style: GiftPoseTextStyle.medium(),
                ),
              );
            }

            final sections = _groupNotificationsByDate(context, notifications);
            final location =
                vm.fetchItemsNearMeResponse.data?.userLocation.city;

            return ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                for (var s = 0; s < sections.length; s++) ...[
                  if (s > 0) YMargin(20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      sections[s].title,
                      style: GiftPoseTextStyle.medium(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  YMargin(10),
                  for (var i = 0; i < sections[s].items.length; i++) ...[
                    if (i > 0) YMargin(12),
                    InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        final data = sections[s].items[i];
                        vm.fetchItemsById(id: data.data.itemId).whenComplete(() {
                          if (vm.fetchItemsByIdMeResponse.data?.success ==
                                  true &&
                              vm.fetchItemsByIdMeResponse.data!.data.imageUrls
                                  .isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(location: location),
                              ),
                            );
                          }
                        });
                      },
                      child: CategoryListItem(response: sections[s].items[i]),
                    ),
                  ],
                ],
              ],
            );
          },
        );
      }
    );
  }
}
// Individual List Item Widget

class CategoryListItem extends StatelessWidget {
  final Notifications response;


  CategoryListItem({super.key, required this.response, });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: response.img?? '',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade200,
                child: Icon(Icons.error, color: Colors.grey),
              ),
              placeholder: (context, url) => Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade100,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    response.title,
                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  YMargin(8),

                  // Location with Icon
                  Row(
                    children: [
                      Assets.icons.location.svg(
                        height: 14,
                        width: 14,
                      ),
                      XMargin(4),
                      Expanded(
                        child: Text(
               response.message,
                          style: GiftPoseTextStyle.small(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  YMargin(8),

         
               
                ],
              ),
            ),
          ),

          // Arrow Icon
          Padding(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
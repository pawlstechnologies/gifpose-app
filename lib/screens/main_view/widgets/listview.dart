import 'package:cached_network_image/cached_network_image.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/network_data_response.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/views/details_page.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/premiumcard_list.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class PremiumUpgradeCard extends StatelessWidget {
  final VoidCallback? onTap;

  const PremiumUpgradeCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFE5CC), Color(0xFFF5D3E9), Color(0xFFD6C7FF)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 54.w,
              height: 54.h,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF9F5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.diamond_outlined,
                  color: const Color(0xFFC2942E),
                  size: 28.r,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Upgrade To Premium",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111625),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Enjoy smarter tracking, insights, and ads free experience.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4A5163),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF6B7280),
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumProCard extends StatelessWidget {
  final VoidCallback? onTap;

  const PremiumProCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        if (onTap != null) onTap!();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFEF9E7),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFF1C40F).withOpacity(0.4),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD98C00).withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Stack(
          children: [
            Positioned(
              right: -10.w,
              bottom: -25.h,
              child: Icon(
                Icons.star,
                size: 90.r,
                color: const Color(0xFFFFF2CC).withOpacity(0.8),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Premium Pro",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7E5109),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: const Color(0xFF7E5109),
                      size: 16.r,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                _buildBullet("Unlimited early access"),
                SizedBox(height: 6.h),
                _buildBullet("Priority notifications"),
                SizedBox(height: 6.h),
                _buildBullet("Dedicated support"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Row(
      children: [
        Container(
          width: 5.w,
          height: 5.h,
          decoration: const BoxDecoration(
            color: Color(0xFFD4AC0D),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9A7D0A),
          ),
        ),
      ],
    );
  }
}

class ListViewWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final UserLocation userLocation;
  final bool hasReachedMax;
  final bool isLoadingMore;

  ListViewWidget({
    super.key,
    this.scrollController,
    required this.hasReachedMax,
    required this.isLoadingMore,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    const int firstPromoIndex = 2;
    const int secondPromoIndex = 7;

    return Consumer<DashboardViewmodel>(
      builder: (context, dashVM, child) {
        final items = dashVM.items;

        if (items.isEmpty) {
          return Center(child: Text('No items available'.tr(context)));
        }

        final bool isSubscribed = dashVM.isSubscribed;
        final bool isLoading =
            dashVM.fetchItemsNearMeResponse.status == Status.LOADING;
        final bool showPromo1 =
            !isSubscribed && !isLoading && items.length > firstPromoIndex;
        final bool showPromo2 =
            !isSubscribed &&
            !isLoading &&
            items.length > (secondPromoIndex - 1);

        int totalItemCount = items.length;
        if (showPromo1) totalItemCount += 1;
        if (showPromo2) totalItemCount += 1;
        if (!hasReachedMax) totalItemCount += 1;

        return ListView.separated(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: totalItemCount,
          separatorBuilder: (context, index) => const YMargin(12),
          itemBuilder: (context, index) {
            // 1. First Promo Card
            if (showPromo1 && index == firstPromoIndex) {
              return PremiumProCardListview(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.pushNamed(context, AppRoutes.premiumSubscription);
                },
              );
            }

            // 2. Second Promo Card (PremiumProCard)
            if (showPromo2 && index == secondPromoIndex) {
              return PremiumProCardListview(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.pushNamed(context, AppRoutes.premiumSubscription);
                },
              );
            }

            // Calculate tracking structural map offset shifts
            int dataIndex = index;
            if (showPromo1 && index > firstPromoIndex) {
              dataIndex--;
            }
            if (showPromo2 && index > secondPromoIndex) {
              dataIndex--;
            }

            // 3. Dynamic Footer Loading Indicator
            if (dataIndex >= items.length) {
              return _buildLoadingIndicator();
            }

            // 4. Standard List Item Card Feed Row
            final data = items[dataIndex];
            return InkWell(
              onTap: () {
                HapticFeedback.heavyImpact();
                dashVM.fetchItemsById(id: data.id).whenComplete(() {
                  if (dashVM.fetchItemsByIdMeResponse.data?.success == true &&
                      dashVM
                          .fetchItemsByIdMeResponse
                          .data!
                          .data
                          .imageUrls
                          .isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsPage(location: userLocation.city),
                      ),
                    );
                  }
                });
              },
              child: CategoryListItem(
                response: data,
                userLocation: userLocation,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    if (!isLoadingMore) return const SizedBox.shrink();

    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator(
          color: GiftPoseColors.primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final FetchItemsNearMeData response;
  final UserLocation userLocation;

  CategoryListItem({
    super.key,
    required this.response,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: response.thumbnail ?? '',
              height: 110.h,
              width: 150.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 110.h,
                width: 150.w,
                color: Colors.grey.shade200,
                child: const Icon(Icons.error, color: Colors.grey),
              ),
              placeholder: (context, url) => Container(
                height: 110.h,
                width: 150.w,
                color: Colors.grey.shade100,
                child: const Center(child: CupertinoActivityIndicator()),
              ),
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  response.name ?? 'No name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Assets.icons.location.svg(height: 18.r, width: 18.r),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        userLocation.city ?? "United Kingdom",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

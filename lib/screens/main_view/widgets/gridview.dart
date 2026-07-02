// screens/main_view/widgets/gridview.dart
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:giftpose/utils/widgets/premiumcardtwo.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

// PremiumUpgradeCard configured as a Grid Item matching the image dimensions
class PremiumUpgradeCard extends StatelessWidget {
  final VoidCallback? onTap;

  const PremiumUpgradeCard({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE5CC),
              Color(0xFFF5D3E9),
              Color(0xFFD6C7FF),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF9F5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.diamond_outlined,
                  color: const Color(0xFFC2942E),
                  size: 22.r,
                ),
              ),
            ),
            YMargin(12.h),
            Text(
              "Go Premium",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111625),
              ),
            ),
            YMargin(4.h),
            Expanded(
              child: Text(
                "Enjoy smarter tracking & ad-free browsing.",
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF4A5163),
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  final List<FetchItemsNearMeData> items;
  final UserLocation userLocation;
  final int crossAxisCount;
  final double childAspectRatio;
  final double spacing;
  final ScrollController? scrollController;
  final bool hasReachedMax;
  final bool isLoadingMore;

  CategoryGrid({
    super.key,
    required this.items,
    required this.userLocation,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.48,
    this.spacing = 6,
    this.scrollController,
    required this.hasReachedMax,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, vm, child) {
        final int seedModifier = items.length;
        
        // Slot position 1: Renders early in the scroll cycle (anywhere between grid slot index 2 to 4)
        final int premiumPromoIndex1 = 8 + (seedModifier % 3); 
        
        // Slot position 2: Forced to stay at least 8 elements lower down the scroll path
        // (anywhere between grid slot index 10 to 13) preventing them from cluttering together.
        final int premiumPromoIndex2 = premiumPromoIndex1 + 19 + (seedModifier % 4);

        // Evaluate flags checking if data array length qualifies to display the ad cards safely
        final bool displayPromo1 = items.length > premiumPromoIndex1;
        final bool displayPromo2 = items.length > (premiumPromoIndex2 - 1);

        // Calculate layout totals including offsets
        int totalGridItems = items.length;
        if (displayPromo1) totalGridItems += 1;
        if (displayPromo2) totalGridItems += 1;

        return CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(padding: EdgeInsets.only(top: 15.h)),
            
            // Reunified Single Grid handling dynamic structural inline transformations
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    
                    // Render First Premium Promo Card Position
                    if (displayPromo1 && index == premiumPromoIndex1)
    {
                      return PremiumProCardGridview(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.pushNamed(context, AppRoutes.premiumSubscription);
                        },
                      );
                    }

                    // Render Second Premium Promo Card Position
                    if (displayPromo2 && index == premiumPromoIndex2 ) {
                       return PremiumProCardGridview(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.pushNamed(context, AppRoutes.premiumSubscription);
                        },
                      );
                    }

                    // Shift data reading indices based on current map rendering states
                    int adjustedDataIndex = index;
                    if (displayPromo1 && index > premiumPromoIndex1) {
                      adjustedDataIndex--;
                    }
                    if (displayPromo2 && index > premiumPromoIndex2) {
                      adjustedDataIndex--;
                    }

                    // Fallback defensive safety check
                    if (adjustedDataIndex >= items.length || adjustedDataIndex < 0) {
                      return const SizedBox.shrink();
                    }

                    final data = items[adjustedDataIndex];
                    return _buildGridItem(context, vm, data);
                  },
                  childCount: totalGridItems,
                ),
              ),
            ),

            // Dynamic Pagination Indicator Footer
            if (!hasReachedMax)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
                  child: _buildLoadingIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildGridItem(BuildContext context, DashboardViewmodel vm, FetchItemsNearMeData data) {
    return InkWell(
      onTap: () {
        HapticFeedback.heavyImpact();
        vm.fetchItemsById(id: data.id).whenComplete(() {
          if (vm.fetchItemsByIdMeResponse.data?.success == true &&
              vm.fetchItemsByIdMeResponse.data!.data.imageUrls.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(location: userLocation.city),
              ),
            );
          }
        });
      },
      child: CategoryGridItem(response: data, userLocation: userLocation),
    );
  }

  Widget _buildLoadingIndicator() {
    if (!isLoadingMore) return const SizedBox.shrink();
    return Container(
      height: 80,
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

class CategoryGridItem extends StatelessWidget {
  final FetchItemsNearMeData response;
  final UserLocation userLocation;
  CategoryGridItem({super.key, required this.response, required this.userLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: response.thumbnail ?? '',
              width: 161.w,
              height: 146.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                width: 161.w,
                height: 146.w,
                color: Colors.grey.shade200,
                child: const Icon(Icons.error, color: Colors.grey),
              ),
              placeholder: (context, url) => Container(
                width: 161.w,
                height: 146.w,
                color: Colors.grey.shade100,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
          YMargin(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  response.name ?? 'No name',
                  style: GiftPoseTextStyle.medium(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                YMargin(4),
                Row(
                  children: [
                    Assets.icons.location.svg(
                      height: 12,
                      width: 12,
                    ),
                    XMargin(4),
                    Expanded(
                      child: Text(
                        userLocation.city ?? "United Kingdom",
                        style: GiftPoseTextStyle.small(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                YMargin(4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
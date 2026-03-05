// screens/main_view/widgets/gridview.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/views/details_page.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class CategoryGrid extends StatelessWidget {
  final List<FetchItemsNearMeData> items;
  final UserLocation userLocation;
  final int crossAxisCount;
  final double childAspectRatio;
  final double spacing;
  final ScrollController? scrollController;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const CategoryGrid({
    super.key,
    required this.items,
    required this.userLocation,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.9,
    this.spacing = 12,
    this.scrollController,
    required this.hasReachedMax,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
   return Consumer<DashboardViewmodel>(
          builder: (context, vm, child) {
        return GridView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(spacing),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: items.length + (hasReachedMax ? 0 : 1),
          itemBuilder: (context, index) {
            // Show loading indicator at the end
            if (index >= items.length) {
              return _buildLoadingIndicator();
            }
            
            final data = items[index];
            return InkWell(
              onTap: () {
                HapticFeedback.selectionClick();

                vm.fetchItemsById(id: items[index].id).whenComplete((){

 if(vm.fetchItemsByIdMeResponse.data?.success == true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(location: userLocation.city,),
                    ),
                  );
                }

                });
               
              },
              child: CategoryGridItem(response: data, userLocation: userLocation,),
            );
          },
        );
      }
    );
  }

  Widget _buildLoadingIndicator() {
    if (!isLoadingMore) return const SizedBox.shrink();
    
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: const Center(
        child: CircularProgressIndicator(
          color: GiftPoseColors.primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

// Individual Grid Item Widget
class CategoryGridItem extends StatelessWidget {
  final FetchItemsNearMeData response;
  final UserLocation userLocation;
  const CategoryGridItem({super.key, required this.response, required this.userLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: response.thumbnail ?? '',
              width: double.infinity,
              height: 102.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                width: double.infinity,
                height: 102.w,
                color: Colors.grey.shade200,
                child: const Icon(Icons.error, color: Colors.grey),
              ),
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 102.w,
                color: Colors.grey.shade100,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
          
          YMargin(12),

          // Product Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  response.name ?? 'No name',
                  style: GiftPoseTextStyle.medium(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                YMargin(4),

                // Location with Icon
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
                          fontWeight: FontWeight.w500,
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
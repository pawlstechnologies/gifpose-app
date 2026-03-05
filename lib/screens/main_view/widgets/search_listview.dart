import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/views/details_page.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/search_response.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class ListViewSearchWidget extends StatelessWidget {
  final ScrollController? scrollController;
    final List<SearchData> items;
  String? userLocation;
  final bool hasReachedMax;
  final bool isLoadingMore;

   ListViewSearchWidget({
    super.key,
    this.scrollController,
    required this.hasReachedMax,
    required this.isLoadingMore,  this.userLocation, required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, dashVM, child) {
        final items = dashVM.items;

        if (items.isEmpty) {
          return const Center(
            child: Text('No items available'),
          );
        }

          return Consumer<DashboardViewmodel>(
          builder: (context, vm, child) {
            return ListView.separated(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: items.length + (hasReachedMax ? 0 : 1),
              separatorBuilder: (context, index) => const YMargin(12),
              itemBuilder: (context, index) {
                // Show loading indicator at the end
                if (index >= items.length) {
                  return _buildLoadingIndicator();
                }
                
                final data = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.selectionClick();
                       vm.fetchItemsById(id: items[index].id);
                    if(vm.fetchItemsByIdMeResponse.data?.success == true){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(location: userLocation,),
                        ),
                      );
                    }
                    },
                    child: CategoryListItem(response: data, userLocation: userLocation,),
                        ),
                );
              },
            );
          }
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    if (!isLoadingMore) return const SizedBox.shrink();
    
    return Container(
      height: 60,
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

// Individual List Item Widget
class CategoryListItem extends StatelessWidget {
  final FetchItemsNearMeData response;
  final String? userLocation;

  const CategoryListItem({super.key, required this.response, required this.userLocation});

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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: response.thumbnail ?? '',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade200,
                child: const Icon(Icons.error, color: Colors.grey),
              ),
              placeholder: (context, url) => Container(
                height: 100,
                width: 100,
                color: Colors.grey.shade100,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    response.name ?? 'No name',
                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const YMargin(8),

                  // Location with Icon
                  Row(
                    children: [
                      Assets.icons.location.svg(
                        height: 14,
                        width: 14,
                      ),
                      const XMargin(4),
                      Expanded(
                        child: Text(
                userLocation ?? "United Kingdom",
                          style: GiftPoseTextStyle.small(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const YMargin(8),

         
               
                ],
              ),
            ),
          ),

          // Arrow Icon
          Padding(
            padding: const EdgeInsets.all(12),
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
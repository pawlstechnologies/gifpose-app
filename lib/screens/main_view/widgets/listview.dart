import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/views/dashboard_view.dart'
    show CategoryProducts;
import 'package:giftpose/screens/main_view/views/details_page.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class ListViewWidget extends StatelessWidget {
  final List<CategoryProducts> categories;


  const ListViewWidget({
    super.key,
    required this.categories,
  
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10,),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
 padding: const EdgeInsets.symmetric( vertical:10,),
          child: InkWell(
              onTap: () {
                                        HapticFeedback.selectionClick();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => DetailsPage(
                                                category: categories[index],
                                                ),
                                          ),
                                        );
                                      },
            child: CategoryListItem(category: categories[index])),
        );
      },
    );
  }
}

// Individual Grid Item Widget
class CategoryListItem extends StatelessWidget {
  final CategoryProducts category;

  const CategoryListItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
         Container(
  height: 76,
  width: 125,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    image: DecorationImage(
      image: AssetImage(category.icon.path), // Use path directly
      fit: BoxFit.fitWidth,
    ),
  )),

          XMargin(12),

          // Product Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  category.name,
                  style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),

                     YMargin(4),

                // Location with Icon
                Row(
                  children: [
                   Assets.icons.location.svg(),
                   XMargin(8),
                    Text(
                      category.location,
                      style: GiftPoseTextStyle.small(
                        fontWeight: FontWeight.w500,
                                 color: Theme.of(context).textTheme.bodyMedium?.color
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

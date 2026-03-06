import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
   return GiftPoseBaseScaffold(

      includeHorizontalPadding: false,

        showAppBar: true,
      includeVerticalPadding: false,
      centerTitle: true,
      appBarLeadingWidget: Assets.icons.back.svg(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),

      hasGradient: true,
      appBarTitleWidget: Text(
        "Gift Details",
        textAlign: TextAlign.center,

        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
      ),


      builder: (size) {
        return ListView(
          children: [
        
          ],
        );
      }
    );
  }
}
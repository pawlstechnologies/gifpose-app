import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/requester_flow/viewmodels/requester_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:provider/provider.dart';

class RequestOffersScreen extends StatelessWidget {
  const RequestOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Consumer<RequesterViewmodel>(
        builder: (context, vm, child) {
          return Column(
            children: [
              SizedBox(height: 25.w),
              _header(context),
              SizedBox(height: 29.w),
              _requestSummary(context, vm),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 26.w, 11.w, 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tabs(context),
                      SizedBox(height: 22.w),
                      _filters(context, vm),
                      SizedBox(height: 34.w),
                      _offerCard(context, nearest: true),
                      SizedBox(height: 12.w),
                      _offerCard(context),
                      SizedBox(height: 12.w),
                      _offerCard(context),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 31.w,
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Assets.icons.back.svg(
                width: 12.w,
                height: 24.w,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(width: 90.w),
            Text(
              'Offer Received'.tr(context),
              style: GiftPoseTextStyle.normal(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ).copyWith(letterSpacing: 0.32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestSummary(BuildContext context, RequesterViewmodel vm) {
    final itemName = vm.itemNameCtrl.text.trim().isEmpty
        ? 'Neatly Used Shoes'.tr(context)
        : vm.itemNameCtrl.text.trim();
    final location = vm.locationCtrl.text.trim().isEmpty
        ? 'United Kingdom'.tr(context)
        : vm.locationCtrl.text.trim();
    return Container(
      width: double.infinity,
      height: 73.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 12.w),
      decoration: const BoxDecoration(
        color: Color(0xFFF6FFF5),
        border: Border(bottom: BorderSide(color: Color(0xFFDCFCE7))),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              'assets/images/requester/offer_request_item.jpg',
              width: 63.w,
              height: 48.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 17.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  itemName,
                  style: GiftPoseTextStyle.normal(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ).copyWith(letterSpacing: 0.28),
                ),
                SizedBox(height: 8.w),
                _location(context, location),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Offer received'.tr(context)),
              TextSpan(
                text: ' (3)',
                style: TextStyle(color: GiftPoseColors.primaryColor),
              ),
            ],
          ),
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ).copyWith(letterSpacing: 0.28),
        ),
        SizedBox(width: 20.w),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Offer preferred'.tr(context)),
              TextSpan(
                text: '(3)',
                style: TextStyle(color: GiftPoseColors.primaryColor),
              ),
            ],
          ),
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ).copyWith(letterSpacing: 0.28),
        ),
      ],
    );
  }

  Widget _filters(BuildContext context, RequesterViewmodel vm) {
    return Row(
      children: [
        _filter(context, vm, OfferFilter.nearest, 'Nearest to me', 101),
        SizedBox(width: 8.w),
        _filter(context, vm, OfferFilter.bestRating, 'Best Rating', 79),
        SizedBox(width: 8.w),
        _filter(context, vm, OfferFilter.newest, 'Newest', 83),
      ],
    );
  }

  Widget _filter(
    BuildContext context,
    RequesterViewmodel vm,
    OfferFilter filter,
    String label,
    double width,
  ) {
    final selected = vm.offerFilter == filter;
    return InkWell(
      onTap: () => vm.selectOfferFilter(filter),
      borderRadius: BorderRadius.circular(100.r),
      child: Container(
        width: width.w,
        height: 36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF101828) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Text(
          label.tr(context),
          style: GiftPoseTextStyle.small(
            color: selected ? Colors.white : const Color(0xFF4A5565),
          ),
        ),
      ),
    );
  }

  Widget _offerCard(BuildContext context, {bool nearest = false}) {
    return Container(
      width: 347.w,
      height: nearest ? 145.w : 132.w,
      decoration: BoxDecoration(
        border: Border.all(color: GiftPoseColors.borderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 19.w, 8.w, 9.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 7.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: Image.asset(
                      'assets/images/requester/offer_item.jpg',
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 18.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Neatly Used Shoes'.tr(context),
                        style: GiftPoseTextStyle.normal(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ).copyWith(letterSpacing: 0.28),
                      ),
                      SizedBox(height: 10.w),
                      _location(context, 'United Kingdom'.tr(context)),
                      SizedBox(height: 12.w),
                      Text(
                        '"I have the exact frame you’re looking for! It’s been sitting in my garage. I can drop i'
                            .tr(context),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: GiftPoseTextStyle.small(
                          color: const Color(0xFF475569),
                        ).copyWith(height: 16 / 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (nearest)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 89.w,
                height: 23.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFF6FFF5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  'Nearest to you'.tr(context),
                  style: GiftPoseTextStyle.small(
                    color: GiftPoseColors.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _location(BuildContext context, String location) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/requester/location.svg',
          width: 20.w,
          height: 20.w,
          colorFilter: ColorFilter.mode(
            GiftPoseColors.primaryColor,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          location,
          style: GiftPoseTextStyle.small(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF928F91),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';

class DonorHeader extends StatelessWidget {
  const DonorHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 31.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.maybePop(context),
              child: SizedBox(
                width: 30.w,
                height: 31.w,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Assets.icons.back.svg(width: 12.w, height: 24.w),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: GiftPoseTextStyle.normal(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class DonorLocationRow extends StatelessWidget {
  const DonorLocationRow({super.key, this.location = 'United Kingdom'});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

class DonorPickupCard extends StatelessWidget {
  const DonorPickupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 83.w,
      padding: EdgeInsets.fromLTRB(17.w, 6.w, 10.w, 9.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mode of Pickup',
            style: GiftPoseTextStyle.normal(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 4.w),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8FBE8),
                ),
                child: SvgPicture.asset(
                  'assets/icons/requester/pickup.svg',
                  width: 16.w,
                  height: 20.w,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick-up',
                    style: GiftPoseTextStyle.small(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    'Agree on a public meeting point',
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DonorItemSummary extends StatelessWidget {
  const DonorItemSummary({
    super.key,
    this.image = 'assets/images/requester/request_item_example.jpg',
    this.title = 'Neatly Used Shoes',
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 73.w,
      padding: EdgeInsets.fromLTRB(22.w, 12.w, 16.w, 12.w),
      color: const Color(0xFFF6FFF5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              image,
              width: 63.w,
              height: 48.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 36.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GiftPoseTextStyle.normal(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8.w),
              const DonorLocationRow(),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';

class RequestedGiftDetailsScreen extends StatelessWidget {
  const RequestedGiftDetailsScreen({super.key});

  static const description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet purus sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet purus sit amet';

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 25.w, 16.w, 29.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DonorHeader(title: 'Gift Details'),
            SizedBox(height: 27.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Image.asset(
                'assets/images/requester/request_shoes.jpg',
                width: 343.w,
                height: 277.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 21.w),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Power Drill for Deck Project',
                    style: GiftPoseTextStyle.normal(fontSize: 14),
                  ),
                ),
                Text('2 miles away', style: GiftPoseTextStyle.small()),
              ],
            ),
            SizedBox(height: 8.w),
            const DonorLocationRow(),
            SizedBox(height: 20.w),
            const _TransportRow(),
            SizedBox(height: 18.w),
            Text(
              description,
              style: GiftPoseTextStyle.small(
                color: const Color(0xFF857878),
              ).copyWith(height: 16 / 12),
            ),
            SizedBox(height: 17.w),
            Text(
              description,
              style: GiftPoseTextStyle.small(
                color: const Color(0xFF857878),
              ).copyWith(height: 16 / 12),
            ),
            SizedBox(height: 18.w),
            const DonorPickupCard(),
            SizedBox(height: 35.w),
            GiftPoseButton(
              title: 'Offer Item',
              height: 46,
              scaleHeightByWidth: true,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.donorOfferItem),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransportRow extends StatelessWidget {
  const _TransportRow();
  static const items = [
    (Icons.directions_car_outlined, 'Private\nVehicle'),
    (Icons.directions_bus_outlined, 'Public\nTransport'),
    (Icons.directions_walk, 'Walking'),
    (Icons.pedal_bike, 'Cycling'),
    (Icons.electric_rickshaw_outlined, 'Vehicle\nHire'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items
          .map(
            (item) => SizedBox(
              width: 48.w,
              child: Column(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Icon(
                      item.$1,
                      size: 20,
                      color: const Color(0xFF857878),
                    ),
                  ),
                  SizedBox(height: 3.w),
                  Text(
                    item.$2,
                    textAlign: TextAlign.center,
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF857878),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

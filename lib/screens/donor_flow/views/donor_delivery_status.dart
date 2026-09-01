import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/views/donor_delivery_sheets.dart';
import 'package:giftpose/screens/donor_flow/views/donor_item_details.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';

class DonorDeliveryStatusScreen extends StatelessWidget {
  const DonorDeliveryStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DonorItemDetailsScreen(),
        Positioned(
          left: 8.w,
          right: 8.w,
          top: 51.w,
          child: Material(
            color: const Color(0xFFFFFCF5),
            child: InkWell(
              onTap: () => showConfirmGiftDelivery(context),
              child: Container(
                height: 80.w,
                padding: EdgeInsets.symmetric(horizontal: 11.w),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFF999999))),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: const Color(0xFFFFF0DF),
                      child: const Icon(
                        Icons.info_outline,
                        color: Color(0xFFFF8614),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recipient Marked Item as Received',
                            style: GiftPoseTextStyle.normal(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF514949),
                            ),
                          ),
                          SizedBox(height: 7.w),
                          Text(
                            'Please confirm if this is correct.',
                            style: GiftPoseTextStyle.small(
                              color: const Color(0xFF9A9494),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

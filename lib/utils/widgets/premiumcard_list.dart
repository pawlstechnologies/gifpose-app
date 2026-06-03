import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumProCardListview extends StatelessWidget {
  final VoidCallback? onTap;

  const PremiumProCardListview({
    super.key,
    this.onTap,
  });

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
        decoration: BoxDecoration(
          color: const Color(0xFFFEF9E7), // Warm yellow background
          borderRadius: BorderRadius.circular(12.r),
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
        padding: EdgeInsets.all(12.w),
        child: Stack(
          children: [
            /// Faded Background Watermark Star
            Positioned(
              left: -20.w,
              bottom: -10.h,
              child: Icon(
                Icons.star,
                size: 110.r,
                color: const Color(0xFFFFF2CC).withOpacity(0.7),
              ),
            ),

            /// Foreground Content Layer
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header Title
                    Text(
                      "Premium Pro",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7E5109), // Deep brown tint
                      ),
                    ),
                    SizedBox(height: 12.h),

                    /// Feature List
                    _buildFeatureRow("Unlimited early access"),
                    SizedBox(height: 8.h),
                    _buildFeatureRow("Priority notifications"),
                    SizedBox(height: 8.h),
                    _buildFeatureRow("Dedicated support"),
                  ],
                ),

                /// Bottom Navigation Indicator Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7E5109).withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color(0xFF7E5109),
                        size: 12.r,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String featureText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Container(
            width: 4.w,
            height: 4.h,
            decoration: const BoxDecoration(
              color: Color(0xFFD4AC0D), // Gold Bullet point
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            featureText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9A7D0A),
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}
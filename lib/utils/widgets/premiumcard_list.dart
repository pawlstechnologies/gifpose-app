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
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Left Yellow Card
            Container(
              width: 150.w,
              height: 110.h,
              decoration: BoxDecoration(
                color: const Color(0xFFEEDC9A), // Soft yellow-tan
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFF766424), // Dark olive brown
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star,
                      color: const Color(0xFFEEDC9A),
                      size: 28.r,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "GO PRO",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF766424),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 16.w),
            
            /// Right Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCheckRow("Unlimited Smart Notification"),
                  SizedBox(height: 2.h),
                  _buildCheckRow("Supporter Badge"),
                        SizedBox(height: 2.h),
                    _buildCheckRow("Unlimited Smart Notification"),
       
               
                  SizedBox(height: 5.h),
                  
                  /// Get Premium Button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6D8BA), // Light tan
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Get Premium",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF766424),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckRow(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: const Color(0xFF766424),
          size: 20.r,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4A4A4A),
            ),
          ),
        ),
      ],
    );
  }
}
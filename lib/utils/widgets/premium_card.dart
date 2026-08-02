import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Import your design system assets and styles here
// import 'package:giftpose/utils/theme/giftpose_colors.dart';
// import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/localization_provider.dart';

class PremiumUpgradeCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSettings;

  const PremiumUpgradeCard({
    super.key,
    this.onTap,
    this.isSettings = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE5CC), // Soft peach/orange
              Color(0xFFF5D3E9), // Pastel pink
              Color(0xFFD6C7FF), // Soft lavender/blue
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Diamond Badge Icon
            Container(
              width: 54.w,
              height: 54.h,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF9F5), // Ultra-light cream circle background
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.diamond_outlined, 
                  color: const Color(0xFFC2942E), // Subtle dark gold/amber tone
                  size: 28.r,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            
            // Middle Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  !isSettings?Text(""):
                  Text(
                    "Upgrade To Premium", // use .tr(context) if localized
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111625), // Dark navy text color
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Enjoy smarter tracking, insights, and ads free experience.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4A5163), // Muted slate gray text
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            
            // Right Arrow Navigation Icon
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF6B7280), // Medium gray chevron tint
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumMemberCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? activeUntil;

  const PremiumMemberCard({
    super.key,
    this.onTap,
    this.activeUntil,
  });

  @override
  Widget build(BuildContext context) {
    final String subtitleText = (activeUntil != null && activeUntil!.trim().isNotEmpty)
        ? "Active until $activeUntil"
        : "Active Member";

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFFE5CC), // Soft peach/orange
              Color(0xFFF5D3E9), // Pastel pink
              Color(0xFFD6C7FF), // Soft lavender/purple
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Diamond Badge Icon
            Container(
              width: 54.w,
              height: 54.h,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF9F5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.diamond_outlined,
                  color: const Color(0xFFC2942E),
                  size: 28.r,
                ),
              ),
            ),
            SizedBox(width: 14.w),

            // Middle Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Premium Member".tr(context),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111625),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitleText.tr(context),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4A5163),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Right Arrow Navigation Icon
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF6B7280),
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
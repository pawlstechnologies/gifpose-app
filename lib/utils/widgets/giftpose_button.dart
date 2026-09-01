import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';

enum GiftPoseButtonType { full, border, text }

class GiftPoseButton extends StatelessWidget {
  final bool isLoading;
  final String title;
  final Function()? onTap;
  final double width;
  final double height;
  final bool scaleHeightByWidth;
  final Color? backgroundColor;
  final Color borderColor;
  final Color? textColor;
  final double fontSize;
  final GiftPoseButtonType buttonType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final double? elevation;
  final bool isEnabled;

  const GiftPoseButton({
    super.key,
    this.isLoading = false,
    required this.title,
    this.onTap,
    this.width = double.infinity,
    this.height = 49,
    this.scaleHeightByWidth = false,
    this.fontSize = 14,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 6,
    this.buttonType = GiftPoseButtonType.full,
    this.borderColor = Colors.transparent,
    this.elevation,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool effectiveEnabled = isEnabled && !isLoading && onTap != null;
    return Opacity(
      opacity: isLoading ? 0.6 : (effectiveEnabled ? 1.0 : 0.5),
      child: IgnorePointer(
        ignoring: !effectiveEnabled,
        child: SizedBox(
          height: scaleHeightByWidth ? height.w : null,
          child: MaterialButton(
            minWidth: width.w,
            elevation: elevation ?? 0,
            color: buttonType == GiftPoseButtonType.text
                ? null
                : backgroundColor ?? GiftPoseColors.primaryColor,
            disabledColor: buttonType == GiftPoseButtonType.text
                ? null
                : Colors.grey.shade400,
            disabledTextColor: Colors.white,
            shape: RoundedRectangleBorder(
              side:
                  buttonType == GiftPoseButtonType.full ||
                      buttonType == GiftPoseButtonType.text
                  ? BorderSide.none
                  : BorderSide(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            height: scaleHeightByWidth ? double.infinity : height.h,
            onPressed: effectiveEnabled ? onTap : null,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: GiftPoseColors.primaryColor,
                      strokeWidth: 1,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefixIcon != null)
                        Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: prefixIcon,
                        ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: fontSize.sp,
                          fontWeight: FontWeight.w400,
                          color:
                              textColor ??
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      if (suffixIcon != null)
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: suffixIcon,
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

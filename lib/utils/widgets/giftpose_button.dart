import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';


enum GiftPoseButtonType { full, border, text }

class GiftPoseButton extends StatelessWidget {
  final bool isLoading;
  final String title;
  final Function() onTap;
  final double width;
  final double height;
  final Color? backgroundColor;
  Color borderColor;
  final Color? textColor;
  final double fontSize;
  final GiftPoseButtonType buttonType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final double? elevation;

  GiftPoseButton({
    super.key,
    this.isLoading = false,
    required this.title,
    required this.onTap,
    this.width = double.infinity,
    this.height = 56,
    this.fontSize = 16,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 6,
    this.buttonType = GiftPoseButtonType.full,
    this.borderColor = Colors.transparent,
    this.elevation,
});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading ? 0.6 : 1, // Slightly dim button while loading
      child: IgnorePointer(
        ignoring: isLoading,
        child: MaterialButton(
          minWidth: width.w,
          elevation: elevation ?? 0,
          color: buttonType == GiftPoseButtonType.text
              ? null
              : backgroundColor ?? GiftPoseColors.primaryColor,
          shape: RoundedRectangleBorder(
            side: buttonType == GiftPoseButtonType.full ||
                    buttonType == GiftPoseButtonType.text
                ? BorderSide.none
                : BorderSide(
                    color: borderColor,
                  ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          height: height.h,
          onPressed: isLoading ? null : onTap,
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
                        color:textColor?? Theme.of(context).scaffoldBackgroundColor
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
    );
  }
}

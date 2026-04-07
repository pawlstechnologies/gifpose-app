import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class GiftPoseOtpInputField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onCompleted;
  final Function()? onTap;
  final int length;
  final void Function(String)? onChanged;
  final bool? hasOtp;
  final EdgeInsetsGeometry? fieldOuterPadding;
  final MainAxisAlignment? mainAxisAlignment;
  final Color? inactiveColor;
  final Color? activeColor;
  final Color? selectedColor;
  final Color? activeFillColor;
  final Color? selectedFillColor;
  final Color? inactiveFillColor;
  final Color? backgroundColor;
  final Color? dotColor;
  final Color? emptyDotColor;

  const GiftPoseOtpInputField({
    super.key,
    this.controller,
    this.onCompleted,
    this.onTap,
    this.length = 6,
    this.onChanged,
    this.hasOtp = false,
    this.mainAxisAlignment,
    this.fieldOuterPadding,
    this.inactiveColor,
    this.activeColor,
    this.selectedColor,
    this.activeFillColor,
    this.selectedFillColor,
    this.inactiveFillColor,
    this.backgroundColor,
    this.dotColor,
    this.emptyDotColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PinCodeTextField(
      appContext: context,
      controller: controller,
      autoDisposeControllers: false,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      readOnly: false,
      blinkWhenObscuring: false,
      obscureText: true,
      autovalidateMode: AutovalidateMode.disabled,
      pastedTextStyle: TextStyle(
        color: theme.textTheme.bodyLarge?.color ?? Colors.black,
        fontWeight: FontWeight.bold,
      ),
      length: length,
      textStyle: TextStyle(
        color: theme.textTheme.bodyLarge?.color,
      ),
      cursorHeight: 15,
      validator: (value) {
        if (value?.length != length) {
          return "input is required";
        } else if (value == null || value.isEmpty) {
          return "input is required";
        }
        return null;
      },
      onTap: onTap,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.r),
        fieldWidth: 48.w,
        fieldHeight: 57.h,
        fieldOuterPadding:
            fieldOuterPadding ?? const EdgeInsets.symmetric(horizontal: 4),
        borderWidth: 0.5,
        activeBorderWidth: 0.5,
        selectedBorderWidth: 0.5,
        disabledBorderWidth: 0.5,
        inactiveBorderWidth: 0.5,
        activeColor: activeColor ?? GiftPoseColors.primaryColor,
        inactiveColor: inactiveColor ?? Theme.of(context).dividerColor,
        selectedColor: selectedColor ?? GiftPoseColors.primaryColor,
        activeFillColor: activeFillColor ?? Theme.of(context).cardColor,
        inactiveFillColor: inactiveFillColor ?? Theme.of(context).cardColor,
        selectedFillColor: selectedFillColor ?? Theme.of(context).cardColor,
      ),
      cursorColor: theme.textTheme.bodyLarge?.color,
      animationDuration: const Duration(milliseconds: 300),
      keyboardType: TextInputType.number,
      onCompleted: onCompleted,
      enableActiveFill: true,
      onChanged: onChanged ?? (val) {},
      beforeTextPaste: (text) {
        return true;
      },
    );
  }
}
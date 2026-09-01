import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:provider/provider.dart';

enum TextFieldType { date, text, dropdown, phone, country, email, password }

class GiftPoseTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool amountTextField;
  final String fieldName;
  final bool isAutoFocus;
  final String? subTitle;
  final List<TextInputFormatter>? formatters;
  final String? initialValue;
  final TextEditingController controller;
  final TextInputType? inputType;
  final String? hintText;
  final bool? isSuccess;
  final bool obscureText;
  final bool enableInteractiveSelection;
  final Function()? onTap;
  final bool readOnly;
  final Color? textFieldColor;
  final Color? borderColor;
  final bool? isCumpolsory;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? textFieldBottomPadding;
  final TextFieldType textFieldType;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(DateTime selectedDate)? selectedDate;
  final AutovalidateMode autovalidateMode;
  final int? maxLength;
  final int? minLength; // Added minLength property
  final double height;
  final bool scaleHeightByWidth;
  final double borderRadius;
  final double hintFontSize;
  final double fieldNameFontSize;
  final EdgeInsetsGeometry contentPadding;

  const GiftPoseTextField({
    super.key,
    this.amountTextField = false,
    this.fieldName = "",
    this.isAutoFocus = false,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
    this.selectedDate,
    this.maxLength,
    this.minLength, // Added minLength property
    this.height = 49,
    this.scaleHeightByWidth = false,
    this.borderRadius = 10,
    this.hintFontSize = 14,
    this.fieldNameFontSize = 13,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 14,
    ),
    required this.controller,
    this.hintText,
    this.onTap,
    this.isCumpolsory = false,
    this.readOnly = false,
    this.suffixIcon,
    this.inputType,
    this.formatters,
    this.borderColor,
    this.onChanged,
    this.textFieldType = TextFieldType.text,
    this.subTitle,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.textFieldColor,
    this.textFieldBottomPadding,
    this.focusNode,
    this.onEditingComplete,
    this.enableInteractiveSelection = true,
    this.isSuccess = false,
  });

  @override
  State<GiftPoseTextField> createState() => _GiftPoseTextFieldState();
}

class _GiftPoseTextFieldState extends State<GiftPoseTextField> {
  @override
  void initState() {
    super.initState();
    // Default to Nigeria

    //
    // If controller is empty, set dial code
    if ((widget.textFieldType == TextFieldType.country ||
            widget.textFieldType == TextFieldType.phone) &&
        widget.controller.text.isEmpty) {
      // authVM.countryCodeCtrl.text= selectedCountry.dialCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> showPassword = ValueNotifier(true);

    return Consumer<BaseViewmodel>(
      builder: (context, baseVM, child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: widget.textFieldBottomPadding ?? 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.fieldName.isEmpty
                  ? SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(bottom: 10.w, left: 5.w),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.fieldName,
                              style: GiftPoseTextStyle.medium(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.color,
                                fontSize: widget.fieldNameFontSize,
                              ),
                            ),
                            if (widget.isCumpolsory == true)
                              TextSpan(
                                text: ' *',
                                style: GiftPoseTextStyle.medium(
                                  color: GiftPoseColors.errorColor,
                                  fontSize: 13,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

              ValueListenableBuilder(
                valueListenable: showPassword,
                builder: (BuildContext context, bool show, Widget? child) {
                  return SizedBox(
                    height: widget.scaleHeightByWidth
                        ? widget.height.w
                        : widget.height.h,
                    child: TextFormField(
                      focusNode: widget.focusNode,
                      autofocus: widget.isAutoFocus,
                      maxLength: widget.maxLength,
                      onEditingComplete: widget.onEditingComplete,
                      enableInteractiveSelection:
                          widget.enableInteractiveSelection,
                      cursorHeight: 15.h,
                      cursorColor: GiftPoseColors.primaryColor,
                      style: GiftPoseTextStyle.medium(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 12.sp,
                      ),
                      initialValue: widget.initialValue,
                      textCapitalization:
                          widget.textFieldType == TextFieldType.email ||
                              widget.textFieldType == TextFieldType.password ||
                              widget.obscureText
                          ? TextCapitalization.none
                          : TextCapitalization.sentences,
                      onChanged: widget.onChanged,
                      autovalidateMode: widget.autovalidateMode,
                      readOnly: widget.textFieldType == TextFieldType.dropdown
                          ? true
                          : widget.readOnly,
                      inputFormatters: widget.formatters,
                      controller: widget.controller,
                      validator: (value) {
                        // Minimum length validation logic
                        if (widget.minLength != null &&
                            value != null &&
                            value.length < widget.minLength!) {
                          return 'Minimum length is [${widget.minLength} characters';
                        }
                        if (widget.validator != null) {
                          return widget.validator!(value);
                        }
                        return null;
                      },
                      keyboardType: widget.inputType,
                      obscureText: widget.obscureText && showPassword.value,
                      onTap: widget.onTap,
                      decoration: InputDecoration(
                        counterText: "",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: widget.prefixIcon,
                        ),
                        isCollapsed: true,
                        fillColor:
                            widget.textFieldColor ??
                            Theme.of(context).cardColor,
                        filled: true,
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 25.h,
                          minHeight: 25.h,
                          minWidth: 15.w,
                        ),
                        suffixIconConstraints: BoxConstraints(
                          maxHeight: 25.h,
                          minHeight: 25.h,
                          minWidth: 25.w,
                        ),
                        suffixIcon: widget.obscureText == false
                            ? Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: widget.suffixIcon,
                              )
                            : GestureDetector(
                                onTap: () {
                                  showPassword.value = !showPassword.value;
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Icon(
                                    show
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 22.sp,
                                    color: Color.fromARGB(255, 72, 74, 78),
                                  ),
                                ),
                              ),
                        hintText: widget.hintText ?? widget.fieldName,
                        enabledBorder: outlineInputBorder.copyWith(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius.r,
                          ),
                          borderSide: BorderSide(
                            color:
                                widget.borderColor ??
                                GiftPoseColors.borderColor,
                          ),
                        ),
                        hintStyle: GiftPoseTextStyle.normal(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor,
                          fontSize: widget.hintFontSize,
                        ),
                        contentPadding: widget.contentPadding,
                        border: outlineInputBorder.copyWith(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius.r,
                          ),
                          borderSide: BorderSide(
                            color:
                                widget.borderColor ??
                                GiftPoseColors.borderColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius.r,
                          ),
                          borderSide: BorderSide(
                            color: GiftPoseColors.errorColor,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius.r,
                          ),
                          borderSide: BorderSide(
                            color: GiftPoseColors.errorColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius.r,
                          ),
                          borderSide: BorderSide(
                            color: widget.borderColor == Colors.transparent
                                ? Colors.transparent
                                : widget.borderColor ??
                                      GiftPoseColors.primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

final outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: GiftPoseColors.borderColor),
  borderRadius: BorderRadius.circular(10.r),
);

import 'package:flutter/material.dart';
import 'package:giftpose/screens/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/validators.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatelessWidget with Validators{
  CreateAccountScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, vm, child) {
        return GiftPoseBaseScaffold(
          showAppBar: false,
          hasGradient: true,

          builder: (size) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    YMargin(40),
                    Assets.images.logo.image(height: 40, width: 40),
                    YMargin(26),
                    Text(
                      "Create an Account".tr(context),
                      style: GiftPoseTextStyle.heading1(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    YMargin(26),
                
                    GiftPoseTextField(
                      controller: vm.fullNameCtrl,
                      hintText: "Enter your full name".tr(context),
                      fieldName: "Full Name".tr(context),
                              validator: isRequired,
                    ),
                
                    GiftPoseTextField(
                      controller: vm.emailCtrl,
                      hintText: "Enter your email address".tr(context),
                      fieldName: "Email Address".tr(context),
                              validator: isValidEmailAddress,
                    ),
                    GiftPoseTextField(
                      controller: vm.usernameCtrl,
                      hintText: "Enter your username".tr(context),
                      fieldName: "Username".tr(context),
                      validator: isRequired,
                    ),
                    GiftPoseTextField(
                      controller: vm.passwordCtrl,
                      hintText: "Enter your password".tr(context),
                      fieldName: "Password".tr(context),
                      obscureText: vm.obscureText,
                                 validator: validatePassword(
                                    shouldContainSpecialChars: true,
                                    shouldContainCapitalLetter: true,
                                    shouldContainNumber: true,
                                    minLength: 8,
                                    maxLength: 32,
                                    errorMessage:
                                        "Password must be up to 8 characters",
                                    onNumberNotPresent: () {
                                      return "Password must contain number";
                                    },
                                    onSpecialCharsNotPresent: () {
                                      return "Password must contain special characters";
                                    },
                                    onCapitalLetterNotPresent: () {
                                      return "Password must contain capital letters";
                                    }),
                      suffixIcon: IconButton(
                        onPressed: () {
                          vm.updateObscureText();
                        },
                        icon: Icon(
                          vm.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    GiftPoseTextField(
                      controller: vm.confirmPasswordCtrl,
                      hintText: "Enter your password".tr(context),
                      fieldName: "Confirm Password".tr(context),
                      obscureText: vm.obscureText2,
                           validator: (value) {
                                    if (vm.passwordCtrl.text != value) {
                                      return "Password Mismatch";
                                    }
                                    return null;
                                  },
                      suffixIcon: IconButton(
                        onPressed: () {
                          vm.updateObscureText2();
                        },
                        icon: Icon(
                          vm.obscureText2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                
                    YMargin(18),
                
                    GiftPoseButton(
                      title: "Sign Up".tr(context),
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          HapticFeedback.selectionClick();
                          vm.createAccount();
                        }
                      },
                    ),
                    YMargin(27),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Theme.of(context).dividerColor),
                        ),
                        XMargin(10),
                      Expanded(child: Divider(color: Theme.of(context).dividerColor,)),
                    ],
                  ),
                          YMargin(35),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 42.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                            Assets.icons.ex.svg(),
                                            Assets.images.facebook.image(height: 47,width: 47),
                                            Assets.icons.apple.svg(),
                           Assets.images.google.image(height: 47,width: 47),
                        
                                            
                                           ],),
                      ),
               YMargin(35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?".tr(context),style: GiftPoseTextStyle.medium(color: Theme.of(context).textTheme.bodyMedium!.color,fontSize: 14),),
                      Text("Log In".tr(context),style: GiftPoseTextStyle.medium( fontSize: 14,color: GiftPoseColors.primaryColor),),
                    ],
                  ),



                  YMargin(99)
                ],
              ),
            ));
          },
        );
      },
    );
  }
}

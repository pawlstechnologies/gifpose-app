// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';



int accountNumberLength = 10;

mixin Validators {

  /// checks if any fields are empty
  String? isRequired(String? value){
    if(value == null || value == ''){
      return 'This field is required';
    }
    return null;
  }

   String? isnotRequired(){
    
    return null;
  }

  String? isPhone(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Phone Number is required';
    } else if (!GetUtils.isNumericOnly(value!.trim()) ||
        !GetUtils.isLengthEqualTo(value.trim(), 11)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? accountNumberValidator(String value) {
    if (value.isEmpty ?? true) {
      return 'account Number is required';
    } else if (!GetUtils.isNumericOnly(value.trim()) ||
        !GetUtils.isLengthLessThan (value.trim(), 10)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  

  String? isBvn(String? value){
    if(value == null || value == ''){
      return 'BVN Number is required';
    }else if(value.length < 11 || value.length > 11){
      return "This bvn is not valid";
    }
    return null;
  }



  String? isValidEmailAddress (String? value){
    final emailAddressRegex = RegExp(  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value!.isEmpty) {
      return "Email is required";
      // null;
    } else if (!emailAddressRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? isValidOptionalEmailAddress (String? value){
    final emailAddressRegex = RegExp(  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
   if (!emailAddressRegex.hasMatch(value ?? "")) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? isValidPhoneNumber(String? value){
    final phoneNumberRegex = RegExp(r'^0[789]\d{9}$');
    if(value == null || value == ''){
      return 'This field is required';
    }
    if(!phoneNumberRegex.hasMatch(value)){
      return 'Phone number isn\'t valid' ;
    }
    return null ;
  }



    String? isValidAirtimePhoneNumber(String? value){
    final phoneNumberRegex =  RegExp(r'^(\234|0)[78901]\d{9}$');
    if(value == null || value == ''){
      return 'This field is required';
    }
    if(!phoneNumberRegex.hasMatch(value)){
      return 'Phone number isn\'t valid' ;
    }
    return null ;
  }

  /// Validates the required fields and calls a save method on the form
  bool validateAndSaveOnSubmit(BuildContext ctx) {
    final form = Form.of(ctx);

    if(!form.validate()){
      return false;
    }

    form.save();
    return true;

  }

  static String? isOtp (String? value, {required int otpLength}) {
    if(value!.isEmpty){
      return "Please enter 4-digit pin";
    } else if (value.length < otpLength) {
      return "Pin must be 4 digits";
    } else {
      return null;
    }
  }

  FormFieldValidator<String> validatePassword({
    String? errorMessage,
    int minLength = 4,
    int? maxLength,
    bool shouldContainNumber = false,
    bool shouldContainSpecialChars = false,
    bool shouldContainCapitalLetter = false,
    bool shouldContainSmallLetter = false,
   
    Function? reason,
    String Function()? onNumberNotPresent,
    String Function()? onSpecialCharsNotPresent,
    String Function()? onCapitalLetterNotPresent,
  }) {
    return (fieldValue) {
      var mainError = errorMessage;

      if (isPassword(
        fieldValue,
        minLength: minLength,
        maxLength: maxLength,
        shouldContainSpecialChars: shouldContainSpecialChars,
        shouldContainCapitalLetter: shouldContainCapitalLetter,
        shouldContainSmallLetter: shouldContainSmallLetter,
        shouldContainNumber: shouldContainNumber,
        isNumberPresent: (present) {
          if (!present) mainError = onNumberNotPresent!();
        },
        isCapitalLetterPresent: (present) {
          if (!present) mainError = onCapitalLetterNotPresent!();
        },
        isSpecialCharsPresent: (present) {
          if (!present) {
            mainError = onSpecialCharsNotPresent != null
                ? onSpecialCharsNotPresent()
                : "Password must contain special character";
          }

        },
        
      )) {
        return null;
      } else {
        return mainError ?? "Password must match the required format";
      }
    };
  }

   bool isPassword(
      String? password, {
        int minLength = 4,
        int? maxLength,
        bool shouldContainNumber = false,
        bool shouldContainSpecialChars = false,
        bool shouldContainCapitalLetter = false,
        bool shouldContainSmallLetter = false,
         bool samePassword = false,
        Function? reason,
        void Function(bool)? isNumberPresent,
        void Function(bool)? isSpecialCharsPresent,
        void Function(bool)? isCapitalLetterPresent,
        void Function(bool)? isSmallLetterPresent,
        void Function()? isMaxLengthFailed,
        void Function()? isMinLengthFailed,
      })

  {
    if (password == null) {
      return false;
    }
    if (password.trim().isEmpty) {
      return false;
    }
   
    if (password.length < minLength) {
      if (isMinLengthFailed != null) isMinLengthFailed();
      return false;
    }

    if (maxLength != null) {
      if (password.length > maxLength) {
        if (isMaxLengthFailed != null) isMaxLengthFailed();
        return false;
      }
    }

    if (shouldContainNumber) {
      final numberRegex = RegExp(r"[0-9]+");
      if (!numberRegex.hasMatch(password)) {
        if (isNumberPresent != null) isNumberPresent(false);
        return false;
      } else if (isNumberPresent != null) {
        isNumberPresent(true);
      }
    }

    if (shouldContainCapitalLetter) {
      final capitalRegex = RegExp(r"[A-Z]+");
      if (!capitalRegex.hasMatch(password)) {
        if (isCapitalLetterPresent != null) isCapitalLetterPresent(false);
        return false;
      } else if (isCapitalLetterPresent != null) {
        isCapitalLetterPresent(true);
      }
    }

    if (shouldContainSmallLetter) {
      final smallLetterRegex = RegExp(r"[a-z]+");
      if (!smallLetterRegex.hasMatch(password)) {
        if (isSmallLetterPresent != null) isSmallLetterPresent(false);
        return false;
      } else if (isSmallLetterPresent != null) {
        isSmallLetterPresent(true);
      }
    }

    if (shouldContainSpecialChars) {
//      final numberRegex = RegExp(r'(?=.*?[#?!@$%^&*-])');
      final specialRegex = RegExp(r"[\'^£$%!&*()}{@#~?><>,.|=_+¬-]");
      if (!specialRegex.hasMatch(password)) {
        if (isSpecialCharsPresent != null) isSpecialCharsPresent(false);
        return false;
      } else if (isSpecialCharsPresent != null) {
        isSpecialCharsPresent(true);
      }
    }

    return true;
  }

  // FormFieldValidator<String> passwordValidator() {
  //   return FormBuilderValidators.compose([
  //     FormBuilderValidators.required(errorText: "Enter Password"),
  //           FormBuilderValidators.min(8,errorText: "Password must be atleast 8 characters"),
  //   ]);
  // }
  //   FormFieldValidator<String> confirmPasswordValidator({required String password}) {
  //   return FormBuilderValidators.compose([
  //      FormBuilderValidators.notEqual (password,errorText: "Password Mismatch"),
  //     FormBuilderValidators.required(errorText: "Enter Password"),
  //   ]);
  // }
  //  FormFieldValidator<String> phoneValidator() {
  //   return FormBuilderValidators.compose([
  //      FormBuilderValidators.required(errorText: "Enter a valid Phonenumber"),
  //     FormBuilderValidators.min(11,errorText: "Enter a valid Phonenumber"),
  //   ]);
  // }

  // FormFieldValidator<String> accountNumberSignUpValidator() {
  //   return FormBuilderValidators.compose([
  //     FormBuilderValidators.required(errorText: "Enter a valid Account Number"),
  //     // FormBuilderValidators.min(10,errorText: "Enter a valid Account Number"),
  //   ]);
  // }

 
  //  FormFieldValidator<String> pinValidator() {
  //   return FormBuilderValidators.compose([
  //      FormBuilderValidators.required(errorText: "Enter 4 digit pin"),
  //     FormBuilderValidators.min(4,errorText: "Enter 4 digit pin"),

  //   ]);
  // }
  //  FormFieldValidator<String> confirmPinValidator({required String pin}) {
  //   return FormBuilderValidators.compose([
  //      FormBuilderValidators.required(errorText: "Enter a 4 digit pin"),
  //         FormBuilderValidators.notEqual(pin,errorText: "Pin Mismatch"),
  //   ]);
  // }


  // FormFieldValidator<String> emptyFieldValidator(
  //     {required String errorMessage}) {
  //   return FormBuilderValidators.compose([
  //     FormBuilderValidators.required(errorText: errorMessage),
  //   ]);
  // }

  // FormFieldValidator<String> accountNgnNumberValidator(
  //     {bool isValidatedAccount = false, String? message}) {
  //   return FormBuilderValidators.compose([
  //     // if there is an error message, the message will not be null,
  //     // if null that means there is an error and we should show it.
  //     message != null
  //         ? FormBuilderValidators.equal(isValidatedAccount, errorText: message)
  //         : FormBuilderValidators.compose([]),
  //     FormBuilderValidators.required(
  //         errorText: "Enter account number to proceed"),
  //     FormBuilderValidators.equalLength(accountNumberLength,
  //         errorText: "Account number is $accountNumberLength digits")
  //   ]);
  // }

  // FormFieldValidator<String> transferValidator({
  //   required double walletBalance,
  
  // }) {
  //   double walletBalanceAsDouble = walletBalance;
  //   return FormBuilderValidators.compose([
  //     FormBuilderValidators.required(errorText: "Enter an amount"),
     
   
  //   ]);
  // }

  compareWalletBalance(
      {required String walletBalance, required String currentValue}) {
    double walletBalanceAsDouble = double.tryParse(walletBalance) ?? 0;
    double currentValueAsDouble = double.tryParse(currentValue) ?? 0;

    if (currentValueAsDouble > walletBalanceAsDouble) {
      return false;
    }
  }



  String? isPhoneNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (!GetUtils.isNumericOnly(value!.trim()) ||
        !GetUtils.isLengthEqualTo(value.trim(), 11)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

   String? isAddress(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Address is required';
    } else if (!GetUtils.isLengthGreaterThan(value, 4)) {
      return 'Please enter a valid Address';
    }
    return null;
  }

   String? isFullName(String? value) {
    String pattern = r"^([a-zA-Z]{2,}\s[a-zA-z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)";
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (!regExp.hasMatch(value!)) {
      return 'Please enter valid Full name';
    }
    return null;
  }

   String? isName(String? value) {
    String pattern = r"([a-zA-Z]{3,30}\s*)+";
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else if (value!.length < 8) {
      return 'Username must be up to 8 characters';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid Full name';
    }
    return null;
  }

   String? isStrongPassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    }else if (value.length < 8) {
      return 'Password must be up to 8 characters';
    } else if (!value.contains(RegExp(r"[A-Z]"))){
      return 'Password must contain at least one uppercase';
    } else if (!value.contains(RegExp(r"[a-z]"))){
      return 'Password must contain at least one lowercase';
    }else if (!value.contains(RegExp(r"[0-9]"))){
      return 'Password must contain at least one number';
    }
    return null;
  }

  // FormFieldValidator<String> fundValidator({
  //   required double minTransValue,
  // }) {
  //   return FormBuilderValidators.compose([
  //     FormBuilderValidators.required(errorText: "Enter an amount"),
  //     FormBuilderValidators.min(minTransValue,
  //         errorText: "You can only transact with minimum of \$$minTransValue"),
  //     !FinancialCalculations.generalKycValidation()
  //         ? FormBuilderValidators.max(FinancialCalculations.maxKycAmount,
  //             errorText: StatusMessages.kycCompletion)
  //         : FormBuilderValidators.compose([])
  //   ]);
  // }

  // FormFieldValidator<String> maxKycValidator() {
  //   return FormBuilderValidators.compose(
  //       !FinancialCalculations.generalKycValidation()
  //           ? [
  //               FormBuilderValidators.max(FinancialCalculations.maxKycAmount,
  //                   errorText: StatusMessages.kycCompletion)
  //             ]
  //           : []);
  // }
  // FormFieldValidator<String> requiredValidator() {
  //   return FormBuilderValidators.compose([
  //     FormBuilderValidators.required(errorText: "Required"),
  //   ]);
  // }
}

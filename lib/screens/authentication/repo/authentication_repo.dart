

import 'package:giftpose/screens/authentication/models/create_account_request.dart';
import 'package:giftpose/screens/authentication/models/create_account_response.dart';
import 'package:giftpose/screens/authentication/models/forgot_password_request.dart';
import 'package:giftpose/screens/authentication/models/forgot_password_response.dart';
import 'package:giftpose/screens/authentication/models/resend_otp_request.dart';
import 'package:giftpose/screens/authentication/models/resend_otp_response.dart';
import 'package:giftpose/screens/authentication/models/reset_password_request.dart';
import 'package:giftpose/screens/authentication/models/reset_password_response.dart';
import 'package:giftpose/screens/authentication/models/sigin_request.dart';
import 'package:giftpose/screens/authentication/models/signin_response.dart';
import 'package:giftpose/screens/authentication/models/user_me_response.dart';
import 'package:giftpose/screens/authentication/models/verify_email_request.dart';
import 'package:giftpose/screens/authentication/models/verify_email_response.dart';
import 'package:giftpose/screens/onboarding/models/register_location_request.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';

abstract class AuthenticationRepo {

  Future<UserMeResponse> getMe();

  Future<CreateAccountResponse> createAccount({
    required CreateAccountRequest createAccountRequest,
  });

  Future<SignInResponse> signin({ required SignInRequest signinRequest});

  Future<ResetPasswordResponse> resetPassword({ required ResetPasswordRequest resetPasswordRequest});   
    
Future<ForgotPasswordResponse> forgotPassword({ required ForgotPasswordRequest forgotPasswordRequest}); 

Future<VerifyEmailAddressResponse>   verifyEmailAddress({ required VerifyEmailAddressRequest verifyEmailAddressRequest});
    

    Future<ResendOtpResponse> resendOtp({ required ResendOtpRequest resendOtpRequest}); 

 

  Future<void> logout();

}


import 'package:giftpose/screens/onboarding/models/register_location_request.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';

abstract class OnboardingRepo {

  Future<RegisterLocationResponse> registerLocation({
    required RegisterLocationRequest registerLocationRequest,
  });

 


 

}
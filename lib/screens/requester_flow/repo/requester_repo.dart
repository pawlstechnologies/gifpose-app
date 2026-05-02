

import 'dart:io';

import 'package:giftpose/screens/requester_flow/models/analyzeimage_response.dart';

abstract class RequesterRepo {

  Future<AnalyseImageResponse> analyseImage({
    required File file,
  });

 


 

}
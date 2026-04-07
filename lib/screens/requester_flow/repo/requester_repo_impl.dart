import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:giftpose/screens/requester_flow/models/analyzeimage_response.dart';
import 'package:giftpose/screens/requester_flow/repo/requester_repo.dart';
import 'package:giftpose/services/network_services/dio_core/dio_client.dart';
import 'package:giftpose/services/network_services/dio_core/dio_error.dart';
import 'package:giftpose/utils/constants/api_routes.dart';

class RequesterRepoImpl implements RequesterRepo {
    @override
   final NetworkProvider networkProvider = NetworkProvider();

  @override
   Future<AnalyseImageResponse> analyseImage({
    required File file,
  })
 async {
    try {

   
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      final response = await networkProvider.call(
        path: ApiRoutes.analyseImage,
        method: RequestMethod.post,
        body: formData
      );
      log("Analyse image response: ${response?.data}");
     return AnalyseImageResponse.fromJson(response?.data);
      } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/services/network_services/dio_core/dio_error.dart';
import 'package:giftpose/services/network_services/dio_core/dio_intercepter.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart';
import 'package:giftpose/utils/constants/storage_keys.dart';
import 'package:giftpose/utils/locator.dart';



class NetworkProvider{
  Dio _getDioInstance(){
    var dio = Dio(BaseOptions(
      baseUrl: "https://dev.getqost.com/api/v1",
      connectTimeout:const Duration(milliseconds: 60000),
      receiveTimeout:const Duration(milliseconds: 60000),
    ));
    dio.interceptors.add(LoggerInterceptor());
    dio.interceptors.add(AuthorizationInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true,error: true,request: true,requestBody: true));
    return dio;
  }

  Future<Response?> call(
        {required String path,
        BuildContext? context,
        required  RequestMethod method,
        dynamic body=const {},
        Map<String,dynamic> queryParams=const {}
      })async{
    Response? response;
    try{
      switch(method){
        case RequestMethod.get:
          response = await _getDioInstance().get(path, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .post(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.patch:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .patch(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.put:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .put(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.delete:
          if (context != null) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          response = await _getDioInstance()
              .delete(path, data: body, queryParameters: queryParams);
          break;
      }
      return response;
    }on DioException catch (error) {
      return response?.data ??  Future.error(ApiError.fromDio(error));
    }
  }
}


class AuthorizationInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
   SecureStorageService secureStorageService =
        serviceLocator<SecureStorageService>();


final token = await secureStorageService.read(key: StorageKeys.accessToken);
if (token != null && token.isNotEmpty) {
  options.headers["Authorization"] = "Bearer $token";
}

options.headers['Content-Type'] = 'application/json';
options.headers["Accept"] = "application/json";
  
    options.headers['Content-Type'] = 'multipart/form-data';
    options.headers["Accept"] = "application/json";
    options.headers["Content-Type"] = "application/json";
    options.headers["X-App-Name"] = "user";
    super.onRequest(options, handler);
  }
}

enum RequestMethod { get, post, put, patch, delete }
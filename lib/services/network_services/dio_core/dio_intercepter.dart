import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:qost/app.dart';
import 'package:qost/utils/router/app_routes.dart';


class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler,) async{
    final options = err.requestOptions;
    
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      debugPrint('status code 401 ==========================================');
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        AppRoutes.signinScreen,
        (route) => false,
      );
    }
    
    // final refreshToken = await _refreshToken();
    // if (refreshToken != null || refreshToken?.isNotEmpty == true) {
    //   SecureStorageService secureStorageService = serviceLocator<SecureStorageService>();
    //   final token = await secureStorageService.read(key: StorageKeys.accessToken);
    //   final opts = Options(
    //       method: options.method,
    //       headers: {
    //         "Authorization": "Bearer $token",
    //       });
    //   // options.headers['Content-Type'] = 'multipart/form-data';
    //   opts.headers?["Accept"] = "application/json";
    //   opts.headers?["Content-Type"] = "application/json";
    //   // options.headers["Content-Type"] = "application/form-data";
    //   opts.headers?["Connection"] = "keep-alive";
    //   opts.headers?["Accept-Encoding"] = "gzip, deflate, br";
    //   opts.headers?["Accept"] = "*/**";
    //   final cloneReq = await dio.Dio().request(
    //       options.path,
    //       options: opts,
    //       data: options.data,
    //       queryParameters: options.queryParameters);
    //   return handler.resolve(cloneReq);
    // }
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');
    logger.d('Error: ${err.error}, Message: ${err.message}');
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler, ) {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      response.statusCode = 200;
    }
    logger.d('StatusCode: ${response.statusCode}, Data: ${response.data}');
    return super.onResponse(response, handler);
  }
}

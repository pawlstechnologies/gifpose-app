import 'package:dio/dio.dart';

class ApiError {
  String? errorDescription;
  ApiError({this.errorDescription = "Cannot process your request. Please check your network and try again"});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }
  void _handleError(Object error) async {
    if (error is DioError) {
      var dioError = error; // as DioError;
      switch (dioError.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request canceled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Connection timeout';
          break;
        case DioExceptionType.unknown:
          errorDescription = "Cannot process your request. Please check your network and try again";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Receiving timeout';
          break;
        case DioExceptionType.badResponse:
          final response = dioError.response;
          if (response == null) {
            errorDescription = 'Something went wrong, please check your internet connection..';
            break;
          }
          final statusCode = response.statusCode;
          final dynamic data = response.data;
          
          String? message;
          if (data is Map) {
            message = data['message']?.toString();
          } else if (data is String) {
            if (!data.trim().toLowerCase().startsWith('<')) {
              message = data;
            }
          }

          if (statusCode == 401) {
            errorDescription = message ?? 'Session timeout';
          } else if (statusCode == 404) {
            errorDescription = message ?? 'Internal server error';
          } else if (statusCode == 422) {
            errorDescription = message ?? 'Validation error';
          } else if (statusCode == 429) {
            errorDescription = message ?? response.statusMessage ?? 'Too many requests';
          } else if (statusCode != null && statusCode >= 400 && statusCode < 500) {
            errorDescription = message ?? extractDescriptionFromResponse(response);
          } else if (statusCode != null && statusCode >= 500) {
            errorDescription = 'Internal server error';
          } else {
            errorDescription = 'Something went wrong, please check your internet connection..';
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Cannot process your request. Please check your network and try again";
          break;
        case DioErrorType.badCertificate:
          errorDescription = "Cannot process your request. Please check your network and try again";
          break;
        case DioErrorType.connectionError:
          errorDescription = "Cannot process your request. Please check your network and try again";
          break;
      }
    } else {
      errorDescription = "Cannot process your request. Please check your network and try again";
    }
  }

  String? extractDescriptionFromResponse(Response? response) {
    if (response == null) return null;
    final dynamic data = response.data;
    if (data == null) return response.statusMessage;

    try {
      if (data is Map) {
        String? message;
        if (data['data'] is Map && data['data']['error'] != null) {
          message = data['data']['error'].toString();
        }
        if (data['message'] != null) {
          final msg = data['message'].toString();
          if (message != null) {
            message = '$message. $msg';
          } else {
            message = msg;
          }
          if (data['error'] != null) {
            message = '$message. ${data['error']}';
          }
        } else if (data['error'] != null) {
          if (message != null) {
            message = '$message. ${data['error']}';
          } else {
            message = data['error'].toString();
          }
        }
        return message ?? response.statusMessage;
      } else if (data is String) {
        if (data.trim().toLowerCase().startsWith('<')) {
          return response.statusMessage ?? 'Internal server error';
        }
        return data;
      }
    } catch (error) {
      return response.statusMessage ?? error.toString();
    }
    return response.statusMessage;
  }

  @override
  String toString() => errorDescription ?? "Cannot process your request. Please try again";
}
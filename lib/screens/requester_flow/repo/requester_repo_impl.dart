import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:giftpose/screens/requester_flow/models/analyzeimage_response.dart';
import 'package:giftpose/screens/requester_flow/models/item_api_models.dart';
import 'package:giftpose/screens/requester_flow/repo/requester_repo.dart';
import 'package:giftpose/services/network_services/dio_core/dio_client.dart';
import 'package:giftpose/services/network_services/dio_core/dio_error.dart';
import 'package:giftpose/services/image_utility.dart';
import 'package:giftpose/utils/constants/api_routes.dart';

class RequesterRepoImpl implements RequesterRepo {
  final NetworkProvider networkProvider = NetworkProvider();

  @override
  Future<AnalyseImageResponse> analyseImage({required List<File> files}) async {
    try {
      if (files.isEmpty) {
        throw 'Select at least one image.';
      }
      if (await ImageUtility.totalSize(files) > ImageUtility.maxUploadBytes) {
        throw 'The selected images are too large. Select fewer images and try again.';
      }
      final formData = FormData.fromMap({
        'images': await Future.wait(
          files.map(
            (file) => MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        ),
      });

      final response = await networkProvider.call(
        path: ApiRoutes.analyseImage,
        method: RequestMethod.post,
        body: formData,
      );
      log("Analyse image response: ${response?.data}");
      return AnalyseImageResponse.fromJson(
        Map<String, dynamic>.from(response?.data as Map),
      );
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

  @override
  Future<ItemMutationResponse> postItem(ItemMutationRequest request) =>
      _mutate(ApiRoutes.postItem, RequestMethod.post, request);

  @override
  Future<ItemMutationResponse> postRequestedItem(ItemMutationRequest request) =>
      _mutate(ApiRoutes.postRequestedItem, RequestMethod.post, request);

  @override
  Future<ItemMutationResponse> updateItem({
    required String id,
    required ItemMutationRequest request,
  }) => _mutate(ApiRoutes.updateItem(id), RequestMethod.patch, request);

  @override
  Future<List<PickupOption>> getPickupOptions() async {
    try {
      final response = await networkProvider.call(
        path: ApiRoutes.pickupOptions,
        method: RequestMethod.get,
      );
      final json = Map<String, dynamic>.from(response?.data as Map);
      return (json['data'] as List? ?? const [])
          .map(
            (item) =>
                PickupOption.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .where((option) => option.name.isNotEmpty)
          .toList();
    } catch (error) {
      throw _messageFor(error);
    }
  }

  Future<ItemMutationResponse> _mutate(
    String path,
    RequestMethod method,
    ItemMutationRequest request,
  ) async {
    try {
      final response = await networkProvider.call(
        path: path,
        method: method,
        body: request.toJson(),
      );
      return ItemMutationResponse.fromJson(
        Map<String, dynamic>.from(response?.data as Map),
      );
    } catch (error) {
      throw _messageFor(error);
    }
  }

  String _messageFor(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      return ApiError.fromDio(error).errorDescription ?? error.toString();
    }
    return error.toString();
  }
}

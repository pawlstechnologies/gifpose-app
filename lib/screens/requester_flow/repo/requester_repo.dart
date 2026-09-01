import 'dart:io';

import 'package:giftpose/screens/requester_flow/models/analyzeimage_response.dart';
import 'package:giftpose/screens/requester_flow/models/item_api_models.dart';

abstract class RequesterRepo {
  Future<AnalyseImageResponse> analyseImage({required List<File> files});

  Future<ItemMutationResponse> postItem(ItemMutationRequest request);

  Future<ItemMutationResponse> postRequestedItem(ItemMutationRequest request);

  Future<List<PickupOption>> getPickupOptions();

  Future<ItemMutationResponse> updateItem({
    required String id,
    required ItemMutationRequest request,
  });
}

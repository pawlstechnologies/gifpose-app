import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giftpose/screens/requester_flow/models/analyzeimage_response.dart';
import 'package:giftpose/screens/requester_flow/models/item_api_models.dart';
import 'package:giftpose/screens/requester_flow/repo/requester_repo.dart';
import 'package:giftpose/services/image_utility.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:image_picker/image_picker.dart';

enum OfferFilter { nearest, bestRating, newest }

class RequesterViewmodel extends ChangeNotifier {
  RequesterViewmodel({RequesterRepo? requesterRepo})
    : _requesterRepo = requesterRepo ?? serviceLocator<RequesterRepo>() {
    Future<void>.microtask(fetchPickupOptions);
  }

  final RequesterRepo _requesterRepo;
  final itemNameCtrl = TextEditingController();
  final itemDescriptionCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final List<File> _referenceImages = [];
  final List<String> _imageUrls = [];

  List<File> get referenceImages => List.unmodifiable(_referenceImages);
  List<String> get imageUrls => List.unmodifiable(_imageUrls);
  List<PickupOption> pickupOptions = const [];
  String? selectedPickupOption;
  OfferFilter _offerFilter = OfferFilter.nearest;
  OfferFilter get offerFilter => _offerFilter;
  bool isAnalyzing = false;
  bool isSubmitting = false;
  bool isLoadingPickupOptions = false;
  String? errorMessage;
  String? successMessage;
  String? itemId;
  String country = 'GB';
  String? categoryId;
  String? subcategoryId;
  String? contentId;
  String? suggestedCategoryId;
  String? suggestedSubcategoryId;
  String? suggestedContentId;

  void selectPickupOption(String value) {
    if (selectedPickupOption == value) return;
    selectedPickupOption = value;
    notifyListeners();
  }

  void selectOfferFilter(OfferFilter value) {
    if (_offerFilter == value) return;
    _offerFilter = value;
    notifyListeners();
  }

  Future<void> fetchPickupOptions() async {
    isLoadingPickupOptions = true;
    notifyListeners();
    try {
      pickupOptions = await _requesterRepo.getPickupOptions();
      if (selectedPickupOption == null && pickupOptions.isNotEmpty) {
        selectedPickupOption = pickupOptions.first.name;
      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoadingPickupOptions = false;
      notifyListeners();
    }
  }

  Future<void> pickReferenceImages() async {
    final remainingSlots = 10 - _referenceImages.length;
    if (remainingSlots <= 0) return;
    final images = await _imagePicker.pickMultiImage(
      limit: remainingSlots,
      maxWidth: ImageUtility.uploadMaxWidth,
      maxHeight: ImageUtility.uploadMaxHeight,
      imageQuality: ImageUtility.uploadQuality,
    );
    if (images.isEmpty) return;
    final newImages = images.map((image) => File(image.path)).toList();
    final uploadSize = await ImageUtility.totalSize(newImages);
    if (uploadSize > ImageUtility.maxUploadBytes) {
      errorMessage =
          'The selected images are still too large. Select fewer images and try again.';
      notifyListeners();
      return;
    }
    _referenceImages.addAll(newImages);
    notifyListeners();
    await analyseImages(newImages);
  }

  Future<void> analyseImages(List<File> images) async {
    isAnalyzing = true;
    errorMessage = null;
    notifyListeners();
    try {
      final response = await _requesterRepo.analyseImage(files: images);
      _applyAnalysis(response.data);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isAnalyzing = false;
      notifyListeners();
    }
  }

  void _applyAnalysis(Data data) {
    itemNameCtrl.text = data.name;
    itemDescriptionCtrl.text = data.description;
    _imageUrls
      ..clear()
      ..addAll(data.images);
    categoryId = null;
    final subcategory = data.category.subcategories?.firstOrNull;
    subcategoryId = null;
    contentId = null;
    suggestedCategoryId = data.category.id;
    suggestedSubcategoryId = subcategory?.id;
    suggestedContentId = subcategory?.contents.firstOrNull?.id;
    final suggested = data.suggestedCategory;
    if (suggested is Map) {
      suggestedCategoryId = suggested['_id']?.toString();
      final subcategories = suggested['subcategories'];
      if (subcategories is List &&
          subcategories.isNotEmpty &&
          subcategories.first is Map) {
        final sub = subcategories.first as Map;
        suggestedSubcategoryId = sub['_id']?.toString();
        final contents = sub['contents'];
        if (contents is List && contents.isNotEmpty && contents.first is Map) {
          suggestedContentId = (contents.first as Map)['_id']?.toString();
        }
      }
    }
  }

  Future<bool> submit({bool isEditing = false}) async {
    if (itemNameCtrl.text.trim().isEmpty ||
        itemDescriptionCtrl.text.trim().isEmpty ||
        locationCtrl.text.trim().isEmpty ||
        _imageUrls.isEmpty ||
        selectedPickupOption == null) {
      errorMessage = 'Please complete all fields and upload an image.';
      notifyListeners();
      return false;
    }
    if (isEditing && itemId == null) {
      errorMessage = 'The item ID is missing, so this post cannot be updated.';
      notifyListeners();
      return false;
    }
    isSubmitting = true;
    errorMessage = null;
    notifyListeners();
    try {
      final request = _buildRequest();
      final response = isEditing
          ? await _requesterRepo.updateItem(id: itemId!, request: request)
          : await _requesterRepo.postRequestedItem(request);
      if (!response.success) throw response.message;
      itemId = response.itemId ?? itemId;
      successMessage = response.message;
      return true;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  ItemMutationRequest _buildRequest() => ItemMutationRequest(
    name: itemNameCtrl.text.trim(),
    description: itemDescriptionCtrl.text.trim(),
    imageUrls: _imageUrls,
    type: 'request',
    pickup: selectedPickupOption,
    postCode: locationCtrl.text.trim(),
    country: country,
    categoryId: categoryId,
    subcategoryId: subcategoryId,
    contentId: contentId,
    suggestedCategoryId: suggestedCategoryId,
    suggestedSubcategoryId: suggestedSubcategoryId,
    suggestedContentId: suggestedContentId,
  );

  void removeReferenceImage(int index) {
    if (index < 0 || index >= _referenceImages.length) return;
    _referenceImages.removeAt(index);
    if (index < _imageUrls.length) _imageUrls.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    itemNameCtrl.dispose();
    itemDescriptionCtrl.dispose();
    locationCtrl.dispose();
    super.dispose();
  }
}

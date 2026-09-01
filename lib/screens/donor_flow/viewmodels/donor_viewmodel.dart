import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giftpose/screens/requester_flow/models/item_api_models.dart';
import 'package:giftpose/screens/requester_flow/repo/requester_repo.dart';
import 'package:giftpose/services/image_utility.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:image_picker/image_picker.dart';

enum DonorPostStep { compose, analyzing, review }

class DonorViewmodel extends ChangeNotifier {
  DonorViewmodel({RequesterRepo? requesterRepo})
    : _requesterRepo = requesterRepo ?? serviceLocator<RequesterRepo>() {
    Future<void>.microtask(fetchPickupOptions);
  }

  final RequesterRepo _requesterRepo;
  final itemNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final reviewController = TextEditingController();
  final postCodeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  DonorPostStep postStep = DonorPostStep.compose;
  File? selectedImage;
  List<String> imageUrls = const [];
  List<PickupOption> pickupOptions = const [];
  String? selectedPickupOption;
  String category = '';
  String location = '';
  String country = 'GB';
  int selectedRating = 0;
  bool isSubmitting = false;
  bool isLoadingPickupOptions = false;
  String? errorMessage;
  String? successMessage;
  String? itemId;
  String? categoryId;
  String? subcategoryId;
  String? contentId;
  String? suggestedCategoryId;
  String? suggestedSubcategoryId;
  String? suggestedContentId;

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

  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: ImageUtility.uploadMaxWidth,
      maxHeight: ImageUtility.uploadMaxHeight,
      imageQuality: ImageUtility.uploadQuality,
    );
    if (image == null) return;
    selectedImage = File(image.path);
    if (await selectedImage!.length() > ImageUtility.maxUploadBytes) {
      selectedImage = null;
      errorMessage = 'The selected image is too large. Choose another image.';
      notifyListeners();
      return;
    }
    postStep = DonorPostStep.analyzing;
    errorMessage = null;
    notifyListeners();
    try {
      final data = (await _requesterRepo.analyseImage(
        files: [selectedImage!],
      )).data;
      itemNameController.text = data.name;
      descriptionController.text = data.description;
      imageUrls = data.images;
      category = data.category.name;
      categoryId = null;
      final subcategory = data.category.subcategories?.firstOrNull;
      subcategoryId = null;
      contentId = null;
      suggestedCategoryId = data.category.id;
      suggestedSubcategoryId = subcategory?.id;
      suggestedContentId = subcategory?.contents.firstOrNull?.id;
      postStep = DonorPostStep.review;
    } catch (error) {
      errorMessage = error.toString();
      postStep = DonorPostStep.compose;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> submit({
    bool isEditing = false,
    bool offeringRequestedItem = false,
  }) async {
    final postCode = postCodeController.text.trim().isEmpty
        ? location.trim()
        : postCodeController.text.trim();
    if (itemNameController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        imageUrls.isEmpty ||
        postCode.isEmpty) {
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
      final request = ItemMutationRequest(
        name: itemNameController.text.trim(),
        description: descriptionController.text.trim(),
        imageUrls: imageUrls,
        type: offeringRequestedItem ? 'offer' : null,
        pickup: offeringRequestedItem ? selectedPickupOption : null,
        postCode: postCode,
        country: country,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        contentId: contentId,
        suggestedCategoryId: suggestedCategoryId,
        suggestedSubcategoryId: suggestedSubcategoryId,
        suggestedContentId: suggestedContentId,
      );
      final response = isEditing
          ? await _requesterRepo.updateItem(id: itemId!, request: request)
          : offeringRequestedItem
          ? await _requesterRepo.postRequestedItem(request)
          : await _requesterRepo.postItem(request);
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

  void selectPickupOption(String value) {
    selectedPickupOption = value;
    notifyListeners();
  }

  void removeImage() {
    selectedImage = null;
    imageUrls = const [];
    postStep = DonorPostStep.compose;
    notifyListeners();
  }

  void showReview() {
    if (selectedImage == null) {
      errorMessage = 'Upload an image before continuing.';
      notifyListeners();
      return;
    }
    postStep = DonorPostStep.review;
    notifyListeners();
  }

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  void setLocation(String value) {
    location = value;
    postCodeController.text = value;
    notifyListeners();
  }

  void setRating(int value) {
    selectedRating = value;
    notifyListeners();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    descriptionController.dispose();
    reviewController.dispose();
    postCodeController.dispose();
    super.dispose();
  }
}

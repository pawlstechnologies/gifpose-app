class ItemMutationRequest {
  const ItemMutationRequest({
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.postCode,
    required this.country,
    this.type,
    this.pickup,
    this.categoryId,
    this.subcategoryId,
    this.contentId,
    this.suggestedCategoryId,
    this.suggestedSubcategoryId,
    this.suggestedContentId,
  });

  final String name;
  final String description;
  final List<String> imageUrls;
  final String postCode;
  final String country;
  final String? type;
  final String? pickup;
  final String? categoryId;
  final String? subcategoryId;
  final String? contentId;
  final String? suggestedCategoryId;
  final String? suggestedSubcategoryId;
  final String? suggestedContentId;

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'imageUrls': imageUrls,
    if (type != null) 'type': type,
    if (pickup != null) 'pickup': pickup,
    'postCode': postCode,
    'country': country,
    'categoryId': categoryId,
    'subcategoryId': subcategoryId,
    'contentId': contentId,
    'suggestedCategoryId': suggestedCategoryId,
    'suggestedSubcategoryId': suggestedSubcategoryId,
    'suggestedContentId': suggestedContentId,
  };
}

class ItemMutationResponse {
  const ItemMutationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final Map<String, dynamic> data;

  factory ItemMutationResponse.fromJson(Map<String, dynamic> json) {
    return ItemMutationResponse(
      success: json['status'] == true || json['success'] == true,
      message: json['message']?.toString() ?? '',
      data: Map<String, dynamic>.from(json['data'] as Map? ?? const {}),
    );
  }

  String? get itemId => data['_id']?.toString();
}

class PickupOption {
  const PickupOption(this.name);

  final String name;

  factory PickupOption.fromJson(Map<String, dynamic> json) =>
      PickupOption(json['name']?.toString() ?? '');
}

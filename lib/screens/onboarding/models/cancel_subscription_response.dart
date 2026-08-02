class CancelSubscriptionResponse {
  final bool? status;
  final String? message;
  final dynamic data;

  CancelSubscriptionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CancelSubscriptionResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CancelSubscriptionResponse();
    return CancelSubscriptionResponse(
      status: json['status'] as bool? ?? (json['success'] as bool?),
      message: json['message'] as String?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}

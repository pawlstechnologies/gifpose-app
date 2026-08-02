class CurrentSubscriptionResponse {
  final bool? success;
  final bool? status;
  final String? message;
  final CurrentSubscriptionData? data;

  CurrentSubscriptionResponse({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CurrentSubscriptionResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CurrentSubscriptionResponse();
    return CurrentSubscriptionResponse(
      success: json['success'] as bool? ?? json['status'] as bool?,
      status: json['status'] as bool? ?? json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null && json['data'] is Map<String, dynamic>
          ? CurrentSubscriptionData.fromJson(json['data'] as Map<String, dynamic>)
          : (json['subscription'] != null && json['subscription'] is Map<String, dynamic>
              ? CurrentSubscriptionData.fromJson(json['subscription'] as Map<String, dynamic>)
              : null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class CurrentSubscriptionData {
  final String? id;
  final String? deviceId;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final String? stripePriceId;
  final String? plan;
  final String? status;
  final String? currentPeriodEnd;
  final bool? cancelAtPeriodEnd;
  final String? createdAt;
  final String? updatedAt;

  CurrentSubscriptionData({
    this.id,
    this.deviceId,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.stripePriceId,
    this.plan,
    this.status,
    this.currentPeriodEnd,
    this.cancelAtPeriodEnd,
    this.createdAt,
    this.updatedAt,
  });

  factory CurrentSubscriptionData.fromJson(Map<String, dynamic> json) {
    return CurrentSubscriptionData(
      id: (json['_id'] ?? json['id'])?.toString(),
      deviceId: json['deviceId']?.toString(),
      stripeCustomerId: json['stripeCustomerId']?.toString(),
      stripeSubscriptionId: json['stripeSubscriptionId']?.toString(),
      stripePriceId: json['stripePriceId']?.toString(),
      plan: json['plan']?.toString(),
      status: json['status']?.toString(),
      currentPeriodEnd: json['currentPeriodEnd']?.toString(),
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool?,
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'deviceId': deviceId,
      'stripeCustomerId': stripeCustomerId,
      'stripeSubscriptionId': stripeSubscriptionId,
      'stripePriceId': stripePriceId,
      'plan': plan,
      'status': status,
      'currentPeriodEnd': currentPeriodEnd,
      'cancelAtPeriodEnd': cancelAtPeriodEnd,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

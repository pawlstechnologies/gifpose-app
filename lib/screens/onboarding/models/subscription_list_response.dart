class SubscriptionListResponse {
  final bool? status;
  final String? message;
  final List<SubscriptionItem>? data;

  SubscriptionListResponse({this.status, this.message, this.data});

  factory SubscriptionListResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SubscriptionListResponse();
    return SubscriptionListResponse(
      status: json['status'] as bool? ?? (json['success'] as bool?),
      message: json['message'] as String?,
      data: json['data'] != null && json['data'] is List
          ? (json['data'] as List)
                .map(
                  (e) => SubscriptionItem.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubscriptionItem {
  final String? id;
  final String? stripeSubscriptionId;
  final String? deviceId;
  final String? userId;
  final String? plan;
  final String? status;
  final String? amount;
  final String? currency;
  final String? createdAt;
  final String? nextBillingDate;
  final bool? autoRenew;

  SubscriptionItem({
    this.id,
    this.stripeSubscriptionId,
    this.deviceId,
    this.userId,
    this.plan,
    this.status,
    this.amount,
    this.currency,
    this.createdAt,
    this.nextBillingDate,
    this.autoRenew,
  });

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) {
    return SubscriptionItem(
      id: (json['_id'] ?? json['id'])?.toString(),
      stripeSubscriptionId: (json['stripeSubscriptionId'] ?? json['_id'] ?? json['id'])?.toString(),
      deviceId: json['deviceId']?.toString(),
      userId: json['userId']?.toString(),
      plan: json['plan']?.toString(),
      status: json['status']?.toString(),
      amount: json['amount']?.toString(),
      currency: json['currency']?.toString(),
      createdAt: (json['createdAt'] ?? json['date'] ?? json['created_at'])
          ?.toString(),
      nextBillingDate: (json['nextBillingDate'] ?? json['next_billing_date'])
          ?.toString(),
      autoRenew: json['autoRenew'] as bool? ?? json['auto_renew'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stripeSubscriptionId': stripeSubscriptionId,
      'deviceId': deviceId,
      'userId': userId,
      'plan': plan,
      'status': status,
      'amount': amount,
      'currency': currency,
      'createdAt': createdAt,
      'nextBillingDate': nextBillingDate,
      'autoRenew': autoRenew,
    };
  }
}

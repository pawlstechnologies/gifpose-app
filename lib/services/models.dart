

class Failure {
    String? responseCode;
    String? responseDescription;

    Failure({
        this.responseCode,
        this.responseDescription,
    });

    factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        responseCode: json["ResponseCode"],
        responseDescription: json["ResponseDescription"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseDescription": responseDescription,
    };

 @override
  String toString() => responseDescription ?? "";
}



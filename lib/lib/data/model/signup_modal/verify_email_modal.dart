// To parse this JSON data, do
//
//     final verifyEmailModal = verifyEmailModalFromJson(jsonString);

import 'dart:convert';

class VerifyEmailModal {
  VerifyEmailModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory VerifyEmailModal.fromRawJson(String str) =>
      VerifyEmailModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyEmailModal.fromJson(Map<String, dynamic> json) =>
      VerifyEmailModal(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        response: List<Response>.from(
            json["Response"].map((x) => Response.fromJson(x))),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Response": List<dynamic>.from(response!.map((x) => x.toJson())),
        "errors": errors,
      };
}

class Response {
  Response({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.accessToken,
  });

  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? accessToken;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["UserId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "accessToken": accessToken,
      };
}

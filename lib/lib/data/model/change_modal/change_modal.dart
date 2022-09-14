// To parse this JSON data, do
//
//     final changePasswordModal = changePasswordModalFromJson(jsonString);

import 'dart:convert';

class ChangePasswordModal {
  ChangePasswordModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<String>? response;
  String? errors;

  factory ChangePasswordModal.fromRawJson(String str) =>
      ChangePasswordModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangePasswordModal.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModal(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        response: List<String>.from(json["Response"].map((x) => x)),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Response": List<dynamic>.from(response!.map((x) => x)),
        "errors": errors,
      };
}

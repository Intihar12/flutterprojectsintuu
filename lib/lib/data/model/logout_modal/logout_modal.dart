// To parse this JSON data, do
//
//     final logoutModal = logoutModalFromJson(jsonString);

import 'dart:convert';

class LogoutModal {
  LogoutModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<dynamic>? response;
  String? errors;

  factory LogoutModal.fromRawJson(String str) =>
      LogoutModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogoutModal.fromJson(Map<String, dynamic> json) => LogoutModal(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        response: List<dynamic>.from(json["Response"].map((x) => x)),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Response": List<dynamic>.from(response!.map((x) => x)),
        "errors": errors,
      };
}

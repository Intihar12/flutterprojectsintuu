// To parse this JSON data, do
//
//     final userAgreementModal = userAgreementModalFromJson(jsonString);

import 'dart:convert';

class UserAgreementModal {
  UserAgreementModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  String? response;
  String? errors;

  factory UserAgreementModal.fromRawJson(String str) =>
      UserAgreementModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAgreementModal.fromJson(Map<String, dynamic> json) =>
      UserAgreementModal(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        response: json["Response"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Response": response,
        "errors": errors,
      };
}

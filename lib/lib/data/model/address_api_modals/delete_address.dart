// To parse this JSON data, do
//
//     final deleteAddressModal = deleteAddressModalFromJson(jsonString);

import 'dart:convert';

class DeleteAddressModal {
  DeleteAddressModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<dynamic>? response;
  String? errors;

  factory DeleteAddressModal.fromRawJson(String str) =>
      DeleteAddressModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteAddressModal.fromJson(Map<String, dynamic> json) =>
      DeleteAddressModal(
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

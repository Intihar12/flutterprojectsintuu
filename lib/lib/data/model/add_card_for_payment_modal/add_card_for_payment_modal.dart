// To parse this JSON data, do
//
//     final addCardForPaymentModal = addCardForPaymentModalFromJson(jsonString);

import 'dart:convert';

class AddCardForPaymentModal {
  AddCardForPaymentModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<dynamic>? response;
  String? errors;

  factory AddCardForPaymentModal.fromRawJson(String str) =>
      AddCardForPaymentModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCardForPaymentModal.fromJson(Map<String, dynamic> json) =>
      AddCardForPaymentModal(
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

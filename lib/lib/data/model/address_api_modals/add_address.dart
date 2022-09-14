// To parse this JSON data, do
//
//     final addAddressModal = addAddressModalFromJson(jsonString);

import 'dart:convert';

class AddAddressModal {
  AddAddressModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory AddAddressModal.fromRawJson(String str) =>
      AddAddressModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddAddressModal.fromJson(Map<String, dynamic> json) =>
      AddAddressModal(
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
    this.addressId,
  });

  String? addressId;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        addressId: json["addressId"],
      );

  Map<String, dynamic> toJson() => {
        "addressId": addressId,
      };
}

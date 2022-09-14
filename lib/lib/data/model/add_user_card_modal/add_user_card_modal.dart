// To parse this JSON data, do
//
//     final addUserCardsModal = addUserCardsModalFromJson(jsonString);

import 'dart:convert';

class AddUserCardsModal {
  AddUserCardsModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory AddUserCardsModal.fromRawJson(String str) =>
      AddUserCardsModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddUserCardsModal.fromJson(Map<String, dynamic> json) =>
      AddUserCardsModal(
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
    this.pmId,
    this.brand,
    this.last4Digits,
    this.image,
  });

  String? pmId;
  String? brand;
  String? last4Digits;
  String? image;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        pmId: json["pmId"],
        brand: json["brand"],
        last4Digits: json["last4digits"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "pmId": pmId,
        "brand": brand,
        "last4digits": last4Digits,
        "image": image,
      };
}

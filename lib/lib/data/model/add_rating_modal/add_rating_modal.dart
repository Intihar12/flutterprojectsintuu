// To parse this JSON data, do
//
//     final addRatingModal = addRatingModalFromJson(jsonString);

import 'dart:convert';

class AddRatingModal {
  AddRatingModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory AddRatingModal.fromRawJson(String str) =>
      AddRatingModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddRatingModal.fromJson(Map<String, dynamic> json) => AddRatingModal(
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
    this.receivedAmount,
  });

  int? receivedAmount;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        receivedAmount: json["receivedAmount"],
      );

  Map<String, dynamic> toJson() => {
        "receivedAmount": receivedAmount,
      };
}

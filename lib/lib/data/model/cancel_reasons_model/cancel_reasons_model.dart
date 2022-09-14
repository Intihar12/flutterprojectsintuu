// To parse this JSON data, do
//
//     final cancelReasonsModel = cancelReasonsModelFromJson(jsonString);

import 'dart:convert';

CancelReasonsModel cancelReasonsModelFromJson(String str) => CancelReasonsModel.fromJson(json.decode(str));

String cancelReasonsModelToJson(CancelReasonsModel data) => json.encode(data.toJson());

class CancelReasonsModel {
  CancelReasonsModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<Response> ? response;
  String ? errors;

  factory CancelReasonsModel.fromJson(Map<String, dynamic> json) => CancelReasonsModel(
    responseCode: json["ResponseCode"],
    responseMessage: json["ResponseMessage"],
    response: List<Response>.from(json["Response"].map((x) => Response.fromJson(x))),
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
    this.reasonText,
  });

  String? reasonText;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    reasonText: json["reasonText"],
  );

  Map<String, dynamic> toJson() => {
    "reasonText": reasonText,
  };
}

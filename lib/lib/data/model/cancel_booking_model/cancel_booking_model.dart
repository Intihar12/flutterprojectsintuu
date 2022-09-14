// To parse this JSON data, do
//
//     final cancelBookingModel = cancelBookingModelFromJson(jsonString);

import 'dart:convert';

CancelBookingModel cancelBookingModelFromJson(String str) => CancelBookingModel.fromJson(json.decode(str));

String cancelBookingModelToJson(CancelBookingModel data) => json.encode(data.toJson());

class CancelBookingModel {
  CancelBookingModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<dynamic> ? response;
  String ? errors;

  factory CancelBookingModel.fromJson(Map<String, dynamic> json) => CancelBookingModel(
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

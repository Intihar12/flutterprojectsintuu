// To parse this JSON data, do
//
//     final forgotPassword = forgotPasswordFromJson(jsonString);

import 'dart:convert';

ForgotPasswordModel forgotPasswordFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<Response> ? response;
  String ? errors;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
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
    this.userId,
    this.forgetRequestId,
  });

  String ? userId;
  String ? forgetRequestId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    userId: json["userId"],
    forgetRequestId: json["forgetRequestId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "forgetRequestId": forgetRequestId,
  };
}

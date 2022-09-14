// To parse this JSON data, do
//
//     final otpResendModel = otpResendModelFromJson(jsonString);

import 'dart:convert';

OtpResendModel otpResendModelFromJson(String str) => OtpResendModel.fromJson(json.decode(str));

String otpResendModelToJson(OtpResendModel data) => json.encode(data.toJson());

class OtpResendModel {
  OtpResendModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<Response> ? response;
  String ? errors;

  factory OtpResendModel.fromJson(Map<String, dynamic> json) => OtpResendModel(
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
    this.firstName,
    this.lastName,
    this.email,
    this.accessToken,
  });

  String ? userId;
  String ? firstName;
  String ? lastName;
  String ? email;
  String ? accessToken;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    userId: json["UserId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "accessToken": accessToken,
  };
}

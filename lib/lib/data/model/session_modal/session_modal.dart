// To parse this JSON data, do
//
//     final sessionModal = sessionModalFromJson(jsonString);

import 'dart:convert';

class SessionModal {
  SessionModal({
    this.responseCode,
    this.responseMessage,
    this.sessionKey,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  String? sessionKey;
  List<Response>? response;
  String? errors;

  factory SessionModal.fromRawJson(String str) =>
      SessionModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SessionModal.fromJson(Map<String, dynamic> json) => SessionModal(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        sessionKey: json["sessionKey"],
        response: List<Response>.from(
            json["Response"].map((x) => Response.fromJson(x))),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "sessionKey": sessionKey,
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

  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? accessToken;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

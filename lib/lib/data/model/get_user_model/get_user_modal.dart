// To parse this JSON data, do
//
//     final getUserModal = getUserModalFromJson(jsonString);

import 'dart:convert';

class GetUserModal {
  GetUserModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory GetUserModal.fromRawJson(String str) =>
      GetUserModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserModal.fromJson(Map<String, dynamic> json) => GetUserModal(
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
    this.firstName,
    this.lastName,
    this.countryCode,
    this.phoneNum,
    this.email,
  });

  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNum;
  String? email;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        firstName: json["firstName"],
        lastName: json["lastName"],
        countryCode: json["countryCode"],
        phoneNum: json["phoneNum"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "countryCode": countryCode,
        "phoneNum": phoneNum,
        "email": email,
      };
}

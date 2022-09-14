// To parse this JSON data, do
//
//     final updateUserModal = updateUserModalFromJson(jsonString);

import 'dart:convert';

class UpdateUserModal {
  UpdateUserModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory UpdateUserModal.fromRawJson(String str) =>
      UpdateUserModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateUserModal.fromJson(Map<String, dynamic> json) =>
      UpdateUserModal(
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
  });

  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNum;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        firstName: json["firstName"],
        lastName: json["lastName"],
        countryCode: json["countryCode"],
        phoneNum: json["phoneNum"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "countryCode": countryCode,
        "phoneNum": phoneNum,
      };
}

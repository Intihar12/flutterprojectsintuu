// To parse this JSON data, do
//
//     final getVehicleModel = getVehicleModelFromJson(jsonString);

import 'dart:convert';

GetVehicleModel getVehicleModelFromJson(String str) => GetVehicleModel.fromJson(json.decode(str));

String getVehicleModelToJson(GetVehicleModel data) => json.encode(data.toJson());

class GetVehicleModel {
  GetVehicleModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<Response> ? response;
  String ? errors;

  factory GetVehicleModel.fromJson(Map<String, dynamic> json) => GetVehicleModel(
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
    this.id,
    this.name,
    this.image,
  });

  int ? id;
  String ? name;
  String ? image;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

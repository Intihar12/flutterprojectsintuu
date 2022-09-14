// To parse this JSON data, do
//
//     final restricktedItemModel = restricktedItemModelFromJson(jsonString);

import 'dart:convert';

RestricktedItemModel restricktedItemModelFromJson(String str) => RestricktedItemModel.fromJson(json.decode(str));

String restricktedItemModelToJson(RestricktedItemModel data) => json.encode(data.toJson());

class RestricktedItemModel {
  RestricktedItemModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<Response> ? response;
  String ? errors;

  factory RestricktedItemModel.fromJson(Map<String, dynamic> json) => RestricktedItemModel(
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
    this.titles,
    this.images,
  });

  List<String> ? titles;
  List<String> ? images;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    titles: List<String>.from(json["titles"].map((x) => x)),
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "titles": List<dynamic>.from(titles!.map((x) => x)),
    "images": List<dynamic>.from(images!.map((x) => x)),
  };
}

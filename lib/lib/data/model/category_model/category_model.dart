// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

class CategoryModel {
  CategoryModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
    this.insuranceText,
    this.loadUnloadChargesText,
    this.insuranceChargesText,
    this.categories,
  });

  String? insuranceText;
  String? loadUnloadChargesText;
  String? insuranceChargesText;
  List<Category>? categories;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        insuranceText: json["insuranceText"],
        loadUnloadChargesText: json["load_unload_chargesText"],
        insuranceChargesText: json["insurance_chargesText"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "insuranceText": insuranceText,
        "load_unload_chargesText": loadUnloadChargesText,
        "insurance_chargesText": insuranceChargesText,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.status,
    this.adult18Plus,
  });

  int? id;
  String? name;
  String? image;
  bool? status;
  bool? adult18Plus;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["Image"],
        status: json["status"],
        adult18Plus: json["adult_18plus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Image": image,
        "status": status,
        "adult_18plus": adult18Plus,
      };
}

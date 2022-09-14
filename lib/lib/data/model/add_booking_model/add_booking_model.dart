// To parse this JSON data, do
//
//     final addBookingModel = addBookingModelFromJson(jsonString);

import 'dart:convert';

AddBookingModel addBookingModelFromJson(String str) => AddBookingModel.fromJson(json.decode(str));

String addBookingModelToJson(AddBookingModel data) => json.encode(data.toJson());

class AddBookingModel {
  AddBookingModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<Response> ? response;
  String ? errors;

  factory AddBookingModel.fromJson(Map<String, dynamic> json) => AddBookingModel(
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
    this.bookingId,
    this.packageIds,
    this.total,
    this.distance,
    this.loadAmount,
  });

  String ? bookingId;
  List<PackageId> ? packageIds;
  String ? total;
  String ? distance;
  String ? loadAmount;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    bookingId: json["BookingId"],
    packageIds: List<PackageId>.from(json["packageIds"].map((x) => PackageId.fromJson(x))),
    total: json["total"],
    distance: json["distance"],
    loadAmount: json["loadAmount"],
  );

  Map<String, dynamic> toJson() => {
    "BookingId": bookingId,
    "packageIds": List<dynamic>.from(packageIds!.map((x) => x.toJson())),
    "total": total,
    "distance": distance,
    "loadAmount": loadAmount,
  };
}

class PackageId {
  PackageId({
    this.id,
    this.total,
  });

  List<int> ? id;
  List<String> ? total;

  factory PackageId.fromJson(Map<String, dynamic> json) => PackageId(
    id: List<int>.from(json["id"].map((x) => x)),
    total: List<String>.from(json["total"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": List<dynamic>.from(id!.map((x) => x)),
    "total": List<dynamic>.from(total!.map((x) => x)),
  };
}

// To parse this JSON data, do
//
//     final deletePackageModal = deletePackageModalFromJson(jsonString);

import 'dart:convert';

class DeletePackageModal {
  DeletePackageModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.loadAmount,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? loadAmount;
  String? errors;

  factory DeletePackageModal.fromRawJson(String str) =>
      DeletePackageModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeletePackageModal.fromJson(Map<String, dynamic> json) =>
      DeletePackageModal(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        response: List<Response>.from(
            json["Response"].map((x) => Response.fromJson(x))),
        loadAmount: json["loadAmount"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Response": List<dynamic>.from(response!.map((x) => x.toJson())),
        "loadAmount": loadAmount,
        "errors": errors,
      };
}

class Response {
  Response({
    this.bookingId,
    this.total,
    this.packageIds,
  });

  String? bookingId;
  String? total;
  List<PackageId>? packageIds;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        bookingId: json["BookingId"],
        total: json["total"],
        packageIds: List<PackageId>.from(
            json["packageIds"].map((x) => PackageId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "BookingId": bookingId,
        "total": total,
        "packageIds": List<dynamic>.from(packageIds!.map((x) => x.toJson())),
      };
}

class PackageId {
  PackageId({
    this.id,
    this.total,
  });

  List<int>? id;
  List<String>? total;

  factory PackageId.fromRawJson(String str) =>
      PackageId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageId.fromJson(Map<String, dynamic> json) => PackageId(
        id: List<int>.from(json["id"].map((x) => x)),
        total: List<String>.from(json["total"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": List<dynamic>.from(id!.map((x) => x)),
        "total": List<dynamic>.from(total!.map((x) => x)),
      };
}

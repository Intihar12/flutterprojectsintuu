// To parse this JSON data, do
//
//     final applyCouponModel = applyCouponModelFromJson(jsonString);

import 'dart:convert';

ApplyCouponModel applyCouponModelFromJson(String str) => ApplyCouponModel.fromJson(json.decode(str));

String applyCouponModelToJson(ApplyCouponModel data) => json.encode(data.toJson());

class ApplyCouponModel {
  ApplyCouponModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ? responseMessage;
  List<Response> ? response;
  String ? errors;

  factory ApplyCouponModel.fromJson(Map<String, dynamic> json) => ApplyCouponModel(
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
    this.couponId,
    this.total,
    this.discount,
  });

  int ? couponId;
  String ? total;
  String ? discount;
  String ? loadUnloadAmount;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    couponId: json["CouponId"],
    total: json["total"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "CouponId": couponId,
    "total": total,
    "discount": discount,
  };
}

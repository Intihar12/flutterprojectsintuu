// To parse this JSON data, do
//
//     final orderTrackingModel = orderTrackingModelFromJson(jsonString);

import 'dart:convert';

class OrderTrackingModel {
  OrderTrackingModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.data,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  Data? data;
  String? errors;

  factory OrderTrackingModel.fromRawJson(String str) =>
      OrderTrackingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderTrackingModel.fromJson(Map<String, dynamic> json) =>
      OrderTrackingModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        response: List<Response>.from(
            json["Response"].map((x) => Response.fromJson(x))),
        data: Data.fromJson(json["data"]),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Response": List<dynamic>.from(response!.map((x) => x.toJson())),
        "data": data!.toJson(),
        "errors": errors,
      };
}

class Data {
  Data({
    this.orderId,
    this.receiverName,
    this.driverName,
    this.driverDvToken,
    this.driverPhoneNum,
  });

  String? orderId;
  String? receiverName;
  String? driverName;
  String? driverDvToken;
  String? driverPhoneNum;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["orderId"],
        receiverName: json["receiverName"],
        driverName: json["driverName"],
        driverDvToken: json["driverDVToken"],
        driverPhoneNum: json["driverPhoneNum"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "receiverName": receiverName,
        "driverName": driverName,
        "driverDVToken": driverDvToken,
        "driverPhoneNum": driverPhoneNum,
      };
}

class Response {
  Response({
    this.id,
    this.status,
    this.time,
  });

  String? id;
  String? status;
  String? time;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        status: json["status"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "time": time,
      };
}

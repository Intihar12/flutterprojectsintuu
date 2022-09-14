// To parse this JSON data, do
//
//     final driverDetailsModal = driverDetailsModalFromJson(jsonString);

import 'dart:convert';

class DriverDetailsModal {
  DriverDetailsModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  String? errors;

  factory DriverDetailsModal.fromRawJson(String str) =>
      DriverDetailsModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverDetailsModal.fromJson(Map<String, dynamic> json) =>
      DriverDetailsModal(
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
    this.id,
    this.driverName,
    this.driverPhoneNum,
    this.carNum,
    this.carName,
    this.driverImage,
    this.deviceToken,
    this.estDeliveryTime,
    this.bookingStatusId,
    this.bookingStatus,
  });

  String? id;
  String? driverName;
  String? driverPhoneNum;
  String? carNum;
  String? carName;
  String? driverImage;
  String? deviceToken;
  String? estDeliveryTime;
  String? bookingStatusId;
  String? bookingStatus;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        driverName: json["driverName"],
        driverPhoneNum: json["driverPhoneNum"],
        carNum: json["carNum"],
        carName: json["carName"],
        driverImage: json["driverImage"],
        deviceToken: json["deviceToken"],
        estDeliveryTime: json["estDeliveryTime"],
        bookingStatusId: json["bookingStatusId"],
        bookingStatus: json["bookingStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driverName": driverName,
        "driverPhoneNum": driverPhoneNum,
        "carNum": carNum,
        "carName": carName,
        "driverImage": driverImage,
        "deviceToken": deviceToken,
        "estDeliveryTime": estDeliveryTime,
        "bookingStatusId": bookingStatusId,
        "bookingStatus": bookingStatus,
      };
}

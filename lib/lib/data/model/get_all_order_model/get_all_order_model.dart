// To parse this JSON data, do
//
//     final getAllOrderModel = getAllOrderModelFromJson(jsonString);

import 'dart:convert';

GetAllOrderModel getAllOrderModelFromJson(String str) => GetAllOrderModel.fromJson(json.decode(str));

String getAllOrderModelToJson(GetAllOrderModel data) => json.encode(data.toJson());

class GetAllOrderModel {
  GetAllOrderModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ?  responseMessage;
  List<Response> ?  response;
  String  ? errors;

  factory GetAllOrderModel.fromJson(Map<String, dynamic> json) => GetAllOrderModel(
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
    this.orderNumber,
    this.orderDate,
    this.pickupAddress,
    this.pickupBuiliding,
    this.pickupCity,
    this.pickupState,
    this.pickupZip,
    this.dropoffAddress,
    this.dropoffBuiliding,
    this.dropoffCity,
    this.dropoffState,
    this.dropoffZip,
    this.amount,
  });

  int ?  orderNumber;
  String ?  orderDate;
  String ?  pickupAddress;
  String ?  pickupBuiliding;
  String ?  pickupCity;
  String  ? pickupState;
  String ?  pickupZip;
  String ?  dropoffAddress;
  String ?  dropoffBuiliding;
  String ?  dropoffCity;
  String ?  dropoffState;
  String ?  dropoffZip;
  String ?  amount;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    orderNumber: json["orderNumber"],
    orderDate: json["orderDate"],
    pickupAddress: json["pickupAddress"],
    pickupBuiliding: json["pickupBuiliding"],
    pickupCity: json["pickupCity"],
    pickupState: json["pickupState"],
    pickupZip: json["pickupZip"],
    dropoffAddress: json["dropoffAddress"],
    dropoffBuiliding: json["dropoffBuiliding"],
    dropoffCity: json["dropoffCity"],
    dropoffState: json["dropoffState"],
    dropoffZip: json["dropoffZip"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
    "orderDate": orderDate,
    "pickupAddress": pickupAddress,
    "pickupBuiliding": pickupBuiliding,
    "pickupCity": pickupCity,
    "pickupState": pickupState,
    "pickupZip": pickupZip,
    "dropoffAddress": dropoffAddress,
    "dropoffBuiliding": dropoffBuiliding,
    "dropoffCity": dropoffCity,
    "dropoffState": dropoffState,
    "dropoffZip": dropoffZip,
    "amount": amount,
  };
}

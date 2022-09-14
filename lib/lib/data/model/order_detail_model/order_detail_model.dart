// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ?  responseMessage;
  Response  ? response;
  String ?  errors;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
    responseCode: json["ResponseCode"],
    responseMessage: json["ResponseMessage"],
    response: Response.fromJson(json["Response"]),
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "ResponseMessage": responseMessage,
    "Response": response!.toJson(),
    "errors": errors,
  };
}

class Response {
  Response({
    this.senderName,
    this.senderPhoneNum,
    this.recieverName,
    this.recieverPhoneNum,
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
    this.pickupLat,
    this.pickupLng,
    this.deliveryLat,
    this.deliveryLng,
    this.note,
    this.pickupTime,
    this.amount,
    this.bookingStatusId,
    this.bookingStatus,
    this.distance,
    this.estEarning,
    this.driverName,
    this.driverImage,
    this.couponValue,
    this.loadUnloadStaus,
    this.totalWeight,
    this.baseRate,
    this.basePrice,
    this.rating,
    this.packages,
  });

  String ?  senderName;
  String ?  senderPhoneNum;
  String ?  recieverName;
  String ?  recieverPhoneNum;
  String ?  pickupAddress;
  String ?  pickupBuiliding;
  String ?  pickupCity;
  String ?  pickupState;
  String  ? pickupZip;
  String  ? dropoffAddress;
  String  ? dropoffBuiliding;
  String  ? dropoffCity;
  String  ? dropoffState;
  String  ? dropoffZip;
  String  ? pickupLat;
  String  ? pickupLng;
  String  ? deliveryLat;
  String  ? deliveryLng;
  String ?  note;
  String ?  pickupTime;
  String ?  amount;
  String ?  bookingStatusId;
  String ?  bookingStatus;
  String ?  distance;
  String ?  estEarning;
  String ?  driverName;
  String ?  driverImage;
  String ?  couponValue;
  String ?  loadUnloadStaus;
  String ?  totalWeight;
  String ?  baseRate;
  String ?  basePrice;
  bool ?  rating;
  List<Package> ?  packages;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    senderName: json["senderName"],
    senderPhoneNum: json["senderPhoneNum"],
    recieverName: json["recieverName"],
    recieverPhoneNum: json["recieverPhoneNum"],
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
    pickupLat: json["pickupLat"],
    pickupLng: json["pickupLng"],
    deliveryLat: json["deliveryLat"],
    deliveryLng: json["deliveryLng"],
    note: json["note"],
    pickupTime: json["pickupTime"],
    amount: json["amount"],
    bookingStatusId: json["bookingStatusId"],
    bookingStatus: json["bookingStatus"],
    distance: json["distance"],
    estEarning: json["estEarning"],
    driverName: json["driverName"],
    driverImage: json["driverImage"],
    couponValue: json["couponValue"],
    loadUnloadStaus: json["load_unloadStaus"],
    totalWeight: json["totalWeight"],
    baseRate: json["baseRate"],
    basePrice: json["basePrice"],
    rating: json["rating"],
    packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "senderName": senderName,
    "senderPhoneNum": senderPhoneNum,
    "recieverName": recieverName,
    "recieverPhoneNum": recieverPhoneNum,
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
    "pickupLat": pickupLat,
    "pickupLng": pickupLng,
    "deliveryLat": deliveryLat,
    "deliveryLng": deliveryLng,
    "note": note,
    "pickupTime": pickupTime,
    "amount": amount,
    "bookingStatusId": bookingStatusId,
    "bookingStatus": bookingStatus,
    "distance": distance,
    "estEarning": estEarning,
    "driverName": driverName,
    "driverImage": driverImage,
    "couponValue": couponValue,
    "load_unloadStaus": loadUnloadStaus,
    "totalWeight": totalWeight,
    "baseRate": baseRate,
    "basePrice": basePrice,
    "rating": rating,
    "packages": List<dynamic>.from(packages!.map((x) => x.toJson())),
  };
}

class Package {
  Package({
    this.dimensions,
    this.unit,
    this.weight,
    this.worth,
    this.category,
    this.total,
    this.insurance,
  });

  String ?  dimensions;
  String ?  unit;
  String ?  weight;
  String ?  worth;
  String ?  category;
  String  ? total;
  String  ? insurance;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    dimensions: json["dimensions"],
    unit: json["unit"],
    weight: json["weight"],
    worth: json["worth"],
    category: json["category"],
    total: json["total"],
    insurance: json["insurance"],
  );

  Map<String, dynamic> toJson() => {
    "dimensions": dimensions,
    "unit": unit,
    "weight": weight,
    "worth": worth,
    "category": category,
    "total": total,
    "insurance": insurance,
  };
}

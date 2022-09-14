// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ?  responseMessage;
  List<Response>  ? response;
  String  ? errors;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
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
    this.name,
    this.displayText,
    this.displayImage,
    this.email,
    this.contact,
    this.activeBookings,
  });

  String ?  name;
  String ?  displayText;
  List<String> ?  displayImage;
  String  ? email;
  String  ? contact;
  List<ActiveBooking> ?  activeBookings;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    name: json["name"],
    displayText: json["displayText"],
    displayImage: List<String>.from(json["displayImage"].map((x) => x)),
    email: json["email"],
    contact: json["contact"],
    activeBookings: List<ActiveBooking>.from(json["activeBookings"].map((x) => ActiveBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "displayText": displayText,
    "displayImage": List<dynamic>.from(displayImage!.map((x) => x)),
    "email": email,
    "contact": contact,
    "activeBookings": List<dynamic>.from(activeBookings!.map((x) => x.toJson())),
  };
}

class ActiveBooking {
  ActiveBooking({
    this.orderNum,
    this.senderName,
    this.senderPhoneNum,
    this.recieverName,
    this.recieverPhoneNum,
    this.pickupAddress,
    this.dropoffAddress,
    this.note,
    this.pickupTime,
    this.amount,
    this.bookingStatusId,
    this.bookingStatus,
    this.securityKey,
    this.packages,
  });

  String  ? orderNum;
  String  ? senderName;
  String  ? senderPhoneNum;
  String  ? recieverName;
  String  ? recieverPhoneNum;
  String  ? pickupAddress;
  String  ? dropoffAddress;
  String  ? note;
  String  ? pickupTime;
  String  ? amount;
  int  ? bookingStatusId;
  String  ? bookingStatus;
  String  ? securityKey;
  List<Package>  ? packages;

  factory ActiveBooking.fromJson(Map<String, dynamic> json) => ActiveBooking(
    orderNum: json["orderNum"],
    senderName: json["senderName"],
    senderPhoneNum: json["senderPhoneNum"],
    recieverName: json["recieverName"],
    recieverPhoneNum: json["recieverPhoneNum"],
    pickupAddress: json["pickupAddress"],
    dropoffAddress: json["dropoffAddress"],
    note: json["note"],
    pickupTime: json["pickupTime"],
    amount: json["amount"],
    bookingStatusId: json["BookingStatusId"],
    bookingStatus: json["bookingStatus"],
    securityKey: json["securityKey"],
    packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderNum": orderNum,
    "senderName": senderName,
    "senderPhoneNum": senderPhoneNum,
    "recieverName": recieverName,
    "recieverPhoneNum": recieverPhoneNum,
    "pickupAddress": pickupAddress,
    "dropoffAddress": dropoffAddress,
    "note": note,
    "pickupTime": pickupTime,
    "amount": amount,
    "BookingStatusId": bookingStatusId,
    "bookingStatus": bookingStatus,
    "securityKey": securityKey,
    "packages": List<dynamic>.from(packages!.map((x) => x.toJson())),
  };
}

class Package {
  Package({
    this.dimensions,
    this.weight,
    this.worth,
    this.category,
  });

  String ?  dimensions;
  String ?  weight;
  String ?  worth;
  String ?  category;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    dimensions: json["dimensions"],
    weight: json["weight"],
    worth: json["worth"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "dimensions": dimensions,
    "weight": weight,
    "worth": worth,
    "category": category,
  };
}

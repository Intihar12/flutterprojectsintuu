// To parse this JSON data, do
//
//     final getAddressModal = getAddressModalFromJson(jsonString);

import 'dart:convert';

GetAddressModal getAddressModalFromJson(String str) => GetAddressModal.fromJson(json.decode(str));

String getAddressModalToJson(GetAddressModal data) => json.encode(data.toJson());

class GetAddressModal {
  GetAddressModal({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ?  responseMessage;
  List<Response> ?  response;
  String ?  errors;

  factory GetAddressModal.fromJson(Map<String, dynamic> json) => GetAddressModal(
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
    this.id,
    this.title,
    this.building,
    this.aptNum,
    this.city,
    this.state,
    this.zip,
    this.phoneNum,
    this.status,
    this.lng,
    this.lat,
    this.exactAddress,

    this.userId,
  });

  int ?  id;
  String  ? title;
  String ?  building;
  String ?  aptNum;
  String  ? city;
  String  ? state;
  String ?  zip;
  String ?  phoneNum;
  bool ?  status;
  double ?  lng;
  double ?  lat;
  String ?  exactAddress;
  int ?  userId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    title: json["title"],
    building: json["building"],
    aptNum: json["aptNum"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    phoneNum: json["phoneNum"],
    status: json["status"],
    lng: json["lng"].toDouble(),
    lat: json["lat"].toDouble(),
    exactAddress: json["exactAddress"],
    userId: json["UserId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "building": building,
    "aptNum": aptNum,
    "city": city,
    "state": state,
    "zip": zip,
    "phoneNum": phoneNum,
    "status": status,
    "lng": lng,
    "lat": lat,
    "exactAddress": exactAddress,
    "UserId": userId,
  };
}

// To parse this JSON data, do
//
//     final addPackMapModel = addPackMapModelFromJson(jsonString);

import 'dart:convert';

AddPackMapModel addPackMapModelFromJson(String str) => AddPackMapModel.fromJson(json.decode(str));

String addPackMapModelToJson(AddPackMapModel data) => json.encode(data.toJson());

class AddPackMapModel {
  AddPackMapModel({
    this.package,
    this.rName,
    this.rEmail,
    this.rAlPhoneNum,
    this.pickupDate,
    this.note,
    this.userId,
    this.vehiclesTypeId,
    this.loadUnload,
    this.pickupId,
    this.deliveryId,
  });

  List<Package> ? package;
  String ? rName;
  String ? rEmail;
  String ? rAlPhoneNum;
  String ? pickupDate;
  String ? note;
  String ? userId;
  String ? vehiclesTypeId;
  bool ? loadUnload;
  String ? pickupId;
  String ? deliveryId;

  factory AddPackMapModel.fromJson(Map<String, dynamic> json) => AddPackMapModel(
    package: List<Package>.from(json["package"].map((x) => Package.fromJson(x))),
    rName: json["rName"],
    rEmail: json["rEmail"],
    rAlPhoneNum: json["rAlPhoneNum"],
    pickupDate: json["pickupDate"],
    note: json["note"],
    userId: json["UserId"],
    vehiclesTypeId: json["VehiclesTypeId"],
    loadUnload: json["load_unload"],
    pickupId: json["pickupId"],
    deliveryId: json["deliveryId"],
  );

  Map<String, dynamic> toJson() => {
    "package": List<dynamic>.from(package!.map((x) => x.toJson())),
    "rName": rName,
    "rEmail": rEmail,
    "rAlPhoneNum": rAlPhoneNum,
    "pickupDate": pickupDate,
    "note": note,
    "UserId": userId,
    "VehiclesTypeId": vehiclesTypeId,
    "load_unload": loadUnload,
    "pickupId": pickupId,
    "deliveryId": deliveryId,
  };
}

class Package {
  Package({
    this.categoryId,
    this.categoryName,
    this.weight,
    this.height,
    this.length,
    this.width,
    this.estWorth,
    this.insurance,
    this.unit,
  });

  String ? categoryId;
  String ? categoryName;
  String ? weight;
  String ? height;
  String ? length;
  String ? width;
  String ? estWorth;
  bool ? insurance;
  String ? unit;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    categoryId: json["CategoryId"],
    categoryName: json["categoryName"],
    weight: json["weight"],
    height: json["height"],
    length: json["length"],
    width: json["width"],
    estWorth: json["estWorth"],
    insurance: json["insurance"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "CategoryId": categoryId,
    "categoryName": categoryName,
    "weight": weight,
    "height": height,
    "length": length,
    "width": width,
    "estWorth": estWorth,
    "insurance": insurance,
    "unit": unit,
  };
}

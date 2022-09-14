//
// import 'dart:async';
// import 'dart:core';
// import 'package:geocoding/geocoding.dart';
//
//
// class  GeoCodingServices{
//
//   late String  addressValue;
//
//   Future<String>  latLngToAddress(double lat ,double lng) async {
//
//
//     List<Placemark> newPlace = await placemarkFromCoordinates(lat,lng);
//
//     Placemark placeMark = newPlace[0];
//     String? name = placeMark.name;
//     String? subLocality = placeMark.subLocality;
//     String? locality = placeMark.locality;
//     String? administrativeArea = placeMark.administrativeArea;
//     String? postalCode = placeMark.postalCode;
//     String? country = placeMark.country;
//     String address_api_modals = "$name, $subLocality, $locality, $administrativeArea,\n $country";
//     addressValue=address_api_modals;
//     // setState(() {
//     //   caddress = address_api_modals; // update _address
//     // });
//     // print(addressValue);
//     return addressValue;
//   }
//
// }

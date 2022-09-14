import 'package:antrakuserinc/data/model/address_api_modals/delete_address.dart';
import 'package:antrakuserinc/data/model/address_api_modals/get_address.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/constants.dart';
import '../model/address_api_modals/add_address.dart';

class AddressProvider extends GetConnect {
  /// add address api
  Future<AddAddressModal> addAddressApi({
    required String title,
    required String building,
    required String aptNum,
    required String state,
    required String city,
    required String zip,
    required String phone,
    required String phoneCode,
    required String user_id,
    required String lat,
    required String lng,
    required String address,
  }) async {
    AddAddressModal? model;
    httpClient.timeout = Duration(seconds: 100);
    try {
      var response = await post("${Constants.baseUrl}address/add", {
        "title": title,
        "aptNum": aptNum,
        "city": city,
        "state": state,
        "zip": zip,
        "phoneNum": phone,
        "countryCode": phoneCode,
        "lng": lng,
        "lat": lat,
        "UserId": user_id,
        "building": building,
        "exactAddress": address,
      }, headers: {
        'Accept': 'application/json',
        // 'accessToken': '${GetStorage().read("bearer_token")}',
      }).whenComplete(() => Get.back());
      if (response.statusCode == 200) {
        model = AddAddressModal.fromJson(response.body);
        if (model.responseCode == "1") {
          return model;
        } else {
          throw Exception(model.errors);
        }
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(model!.errors);
    }
  }

  ///get address api
  Future<GetAddressModal> getAddressApi() async {
    GetAddressModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response =
        await get("${Constants.baseUrl}address/getbyuserid", headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = GetAddressModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        throw Exception(model.errors);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  ///delete address
  Future<DeleteAddressModal> deleteAddressApi({
    required int ID,
  }) async {
    DeleteAddressModal? model;
    httpClient.timeout = Duration(seconds: 100);
    try {
      var response = await post("${Constants.baseUrl}address/delete", {
        "addressId": ID,
      }, headers: {
        'Accept': 'application/json',
        'accessToken': '${GetStorage().read("bearer_token")}',
      }).whenComplete(() => Get.back());
      if (response.statusCode == 200) {
        model = DeleteAddressModal.fromJson(response.body);
        if (model.responseCode == "1") {
          return model;
        } else {
          throw Exception(model.errors);
        }
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(model!.errors);
    }
  }
}

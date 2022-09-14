import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/data/model/RestricktedItemModel/RestrictedItemModel.dart';
import 'package:antrakuserinc/data/model/add_booking_model/add_booking_model.dart';
import 'package:antrakuserinc/data/model/add_rating_modal/add_rating_modal.dart';
import 'package:antrakuserinc/data/model/apply_coupon_model/apply_coupon_model.dart';
import 'package:antrakuserinc/data/model/cancel_booking_model/cancel_booking_model.dart';
import 'package:antrakuserinc/data/model/cancel_reasons_model/cancel_reasons_model.dart';
import 'package:antrakuserinc/data/model/category_model/category_model.dart';
import 'package:antrakuserinc/data/model/get_vehicle_model/get_vehicle_model.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/delete_pkg_model/delete_pkg_model.dart';

class AddPackageProvider extends GetConnect {
  ///category api
  Future<CategoryModel> categoryApi() async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await get("${Constants.baseUrl}category/getall", headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      CategoryModel categoryModel = CategoryModel.fromJson(response.body);
      print("value $categoryModel");
      return categoryModel;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// add booking
  Future<AddBookingModel> addBookingApi({
    required List<Map<String, dynamic>> package,
    required String rName,
    required String rEmail,
    required String rAlPhoneNum,
    required String pickupDate,
    required String note,
    required String UserId,
    required String VehiclesTypeId,
    required bool load_unload,
    required String pickupId,
    required String deliveryId,
  }) async {
    AddBookingModel? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}booking/add", {
      "package": package,
      "rName": rName,
      "rEmail": rEmail,
      "rAlPhoneNum": rAlPhoneNum,
      "pickupDate": pickupDate,
      "note": note,
      "UserId": UserId,
      "VehiclesTypeId": VehiclesTypeId,
      "load_unload": load_unload,
      "pickupId": pickupId,
      "deliveryId": deliveryId
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = AddBookingModel.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// update booking
  Future<AddBookingModel> updateBookingApi({
    required List<Map<String, dynamic>> package,
    required String rName,
    required String rEmail,
    required String rAlPhoneNum,
    required String pickupDate,
    required String note,
    required String UserId,
    required String VehiclesTypeId,
    required bool load_unload,
    required String pickupId,
    required String deliveryId,
    required String bookId,
  }) async {
    AddBookingModel? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await put("${Constants.baseUrl}booking/update", {
      "package": package,
      "rName": rName,
      "rEmail": rEmail,
      "rAlPhoneNum": rAlPhoneNum,
      "pickupDate": pickupDate,
      "note": note,
      "UserId": UserId,
      "VehiclesTypeId": VehiclesTypeId,
      "load_unload": load_unload,
      "pickupId": pickupId,
      "deliveryId": deliveryId,
      "bookId": bookId
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = AddBookingModel.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// delete pkg
  Future<DeletePackageModal> deletePkgApi({
    required String bookingId,
    required String packageId,
    required String loadAmount,
  }) async {
    DeletePackageModal? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}package/delete", {
      "bookingId": bookingId,
      "packageId": packageId,
      "loadAmount": loadAmount,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = DeletePackageModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  // /// get vehicle api
  // Future <GetVehicleModel> getVehicleApi() async{
  //   httpClient.timeout = Duration(seconds: 100);
  //   final response = await get("${Constants.baseUrl}vehicle/getall",
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${GetStorage().read("bearer_token")}',
  //       }
  //   );
  //   if(response.statusCode==200){
  //     GetVehicleModel getVehicleModel= GetVehicleModel.fromJson(response.body);
  //     print("value $getVehicleModel");
  //     return getVehicleModel;
  //   }
  //   else{
  //     return Future.error(response.statusText!);
  //   }
  // }

  /// get vehicle according to volume api
  Future<GetVehicleModel> getVehicleApi({
    required List<Map<String, dynamic>> package,
  }) async {
    GetVehicleModel? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}vehicle/getall/filtered", {
      "packages": package,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = GetVehicleModel.fromJson(response.body);
      return model;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// apply coupon api
  Future<ApplyCouponModel> applyCouponAPi({
    required String name,
    required String BookingId,
  }) async {
    ApplyCouponModel? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}coupons/apply", {
      "name": name,
      "BookingId": BookingId
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = ApplyCouponModel.fromJson(response.body);
      return model;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// cancel booking api
  Future<CancelBookingModel> cancelBookingApi({
    required String bookingId,
    required String UserId,
    required String note,
    required String reason,
  }) async {
    CancelBookingModel? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}users/booking/cancel", {
      "bookingId": bookingId,
      "UserId": UserId,
      "note": note,
      "reason": reason,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = CancelBookingModel.fromJson(response.body);
      return model;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// get cancel reasons
  Future<CancelReasonsModel> getReasonApi() async {
    httpClient.timeout = Duration(seconds: 100);
    final response =
        await get("${Constants.baseUrl}users/cancelreasons", headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      CancelReasonsModel model = CancelReasonsModel.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// get Restricted Items
  Future<RestricktedItemModel> getRestrictedApi() async {
    httpClient.timeout = Duration(seconds: 100);
    final response =
        await get("${Constants.baseUrl}restricted/getall", headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      RestricktedItemModel model = RestricktedItemModel.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  ///add rating
  Future<AddRatingModal> addRatingApi({
    required String rating,
    required String tip,
    required String bookingId,
  }) async {
    AddRatingModal? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}ratingtips/add", {
      "rate": rating,
      "amount": tip,
      "bookingId": bookingId
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = AddRatingModal.fromJson(response.body);

      return model;
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future sendMessage(
      {required String message,
      required String name,
      required String receiverToken,
      required String orderID,
      required String myName,
      required String myDvToken,
      required String myID}) async {
    Dio dio = Dio();

    var resp = dio.post("https://fcm.googleapis.com/fcm/send",
        data: {
          "notification": {"body": message, "title": 'chat messages'},
          "priority": 'high',
          "data": {
            "click_action": 'FLUTTER_NOTIFICATION_CLICK',
            "order_id": orderID,
            "my_name": myName,
            "my_dvToken": myDvToken,
            "myId": myID,
            'id': '1',
            'message': 'Chat Messages',
          },
          'to': receiverToken,
        },
        options: Options(headers: {
          "content-type": 'application/json',
          "Authorization": 'key=${Constants.FirbaseServerKey}',
        }));
    print("resp " + resp.toString());
  }

  onApiError(String errors) {
    Get.snackbar(
      "Error",
      errors,
      backgroundColor: MyColors.red500,
      colorText: MyColors.white,
    );
  }
}

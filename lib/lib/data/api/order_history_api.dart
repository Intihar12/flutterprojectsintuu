import 'package:antrakuserinc/data/model/get_all_order_model/get_all_order_model.dart';
import 'package:antrakuserinc/data/model/get_user_model/get_user_modal.dart';
import 'package:antrakuserinc/data/model/order_detail_model/order_detail_model.dart';
import 'package:antrakuserinc/data/model/track_order_model/track_order_model.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

class OrderHistoryProvider extends GetConnect {
  /// order History
  Future<GetAllOrderModel> orderHistoryApi({
    required String from,
    required String to,
  }) async {
    GetAllOrderModel? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post(
        "${Constants.baseUrl}booking/getfiltered/${GetStorage().read("user_id")}",
        {
          "from": from,
          "to": to,
        },
        headers: {
          'Accept': 'application/json',
          'accessToken': '${GetStorage().read("bearer_token")}',
        }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = GetAllOrderModel.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// order detail api
  Future<OrderDetailModel> orderDetailApi({
    required String bookId,
  }) async {
    OrderDetailModel? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}booking/getby", {
      "bookId": bookId,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = OrderDetailModel.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// order tracking api
  Future<dynamic> orderTrackingApi({required String bookingId}) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await post("${Constants.baseUrl}booking/history", {
      "bookingId": bookingId
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")} ',
    });
    if (response.statusCode == 200) {
      OrderTrackingModel model = OrderTrackingModel.fromJson(response.body);
      print("value $model");
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// order pdf


  onApiError(String errors) {
    Get.snackbar("Error", errors,
      backgroundColor: MyColors.red500,
      colorText: MyColors.white,
    );
  }
}

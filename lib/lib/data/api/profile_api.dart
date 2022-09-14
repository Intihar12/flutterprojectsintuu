import 'package:antrakuserinc/data/model/driver_details_modal/driver_details_modal.dart';
import 'package:antrakuserinc/data/model/get_user_model/get_user_modal.dart';
import 'package:antrakuserinc/data/model/homepage_model/homepage_model.dart';
import 'package:antrakuserinc/data/model/update_user_modal/update_user_modal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

class ProfileProvider extends GetConnect {
  Future<GetUserModal> getUserApi() async {
    GetUserModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response = await get("${Constants.baseUrl}users/getuser", headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = GetUserModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  ///update user api
  Future<UpdateUserModal> updateUserApi({
    required String fName,
    required String lName,
    required String cCode,
    required String phone,
  }) async {
    UpdateUserModal? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await put("${Constants.baseUrl}users/updateuser", {
      "firstName": fName,
      "lastName": lName,
      "countryCode": cCode,
      "phoneNum": phone,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = UpdateUserModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  onApiError(String errors) {
    Get.snackbar("Error", errors);
  }

  /// home page api
  Future<HomePageModel> getHomeApi() async {
    HomePageModel? model;
    httpClient.timeout = Duration(seconds: 100);

    var response = await get("${Constants.baseUrl}users/homepage",
        headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = HomePageModel.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  ///driver details api
  Future<DriverDetailsModal> driverDetailsApi({
    required String bID,
  }) async {
    DriverDetailsModal? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}booking/driverdetails", {
      "bookingId": bID,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = DriverDetailsModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }
}

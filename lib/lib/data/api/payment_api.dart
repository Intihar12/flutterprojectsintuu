import 'package:antrakuserinc/data/model/add_card_for_payment_modal/add_card_for_payment_modal.dart';
import 'package:antrakuserinc/data/model/add_user_card_modal/add_user_card_modal.dart';
import 'package:antrakuserinc/data/model/get_user_cards/get_user_card_modal.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

class PaymentProvider extends GetConnect {
  Future<GetUserCardsModal> getUserCardsApi() async {
    GetUserCardsModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response = await get("${Constants.baseUrl}users/getallcards", headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = GetUserCardsModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<AddUserCardsModal> addCardApi({
    required String cardNum,
    required String month,
    required String year,
    required String cvv,
  }) async {
    AddUserCardsModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response = await post("${Constants.baseUrl}users/addcard", {
      "cardNum": cardNum,
      "exp_month": month,
      "exp_year": year,
      "cvc": cvv,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = AddUserCardsModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<AddCardForPaymentModal> addCardForPaymentApi({
    required String cardNum,
    required String month,
    required String year,
    required String cvv,
    required String bID,
    required String cID,
    required bool status,
  }) async {
    AddCardForPaymentModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response =
        await post("${Constants.baseUrl}users/makepaymentbynewcard", {
      "cardNum": cardNum,
      "exp_month": month,
      "exp_year": year,
      "cvc": cvv,
      "bookingId": bID,
      "CouponId": cID,
      "saveStatus": status,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = AddCardForPaymentModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<AddCardForPaymentModal> paymentBySavedCardApi({
    required String bID,
    required String pmID,
    required String cID,
  }) async {
    AddCardForPaymentModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response =
        await post("${Constants.baseUrl}users/makepaymentbysavedcard", {
      "bookingId": bID,
      "pmId": pmID,
      "CouponId": cID,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = AddCardForPaymentModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<AddCardForPaymentModal> deleteCardApi({
    required String pmID,
  }) async {
    AddCardForPaymentModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response = await post("${Constants.baseUrl}users/deletecard", {
      "pmkey": pmID,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = AddCardForPaymentModal.fromJson(response.body);
      print(response);
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
    Get.snackbar("Error", errors,
      backgroundColor: MyColors.red500,
      colorText: MyColors.white,
    );
  }
}

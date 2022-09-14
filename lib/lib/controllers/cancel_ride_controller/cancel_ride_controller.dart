import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/model/cancel_reasons_model/cancel_reasons_model.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import '../../ui/home/home_page.dart';
import '../../ui/values/my_colors.dart';
import '../../ui/widgets/progress_bar.dart';
import '../home_controller/home_controller.dart';

class CancelRideController extends GetxController
    with StateMixin<CancelReasonsModel> {
  int current = 0;
  var groupvalue = 0.obs;
  var _repository = Repository();
  HomeController homeController = Get.put(HomeController());

  TextEditingController noteController = TextEditingController();

  Future<CancelReasonsModel> getReasonData() async {
    CancelReasonsModel cancelReasonsModel =
        await _repository.getCancelReasons();
    change(cancelReasonsModel, status: RxStatus.success());
    return cancelReasonsModel;
  }

  /// cancel booking
  cancelBooking({
    required String bookingId,
    required String UserId,
    required String note,
    required String reason,
  }) async {
    await _repository
        .cancelBookingApi(
            bookingId: bookingId, UserId: UserId, note: note, reason: reason)
        .then((value) {
      if (value.responseCode == '1') {
        Fluttertoast.showToast(
          msg: value.responseMessage.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
          backgroundColor: MyColors.green600,
          textColor: MyColors.white,
          // location// duration
        );

        homeController.getHomeData();
        noteController.clear();
        Get.offAll(HomePage());
        noteController.clear();
        update();
      } else {
        Fluttertoast.showToast(
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          msg: value.responseMessage.toString(), // message
          gravity: ToastGravity.CENTER, // length
        );
      }
    });
  }

  /// delete pkg button
  cancelBtn(orderId) async {
    try {
      final result =
          await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.dialog(ProgressBar(), barrierDismissible: false);
        cancelBooking(
            bookingId: orderId,
            UserId: GetStorage().read('user_id'),
            note: noteController.text,
            reason: SingleToneValue.instance.cancelReason);
      } else {
        //when no internet
        Fluttertoast.showToast(
          msg: "Please check your internet connection!", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          // location// duration
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Please check your internet connection!", // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.CENTER,
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        // location// duration
      );
    }
  }

  onPopScope() {
    Get.offAll(HomePage());
  }

  @override
  void onInit() {
    getReasonData();
    // TODO: implement onInit
    super.onInit();
  }
}

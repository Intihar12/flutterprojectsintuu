import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../data/model/useragreementModal/useragreement_modal.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import '../../ui/values/my_colors.dart';

class UserAgreementController extends GetxController
    with StateMixin<UserAgreementModal> {
  final scrollController = ScrollController();
  final _repository = Repository();
  var showButton = false.obs;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  getAgreement() {
    _repository.userAgreementRepo().then((value) {
      if (value.responseCode == "1") {
        change(value, status: RxStatus.success());
      } else {
        change(value, status: RxStatus.error());
        Fluttertoast.showToast(
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          msg: value.responseMessage.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM, // location// duration
        );
      }
    }, onError: (errors) {
      if (errors.toString().contains("SocketException")) {
        Fluttertoast.showToast(
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          msg: "Please check your internet!", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM, // location// duration
        );
        Timer(Duration(seconds: 5), getAgreement());
      } else {
        change(value, status: RxStatus.error());
        Fluttertoast.showToast(
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          msg: "Something Went Wrong", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM, // location// duration
        );
      }
    });
  }

  @override
  void onInit() {
    getAgreement();
    scrollController.addListener(() {
      if (scrollController.offset >= 350) {
        showButton.value = true;
        update(); // show the back-to-top button
      } else {
        showButton.value = false;
        update(); // hide the back-to-top button
      }
      update();
    });
    // TODO: implement onInit
    super.onInit();
  }
}

import 'dart:io';

import 'package:antrakuserinc/ui/auth/email_verification.dart';
import 'package:antrakuserinc/ui/auth/login/login.dart';
import 'package:antrakuserinc/ui/auth/signup/signup.dart';
import 'package:antrakuserinc/ui/auth/walkthrough.dart';
import 'package:antrakuserinc/ui/auth/welcome.dart';
import 'package:antrakuserinc/ui/home/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repository.dart';
import '../../ui/values/my_colors.dart';

class SplashController extends GetxController {
  final _repository = Repository();
  checkInternet() async {
    var flagConnected = false;
    final result = await InternetAddress.lookup('google.com').timeout(Duration(
      seconds: 5,
    ));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // when connected
      flagConnected = true;

      if (flagConnected) {
        _checkSessionAndProceed();
      }
    } else {
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  void _checkSessionAndProceed() async {
    if (GetStorage().read("user_id") == null) {
      Get.offAll(() => WalkThroughScreen());
    }if (GetStorage().read("bearer_token") == null) {
      Get.offAll(() => WalkThroughScreen());
    }  else {
      _repository.sessionCheck(id: GetStorage().read("user_id")).then((value) {

        if (value.sessionKey == '0') {
          Get.offAll(() => WelcomeScreen());
        }
        if (value.sessionKey == '1') {
          Get.offAll(() => EmailVerification());
        }
        if (value.sessionKey == '2') {
          Get.offAll(() => HomePage());
        }
      });
    }
  }

  @override
  void onInit() {
    //  checkInternet();
    // TODO: implement onInit
    super.onInit();
  }
}

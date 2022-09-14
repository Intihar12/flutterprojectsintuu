import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../ui/auth/login/login.dart';
import '../../ui/password_screens/change_forgot_password.dart';
import '../../ui/values/my_colors.dart';

import '../../data/repository.dart';
import '../../ui/widgets/progress_bar.dart';

class PasswordController extends GetxController {
  final _repository = Repository();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> resetFormkey = GlobalKey<FormState>();

  /// forgot password
  forgotPassword({
    required String email,
  }) async {
    await _repository.forgotPassword(email).then((value) {
      if (value.responseCode == '1') {
        Get.snackbar(
          "Message",
          value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
          duration: Duration(seconds: 5),
          colorText: MyColors.white,
        );
        emailController.clear();
        Get.offAll(() => ChangeForgotPassword(
              uId: "${value.response![0].userId}",
              rId: "${value.response![0].forgetRequestId}",
            ));
      } else {
        Get.snackbar(
          value.errors.toString(),
          value.responseMessage.toString(),
          backgroundColor: MyColors.red500,
          duration: Duration(seconds: 5),
          colorText: MyColors.white,
        );
      }
    }, onError: (error) {
      Get.snackbar("Forgot Password", error.toString(),
          backgroundColor: MyColors.red500,
          duration: Duration(seconds: 5),
          colorText: MyColors.white);
    });
  }

  /// reset password
  resetPassword(String uId, String rId, String password, String otp) async {
    await _repository
        .resetApiCall(uId: uId, requestId: rId, password: password, otp: otp)
        .then((value) {
      if (value.responseCode == '1') {
        Get.snackbar(
          "Reset Password",
          value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
          duration: Duration(seconds: 5),
          colorText: MyColors.white,
        );
        Get.off(() => Login());
      } else {
        Get.snackbar(
          value.errors.toString(),
          value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
          duration: Duration(seconds: 5),
          colorText: MyColors.white,
        );
      }
    }, onError: (error) {
      Get.snackbar("Reset Password", error.toString(),
          backgroundColor: MyColors.red500,
          duration: Duration(seconds: 5),
          colorText: MyColors.white);
    });
  }

  /// reset password button
  onResetBtn(String uId, String rId) async {
    if (resetFormkey.currentState!.validate()) {
      if (newPassController.text == confirmPassController.text) {
        try {
          final result =
              await InternetAddress.lookup('google.com').timeout(Duration(
            seconds: 5,
          ));
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            // when connected
            Get.dialog(ProgressBar(), barrierDismissible: false);
            resetPassword(uId, rId, newPassController.text, otpController.text);
          } else {
            //when no internet
            Get.snackbar("Error", "Please check your internet connection!",
                backgroundColor: MyColors.red500, colorText: MyColors.white);
          }
        } catch (e) {
          Get.snackbar("Error", "Please check your internet connection!",
              backgroundColor: MyColors.red500, colorText: MyColors.white);
        }
      } else {
        Get.snackbar("Password",
            "Your new password and confirm password doesn't match. Please correct it.",
            backgroundColor: MyColors.red500,
            duration: Duration(seconds: 5),
            colorText: MyColors.white);
      }
    }
  }

  ///forgot password button
  onForgotBtn() async {
    if (emailFormKey.currentState!.validate()) {
      try {
        final result =
            await InternetAddress.lookup('google.com').timeout(Duration(
          seconds: 5,
        ));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // when connected
          Get.dialog(ProgressBar(), barrierDismissible: false);
          forgotPassword(email: emailController.text);
        } else {
          //when no internet
          Get.snackbar("Error", "Please check your internet connection!",
              backgroundColor: MyColors.red500, colorText: MyColors.white);
        }
      } catch (e) {
        Get.snackbar("Error", "Please check your internet connection!",
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    }
  }

  /// pop scope
  onResetPopScope() {
    clearData();
    Get.offAll(Login());
  }

  onPopScope(){
    Get.offAll(Login());
  }

  /// pop scope
  onVerifyPopScope(){
    clearData();
    Get.offAll(Login());
  }

  /// clear data
  clearData() {
    emailController.clear();
    otpController.clear();
    confirmPassController.clear();
    newPassController.clear();
  }
}

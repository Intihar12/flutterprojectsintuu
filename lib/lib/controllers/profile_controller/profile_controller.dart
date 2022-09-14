import 'dart:io';

import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/profile/edit_profile.dart';
import 'package:antrakuserinc/data/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../ui/values/my_colors.dart';
import '../../ui/widgets/progress_bar.dart';

class ProfileController extends GetxController with StateMixin {
  var isEdit = true.obs;
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var f1 = new FocusNode().obs;
  final _repo = Repository();

  getUser() async {
    await _repo.getUserRepo().then((value) {
      if (value.responseCode == "1") {
        fnameController.text = value.response![0].firstName!;
        lnameController.text = value.response![0].lastName!;
        phoneController.text = value.response![0].phoneNum!;
        emailController.text = value.response![0].email!;
        SingleToneValue.instance.cCode = value.response![0].countryCode!;

        change(value, status: RxStatus.success());
      } else {
        change(value, status: RxStatus.error());
      }
    });
  }

  /// update user

  updateUser({
    required String fName,
    required String lName,
    required String cCode,
    required String phone,
  }) {
    _repo
        .updateUserRepo(fName: fName, lName: lName, cCode: cCode, phone: phone)
        .then((value) {
      if (value.responseCode == "1") {
        GetStorage().write("name", value.response![0].firstName!);
        GetStorage().write("last_name", value.response![0].lastName!);
        isEdit.value = true;
        Get.snackbar("Message", value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
          colorText: MyColors.white,
        );
        Get.offAll(() => EditProfile());
      } else {
        Get.snackbar(value.errors.toString(), value.responseMessage.toString());
      }
    }, onError: (e) {
      Fluttertoast.showToast(
        msg: "Something Went Wrong!", // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.CENTER,
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        // location// duration
      );
    });
  }

  ///update user button
  updateButton() async {
    var flagConnected = false;
    final result = await InternetAddress.lookup('google.com').timeout(Duration(
      seconds: 5,
    ));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // when connected
      flagConnected = true;
      if(formKey.currentState!.validate()){
        if(phoneController.text.length>=10){
          if (flagConnected) {
            Get.dialog(ProgressBar(), barrierDismissible: false);

            updateUser(
                fName: fnameController.text,
                lName: lnameController.text,
                cCode: SingleToneValue.instance.cCode! + "-",
                phone: phoneController.text);
          }
        }else{
          Fluttertoast.showToast(
            msg: "Please enter valid phone number", // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.red500,
            textColor: MyColors.white,
            // location// duration
          );
        }

      }

    } else {
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  @override
  void onInit() {
    getUser();

    // TODO: implement onInit
    super.onInit();
  }
}

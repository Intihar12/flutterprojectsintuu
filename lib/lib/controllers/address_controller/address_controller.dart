import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import '../../ui/saved_address/save_address_profile.dart';
import '../../ui/values/my_colors.dart';
import '../../ui/widgets/progress_bar.dart';

class AddressController extends GetxController with StateMixin {
  final _repo = Repository();

  final GlobalKey<FormState> addAddressFormKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController street =
      TextEditingController(text: SingleToneValue.instance.customLocation);
  TextEditingController aptNum = TextEditingController();
  TextEditingController stateName =
      TextEditingController(text: SingleToneValue.instance.state.value);
  TextEditingController city =
      TextEditingController(text: SingleToneValue.instance.city.value);
  TextEditingController zip =
      TextEditingController(text: SingleToneValue.instance.postalCode.value);
  TextEditingController phone = TextEditingController();
  var code = '+92';

  ///add address function
  AddAddress({
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
  }) {
    try {
      _repo
          .addAddressRepo(
        title: title,
        aptNum: aptNum,
        building: building,
        state: state,
        city: city,
        zip: zip,
        phone: phone,
        user_id: user_id,
        lat: lat,
        phoneCode: phoneCode,
        lng: lng,
        address: address,
      )
          .then((value) {
        if (value.responseCode == "1") {
          // Get.snackbar("Message", value.responseMessage.toString());
          Fluttertoast.showToast(
            msg: value.responseMessage.toString(), // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.green600,
            textColor: MyColors.white,
            // location// duration
          );
          getAddress();
          clearData();
          Get.off(() => SavedAddressProfile());
        }
      }).whenComplete(() => getAddress());
    } catch (e) {
      Get.snackbar("Exception", e.toString().replaceAll('Exception:', ''));
    }
  }

  /// add address profile button
  onAddressProfileButton() async {
    try {
      var flagConnected = false;
      final result =
          await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // when connected
        flagConnected = true;
        if (flagConnected) {
          final isValid = addAddressFormKey.currentState!.validate();
          if (!isValid) {
            return;
          } else {
            Get.dialog(ProgressBar(), barrierDismissible: false);
            AddAddress(
              title: title.text,
              aptNum: "N/A",
              building: building.text,
              state: stateName.text,
              city: city.text,
              zip: zip.text,
              phoneCode: SingleToneValue.instance.code!,
              phone: phone.text,
              user_id: GetStorage().read("user_id"),
              lat: SingleToneValue.instance.latc.toString(),
              lng: SingleToneValue.instance.lngc.toString(),
              address: street.text,
            );
          }
        }
      } else {
        //when no internet
        Get.snackbar("Error", "Please check your internet connection!",
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString().replaceAll('Exception:', ''));
    }
  }

  ///get address

  getAddress() async {
    await _repo.getAddressRepo().then((value) {
      if (value.responseCode == "1") {
        change(value, status: RxStatus.success());
      } else {
        change(value, status: RxStatus.empty());
      }
    });
  }

  ///delete address
  deleteAddress({required int ID}) async {
    try {
      await _repo.deleteAddressRepo(ID: ID).then((value) {
        if (value.responseCode == "1") {
          Fluttertoast.showToast(
            msg: "Address Deleted", // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.green600,
            textColor: MyColors.white,
            // location// duration
          );
          getAddress();
        } else {
          Fluttertoast.showToast(
            msg: "Error", // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.red500,
            textColor: MyColors.white,
            // location// duration
          );
        }
      }).whenComplete(() => getAddress());
    } catch (e) {
      Get.snackbar("Exception", e.toString().replaceAll('Exception:', ''));
    }
  }

  /// delete address button
  deleteAddressButton({required int ID}) async {
    try {
      var flagConnected = false;
      final result =
          await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // when connected
        flagConnected = true;
        if (flagConnected) {
          Get.dialog(ProgressBar(), barrierDismissible: false);
          deleteAddress(ID: ID);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  clearData() {
    title.clear();
    building.clear();
    stateName.clear();
    city.clear();
    zip.clear();
    phone.clear();
    SingleToneValue.instance.city.value = "";
    SingleToneValue.instance.state.value = "";
    SingleToneValue.instance.postalCode.value = "";
    SingleToneValue.instance.code = "+1";
  }

  @override
  void onInit() {
    getAddress();
    // TODO: implement onInit
    super.onInit();
  }
}

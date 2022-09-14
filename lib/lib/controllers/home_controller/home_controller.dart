import 'dart:io';

import 'package:antrakuserinc/GetServices/CheckConnectionService.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/model/homepage_model/homepage_model.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import '../../ui/home/home_page.dart';
import '../../ui/values/my_colors.dart';

class HomeController extends GetxController with StateMixin<HomePageModel> {
  int current=0;
  var groupvalue = 0.obs;
  var _repository=Repository();
  var date='';
  var time24=''.obs;
  var time12=''.obs;
  var date_controller = DatePickerController();
  var selectedTime =  TimeOfDay.now();
  var selectedDate = DateTime.now();
  TextEditingController noteController= TextEditingController();
  CheckConnectionService connectionService = CheckConnectionService();
 // String displayTex= 'Get your parcel delivered in time it takes for drive there';

  // Future<HomePageModel>  getHomeData() async{
  //   HomePageModel homePageModel= await _repository.getHomeSpi();
  //  // displayTex=homePageModel.response![0].displayText.toString();
  //   SingleToneValue.instance.contactEmail=homePageModel.response![0].email.toString();
  //   SingleToneValue.instance.contactPhone=homePageModel.response![0].contact.toString();
  //   change(homePageModel, status: RxStatus.loading());
  //   change(null, status: RxStatus.error("Please try again later"));
  //   change(homePageModel, status: RxStatus.success());
  //   return homePageModel;
  // }
  getHomeData() async {
      try {
        await _repository.getHomeSpi().then((homePageModel) {
          change(homePageModel, status: RxStatus.success());
          SingleToneValue.instance.contactEmail=homePageModel.response![0].email.toString();
          SingleToneValue.instance.contactPhone=homePageModel.response![0].contact.toString();
        }, onError: (err) {
          change(
            null,
            status: RxStatus.error(err.toString()),
          );
        });
      } catch (e) {
        Get.snackbar(
            "Error", e.toString().replaceAll('Error:', "Something Went Wrong"));
      }
    }
checkInternet(){
  connectionService.checkConnection().then((value) {
    if(!value){
      Get.snackbar("Antrak", "No Internet");

    }else{
      getHomeData();
    }
    });
}

clearData(){
  SingleToneValue.instance.addressIDs.clear();
  SingleToneValue.instance.packageIds.clear();
  SingleToneValue.instance.addPackage.clear();
  SingleToneValue.instance.sId = 0;
  SingleToneValue.instance.vehicleState = -1;
  SingleToneValue.instance.pAddressSate = -2;
  SingleToneValue.instance.dAddressState = -1;
  SingleToneValue.instance.pickupAddressId = '-1';
  SingleToneValue.instance.dropAddressId = '-1';
  SingleToneValue.instance.updateApiId = 0;
  SingleToneValue.instance.packageIds.clear();
  SingleToneValue.instance.coupon = '';
  SingleToneValue.instance.rEmail = null;
  SingleToneValue.instance.rName = null;
  SingleToneValue.instance.loadUnload = false;
  print("access token: ${GetStorage().read("bearer_token")}");
  print("user id: ${GetStorage().read("user_id")}");
  print("dv Token : ${SingleToneValue.instance.dvToken}");

}

onPopScope(){
    Get.offAll(HomePage());
}
  @override
  void onInit() {
    checkInternet();
    // TODO: implement onInit
    super.onInit();
  }

}

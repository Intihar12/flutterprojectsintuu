import 'package:antrakuserinc/controllers/parcel_controller/parcel_controller.dart';
import 'package:antrakuserinc/data/model/address_model/address_model.dart';
import 'package:antrakuserinc/data/model/get_vehicle_model/get_vehicle_model.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/other_details/other_details.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/pickup/pickup_details.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/receiver_details/receiver_details.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../GetServices/CheckConnectionService.dart';
import '../../data/repository.dart';

class SelectVehicleController extends GetxController with StateMixin<GetVehicleModel> {
  var selected_index = 0.obs;
  var loadOffload = SingleToneValue.instance.loadUnload.obs;
  final _repository = Repository();
  CheckConnectionService connectionService = CheckConnectionService();
  TextEditingController noteController = TextEditingController();
  ParcelController parcelController =Get.put(ParcelController());




  Future<GetVehicleModel>  getVehicle() async{
    GetVehicleModel getVehicleModel= await _repository.getVehicle(SingleToneValue.instance.addPackage);
    change(getVehicleModel, status: RxStatus.success());
    return getVehicleModel;
  }


  /// on button
  onButton(){
    if (SingleToneValue.instance.updateApiId == 0 ) {
      if(SingleToneValue.instance.vehicleState==-1){
        showError();
      }
      else{
        parcelController.addBookinBtn(noteController.text);
      }

    } else {
      parcelController
          .upDateBookinBtn(noteController.text);
    }
  }

  /// show msg
  showError(){
    Fluttertoast.showToast(
      msg: "Please Select a vehicle", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.CENTER,
      backgroundColor: MyColors.red500,
      textColor: MyColors.white,
      // location// duration
    );
  }


  onPopScope(){
    Get.back();
  }

  @override
  void onInit() {
    connectionService.checkConnection().then((value) {
      if(!value){
        Get.snackbar("Antrak", "No Internet",
        colorText: MyColors.white,
          backgroundColor: MyColors.red500
        );

      }else{
    getVehicle();
      }});
    // TODO: implement onInit
    super.onInit();
  }

}

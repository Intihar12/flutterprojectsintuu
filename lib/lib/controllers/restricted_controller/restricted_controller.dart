



import 'package:antrakuserinc/data/model/RestricktedItemModel/RestrictedItemModel.dart';
import 'package:antrakuserinc/data/repository.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestrictedController extends GetxController with StateMixin<RestricktedItemModel>{

var _repository = Repository() ;

  @override
  void onInit() {
    getRItems();
    super.onInit();
  }

  Future<RestricktedItemModel> getRItems() async {
    RestricktedItemModel model = await _repository.getRestricted();
    SingleToneValue.instance.rItems.clear();
    for(int i =0; i<model.response![0].titles!.length; i++){
      SingleToneValue.instance.rItems.add(model.response![0].titles![i]);
     // print("ppppppppp ${SingleToneValue.instance.rItems}");
    }
    change(model, status: RxStatus.success());
    return model;
  }


}
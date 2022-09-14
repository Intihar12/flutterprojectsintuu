import 'dart:io';
import 'dart:isolate';
import 'dart:ui';


import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../GetServices/CheckConnectionService.dart';
import '../../data/model/order_detail_model/order_detail_model.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';

class OrderDetailController extends GetxController with StateMixin<OrderDetailModel> {

  final _repository = Repository();
  var totalAmount=''.obs;
  var discount='0'.obs;
  var orderStatus=''.obs;
  double baseWeight=20;
  double amount=3;
  double inputWeight=3;
  String loadUnloadStatus='false';
  double loadUnloadPrice=0;
  double extraLoad=0;
  double extraUnit=0;
  CheckConnectionService connectionService = CheckConnectionService();


  getOrderDetail(String bookId ) async {
    try {
      await _repository.orderDetailRepo(bookId: bookId).then((getAllOrderModel) {
        discount.value=getAllOrderModel.response!.couponValue! ;
        totalAmount.value=getAllOrderModel.response!.amount! ;
        orderStatus.value=getAllOrderModel.response!.bookingStatus!;
        loadUnloadStatus=getAllOrderModel.response!.loadUnloadStaus!;
        if(double.parse(getAllOrderModel.response!.totalWeight!)<double.parse(getAllOrderModel.response!.baseRate!)){
          loadUnloadPrice=double.parse(getAllOrderModel.response!.basePrice!);
        }
        else{
          extraLoad=double.parse(getAllOrderModel.response!.totalWeight!)-double.parse(getAllOrderModel.response!.baseRate!);
          extraUnit=extraLoad/double.parse(getAllOrderModel.response!.baseRate!);
          loadUnloadPrice=double.parse(getAllOrderModel.response!.basePrice!)+(extraUnit*double.parse(getAllOrderModel.response!.basePrice!));
        }
        update();
        change(getAllOrderModel, status: RxStatus.success());
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

  // Future<OrderDetailModel>  getOrderDetail(String bookId ) async{
  //   OrderDetailModel model= await _repository.orderDetailRepo(bookId: bookId);
  //   discount.value=model.response!.couponValue! ;
  //   totalAmount.value=model.response!.amount! ;
  //   orderStatus.value=model.response!.bookingStatus!;
  //   loadUnloadStatus=model.response!.loadUnloadStaus!;
  //   if(double.parse(model.response!.totalWeight!)<double.parse(model.response!.baseRate!)){
  //     loadUnloadPrice=double.parse(model.response!.basePrice!);
  //   }
  //   else{
  //     extraLoad=double.parse(model.response!.totalWeight!)-double.parse(model.response!.baseRate!);
  //     extraUnit=extraLoad/double.parse(model.response!.baseRate!);
  //     loadUnloadPrice=double.parse(model.response!.basePrice!)+(extraUnit*double.parse(model.response!.basePrice!));
  //   }
  //   update();
  //   change(model, status: RxStatus.success());
  //   return model;
  // }



  void requestDownload(String id) async {
    Directory? directory = await getApplicationDocumentsDirectory();
    print("Directory: ${directory.path}");
    final taskId = await FlutterDownloader.enqueue(
      url: '${Constants.baseUrl}users/orderDetails/pdf/$id',

      savedDir: directory.path,
      saveInPublicStorage: true,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }

  int progress = 0;


  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }




  @override
  void onInit() {
    getOrderDetail(SingleToneValue.instance.orderId.toString());
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");
    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
        progress = message[2];
   update();
      print(progress);
    });
    FlutterDownloader.registerCallback(downloadingCallback);
   // FlutterDownloader.registerCallback((id, status, progress) { });
    // TODO: implement onInit
    super.onInit();
  }
}

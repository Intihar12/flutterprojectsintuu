import 'package:antrakuserinc/data/repository.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/home/home_page.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../data/model/track_order_model/track_order_model.dart';

class TrackOrderController extends GetxController
    with StateMixin<OrderTrackingModel> {
  var _repository = Repository();

  trackOrder(bookingId) async {
    await _repository.orderTrackingRepo(bookingId: bookingId).then((value) {
      if (value.responseCode == "1") {
        SingleToneValue.instance.orderId = value.data!.orderId;
        SingleToneValue.instance.driverName = value.data!.driverName;
        SingleToneValue.instance.driverDv = value.data!.driverDvToken;
        SingleToneValue.instance.driverPhone = value.data!.driverPhoneNum;
        change(value, status: RxStatus.success());
      } else {
        change(value, status: RxStatus.error());
      }
    }, onError: (error) {
      change(value, status: RxStatus.error());
    });

    //change(orderTrackingModel, status: RxStatus.error());
  }

  ///driver details

  onDriverDetails({
    required String bID,
  }) async {
    await _repository.driverDetailsRepo(bID: bID).then((value) {
      if (value.responseCode == "1") {
        if (value.response!.length > 0) {
          SingleToneValue.instance.driverID = value.response![0].id;
          SingleToneValue.instance.driverName = value.response![0].driverName;
          SingleToneValue.instance.driverPhone =
              value.response![0].driverPhoneNum;
          SingleToneValue.instance.carNum = value.response![0].carNum;
          SingleToneValue.instance.carName = value.response![0].carName;
          SingleToneValue.instance.driverImage = value.response![0].driverImage;
          SingleToneValue.instance.driverDv = value.response![0].deviceToken;
          SingleToneValue.instance.estTime = value.response![0].estDeliveryTime;
          SingleToneValue.instance.driverStatusID =
              int.parse(value.response![0].bookingStatusId!);
          SingleToneValue.instance.driverStatus =
              value.response![0].bookingStatus;
        }
      }
    }, onError: (e) {
      Fluttertoast.showToast(
        msg: 'Something Went Wrong', // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.CENTER,
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        // location// duration
      );
    });
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  onPopScope() {
    Get.offAll(HomePage());
  }

  @override
  void onInit() {
    trackOrder(SingleToneValue.instance.orderId);

    onDriverDetails(bID: SingleToneValue.instance.orderId.toString());
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

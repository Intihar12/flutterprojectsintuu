import 'package:antrakuserinc/controllers/Order_detail_controller/order_detail_controller.dart';
import 'package:antrakuserinc/controllers/address_controller/address_controller.dart';
import 'package:antrakuserinc/controllers/cancel_ride_controller/cancel_ride_controller.dart';
import 'package:antrakuserinc/controllers/driver_tracking_controller/driver_tracking_controller.dart';
import 'package:antrakuserinc/controllers/home_controller/home_controller.dart';
import 'package:antrakuserinc/controllers/parcel_controller/parcel_controller.dart';
import 'package:antrakuserinc/controllers/payment_controller/payment_controller.dart';
import 'package:antrakuserinc/controllers/pickup_controller/pickup_controller.dart';
import 'package:antrakuserinc/controllers/profile_controller/profile_controller.dart';
import 'package:antrakuserinc/controllers/receiver_controller/receiver_controller.dart';
import 'package:antrakuserinc/controllers/restricted_controller/restricted_controller.dart';
import 'package:antrakuserinc/controllers/select_vehicle_controller/select_vehicle_controller.dart';
import 'package:antrakuserinc/controllers/track_order_controller/track_order_controller.dart';

import 'package:get/get.dart';

import '../../controllers/map_controller/map_controller.dart';
import '../../controllers/order_history_controller/order_history_controller.dart';
import '../../controllers/useragrement/user_agreement.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController(), fenix: true);
    Get.lazyPut(() => AddressController(), fenix: true);
    Get.lazyPut(() => ParcelController(), fenix: true);
    Get.lazyPut(() => PickupController(), fenix: true);
    Get.lazyPut(() => ReceiverController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SelectVehicleController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => OrderHistoryController(), fenix: true);
    Get.lazyPut(() => OrderDetailController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => TrackOrderController(), fenix: true);
    Get.lazyPut(() => RestrictedController(), fenix: true);
    Get.lazyPut(() => CancelRideController(), fenix: true);
    Get.lazyPut(() => DriverTrackingController(), fenix: true);
    Get.lazyPut(() => UserAgreementController(), fenix: true);
    // TODO: implement dependencies
  }
}

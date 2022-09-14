import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SingleToneValue {
  var storage = GetStorage();

  String? status;
  String? dvToken;
  String? dvMsgRecToken;

  String? code = "+1";
  String? cCode = "+1";
  String? number;
  String? userId;

  double? currentLat;

  String? customLocation;

  double? currentLng;

  double latc = 32.7767;
  double pickLat = 32.7767;
  double dropLat = 32.7767;

  double lngc = 96.7970;
  double pickLng = 96.7970;
  double dropLng = 96.7970;

  String currentAddress = "";
  String pickAddress = "";
  String receiverAddress = "";

  var postalCode = Strings.zip.obs;

  var exactAddress = Strings.address.obs;
  var exactAddressRec = Strings.address.obs;
  var state = Strings.state.obs;
  var city = Strings.city.obs;

  int? sId = 0;

  Function()? font;
  String socialEmail = '';
  String? socialName;
  String? socialPhone;

  bool? emailReadonly = false;
  String? contactEmail;
  String? contactPhone;

  /// use for add parcel

  String? date;
  String? time;
  List<Map<String, dynamic>> addPackage = [];
  String pickupAddressId = '-1';
  String note = 'N/A';
  String? sName;
  String? sPhone;
  String? sAddress;
  String dropAddressId = '-1';
  String? rName;
  String? rAddress;
  String? rEmail;
  String? rPhone;
  String? rPhone1;
  String? vehicleId;
  String? orderId;
  String? securityNo;
  bool loadUnload = false;

  String? driverID;
  String? driverName;
  String? driverPhone;
  String? carNum;
  String? carName;
  String? driverImage;
  String? driverDv;
  String? estTime;
  String? driverStatus;
  int? driverStatusID;

  List<dynamic> packageIds = [];
  List<dynamic> packagePrice = [];
  List<dynamic> rItems = [];
  List<dynamic> addressIDs = [];

  int vehicleState = -1;
  int pAddressSate = -2;
  int dAddressState = -1;

  int updateApiId = 0;

  String? amount;
  String coupon = '';
  String rating = '1';

  String? tip;
  String cancelReason = '';

  String? insuranceText;
  String? loadText;
  String? insuranceFee;
  String? resendEmail;

  int length = -1;
  int newLength = -1;

  ///end
  int? driverId;
  bool isPlaying = false;
  String? distance;
  String discount = "0";
  String loadUnloadAmount = "0";

  String rideCompleted = "false";

  SingleToneValue._privateConstructor();

  static SingleToneValue get instance => _instance;

  static final SingleToneValue _instance =
      SingleToneValue._privateConstructor();

  factory SingleToneValue() {
    return _instance;
  }
}

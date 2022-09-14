import 'dart:async';
import 'dart:io';

import 'package:antrakuserinc/data/model/address_model/address_model.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/other_details/other_details.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/pickup/pickup_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import '../../data/model/map_search_models/id_to_latlng/id_to_latlng.dart';
import '../../data/model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import '../../data/repository.dart';
import '../../ui/send_parcel_and_payment/receiver_details/receiver_details.dart';
import '../../ui/values/dimens.dart';
import '../../ui/values/my_colors.dart';
import '../../ui/widgets/progress_bar.dart';

class ReceiverController extends GetxController with StateMixin {
  var selected_index = 0.obs;

  var phoneController = new TextEditingController();
  var code = '+1';
  final _repository = Repository();
  // final GlobalKey<FormState> addAddressKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController aptNum = TextEditingController();
  Rx<TextEditingController> exactAddress = TextEditingController(text: SingleToneValue.instance.exactAddressRec.value).obs;
  Rx<TextEditingController> stateName = TextEditingController(text: SingleToneValue.instance.state.value).obs;
  Rx<TextEditingController> city =
      TextEditingController(text: SingleToneValue.instance.city.value).obs;
  Rx<TextEditingController> zip =
      TextEditingController(text: SingleToneValue.instance.postalCode.value)
          .obs;
  TextEditingController phone = TextEditingController();
  TextEditingController rName = TextEditingController();
  TextEditingController rEmail = TextEditingController();
  TextEditingController rPhone = TextEditingController();

  AutoComplete? _getAutoComplete;
  AutoComplete? searchPlaces;
  IdtoLatLong? _getPlaceLatLong;
  var lat = 32.7767.obs;
  var lng = 96.7970.obs;
  GoogleMapController? mapController;
  String _mainText = ' ';
  String _secondaryText = ' ';
  double? _lat;
  double? _long;
  String _currentSearch = ' ';
  Completer<GoogleMapController> controller = Completer();
  final locationTextController = TextEditingController();
  var address = 'Getting Address..'.obs;
  var customAddress = 'Getting Address..'.obs;
  var street = 'Getting street..'.obs;
  var postCode = 'Getting postCode..'.obs;
  var cityName = 'Getting city..'.obs;
  var name = 'Getting name..'.obs;
  var customLocation = 'Getting Location..'.obs;
  var customLocationDisplay = 'Getting Location..'.obs;
  late String addressOff;
  var mapVisible = true.obs;
  @override
  onInit() async {
    if (SingleToneValue.instance.rName != null) {
      rName.text = SingleToneValue.instance.rName.toString();
      rEmail.text = SingleToneValue.instance.rEmail.toString();
    }
    SingleToneValue.instance.receiverAddress = "";
    getAddress();
    await getCurrentLocation();

    // print('barrer Token :${userModel.token}');

    super.onInit();
  }

  onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // SingleToneValue.instance.pickLat = lat.value;
    // SingleToneValue.instance.pickLng = lng.value;
    //await getDriverInitialLocation();
    if (lat.value == 32.7767) {
      await getCurrentLocation();
    }

    // await updateDriverLocation();
  }

  ///to get current location from icon

  Future<void> goToCurrentLocation() async {
    await locationPermissionUsed();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.151926040649414)));
    locationTextController.clear();
    update();
  }

  Future getCurrentLocation() async {
    await locationPermissionUsed();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lat.value = position.latitude;
    lng.value = position.longitude;
    SingleToneValue.instance.dropLat = lat.value;
    SingleToneValue.instance.dropLng = lng.value;
    print("current lat: ${lat.value}");
    print("current lng: ${lng.value}");
    getCustomLocation(
        SingleToneValue.instance.dropLat, SingleToneValue.instance.dropLng);
    getAddressFromLatLang(
        SingleToneValue.instance.dropLat, SingleToneValue.instance.dropLng);

    update();
    // return LatLng(lat.value, lng.value);
  }

  /// function of  convert into the latlng to the address
  Future<String> getAddressFromLatLang(double lat, double lng) async {
    await locationPermissionUsed();
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemark[0];
    name.value = place.name!;
    cityName.value = place.locality!;
    street.value = place.street!;
    postCode.value = place.postalCode!;
    address.value = '${place.name}, '
        '${place.locality}, '
        '${place.administrativeArea},'
        '${place.country},';
    addressOff = address.value;
    SingleToneValue.instance.receiverAddress = addressOff;
    print('stream Address${addressOff}');
    update();
    return addressOff;
  }

  /// location permission of the location
  Future<void> locationPermissionUsed() async {
    bool serviceEnabled;
    LocationPermission permission;
    final location = loc.Location();
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      location.requestService();
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    Geolocator.getServiceStatusStream().listen((event) async {
      print("Event:$event");
      if (event == ServiceStatus.enabled) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        }
        if (permission == LocationPermission.deniedForever) {
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }
      } else {
        location.requestService();
      }
    });
  }

  getCustomLocation(double lat, double lng) async {
    await locationPermissionUsed();
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    customLocation.value ="${placemarks[0].street}";
    customLocationDisplay.value ="${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
    SingleToneValue.instance.postalCode.value = placemarks[0].postalCode!;
    SingleToneValue.instance.state.value = placemarks[0].administrativeArea!;
    SingleToneValue.instance.city.value = placemarks[0].locality!;
    String codeTest = placemarks[0].postalCode!;
    String textState = placemarks[0].administrativeArea!;
    String citTest = placemarks[0].locality!;
    stateName.value = TextEditingController(text: textState);
    city.value = TextEditingController(text: citTest);
    zip.value = TextEditingController(text: codeTest);
    exactAddress.value = TextEditingController(text: customLocation.value);
    SingleToneValue.instance.receiverAddress = customLocation.value;
    SingleToneValue.instance.exactAddressRec.value = customLocation.value;
    update();
    // locationTextController.text = customLocation.value;
    print("Address: ${customLocation.value}");
    print("Address List: ${placemarks[0]}");
  }

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
      _repository
          .addAddressRepo(
        title: title,
        aptNum: aptNum,
        building: building,
        state: state,
        city: city,
        zip: zip,
        phone: phone,
        phoneCode: phoneCode,
        user_id: user_id,
        lat: lat,
        lng: lng,
        address: address,
      )
          .then((value) async {
        if (value.responseCode == "1") {
          Get.snackbar("Message", value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
            colorText: MyColors.white,
          );
          await getAddress().then((value) {
            clearData();
          });
        }
      }).whenComplete(() => getAddress());
    } catch (e) {
      Get.snackbar("Exception", e.toString().replaceAll('Exception:', ''));
    }
  }

  ///on add address button
  onReceiverAddAddress() async {
    var flagConnected = false;
    final result = await InternetAddress.lookup('google.com').timeout(Duration(
      seconds: 5,
    ));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // when connected
      flagConnected = true;

      if (flagConnected) {
        Get.dialog(ProgressBar(), barrierDismissible: false);
        AddAddress(
          title: title.text,
          building: building.text,
          aptNum: "N/A",
          state: stateName.value.text,
          city: city.value.text,
          zip: zip.value.text,
          phoneCode: SingleToneValue.instance.code!,
          phone: phone.text,
          user_id: GetStorage().read("user_id"),
          lat: SingleToneValue.instance.dropLat.toString(),
          lng: SingleToneValue.instance.dropLng.toString(),
          address: SingleToneValue.instance.receiverAddress,
        );
      }
    } else {
      //when no internet
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  ///get address

  Future<void> getAddress() async {
    await _repository.getAddressRepo().then((value) {
      if (value.responseCode == "1") {
        change(value, status: RxStatus.success());
      } else {
        change(value, status: RxStatus.empty());
      }
    });
  }

  /// enail validation
  emailVealidate(String value) {
    if (value.isEmpty) {
      return Fluttertoast.showToast(
        msg: 'Please Enter Email',
        // message
        toastLength: Toast.LENGTH_LONG,
        // length
        gravity: ToastGravity.CENTER,
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        // location// duration
      );
    }
    if (GetUtils.isEmail(value)) {
      return onButtonClick();
    }
    if (!GetUtils.isEmail(value)) {
      return Fluttertoast.showToast(
        msg: "Please enter valid email",
        // message
        toastLength: Toast.LENGTH_LONG,
        // length
        gravity: ToastGravity.CENTER,
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        // location// duration
      );
    }
  }

  ///on button click
  onButtonClick() {
    if (SingleToneValue.instance.dAddressState < 0) {
      return Fluttertoast.showToast(
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        msg: 'Please select receiver address first', // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.CENTER, // location
      );
    } else {
      SingleToneValue.instance.rName = rName.text;
      SingleToneValue.instance.rEmail = rEmail.text;
      SingleToneValue.instance.rPhone = code + phoneController.text;
      Get.to(OtherDetails());
    }
  }

  /// will pop scope pickup screen
  onPopScope() {
    Get.off(PickupDetails());
  }

  String prr = '   ';

  void callApi(String str) async {
    _currentSearch = str;
    if (_currentSearch != prr) {
      searchPlaces = await getPlaces(_currentSearch);
      update();
      prr = _currentSearch;
    }
  }

  String secnT({required StructuredFormatting data}) {
    if (data.secondarytext != null) {
      return data.secondarytext;
    }
    update();
    return ' ';
  }

  Widget _location(
      {required StructuredFormatting data, required BuildContext context}) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.pin_drop_outlined,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    data.maintext,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(
                secnT(data: data),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUpdatePlaces(BuildContext context, AutoComplete data) {
    return listview(context, data);
  }

  Widget listview(BuildContext context, AutoComplete data) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.predict.length,
        padding: const EdgeInsets.only(
          top: Dimens.size16,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: Dimens.size5),
            child: GestureDetector(
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                SingleToneValue.instance.customLocation =     data.predict[index].structuredformatting.secondarytext;
                _mainText = data.predict[index].structuredformatting.maintext;
                _secondaryText =
                    data.predict[index].structuredformatting.secondarytext;
                callApi(' ');
                locationTextController.text = _mainText;
                FocusScope.of(context).requestFocus(new FocusNode());
                await callApiLatLong(data.predict[index].placeid);
              },
              child: _location(
                  data: data.predict[index].structuredformatting,
                  context: context),
            ),
          );
        },
      ),
    );
  }

  Future callApiLatLong(String placeId) async {
    _getPlaceLatLong = await getPlacesLatLong(placeId);
    lat.value = _getPlaceLatLong!.result.geometry.locationData.lat;
    lng.value = _getPlaceLatLong!.result.geometry.locationData.lng;
    SingleToneValue.instance.dropLat =
        _getPlaceLatLong!.result.geometry.locationData.lat;
    SingleToneValue.instance.dropLng =
        _getPlaceLatLong!.result.geometry.locationData.lng;
    await getCustomLocation(_getPlaceLatLong!.result.geometry.locationData.lat,
        _getPlaceLatLong!.result.geometry.locationData.lng);
    await _goToTheLake();
  }

  Future<void> _goToTheLake() async {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat.value, lng.value), zoom: 16.151926040649414)));
  }

  void updateText(String str) {
    if (str.isEmpty) {
      callApi(' ');
    }
    callApi(str);
  }

  /// get places of the latlng
  Future<IdtoLatLong> getPlacesLatLong(String str) async {
    final response = await _repository.getPlacesLatLong(
      str,
    );
    return response;
  }

  /// map search through the places google places api
  Future<AutoComplete?> getPlaces(String str) async {
    _getAutoComplete = await _repository.getPlaces(
      str,
    );
    return _getAutoComplete;
  }

  clearData() {
    title.clear();
    building.clear();
    stateName.value.clear();
    city.value.clear();
    zip.value.clear();
    phone.clear();
    SingleToneValue.instance.city.value = "";
    SingleToneValue.instance.state.value = "";
    SingleToneValue.instance.postalCode.value = "";
    SingleToneValue.instance.code = "+1";
    Get.off(() => ReceiverDetails());
  }
}

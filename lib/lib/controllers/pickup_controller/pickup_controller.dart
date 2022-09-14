import 'dart:async';
import 'dart:io';
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
import '../../data/singleton/singleton.dart';
import '../../ui/send_parcel_and_payment/pickup/pickup_details.dart';
import '../../ui/send_parcel_and_payment/receiver_details/receiver_details.dart';
import '../../ui/send_parcel_and_payment/send_parcel/send_parcel.dart';
import '../../ui/values/dimens.dart';
import '../../ui/values/my_colors.dart';
import '../../ui/widgets/progress_bar.dart';

class PickupController extends GetxController with StateMixin {
  var stateValue = SingleToneValue.instance.obs;
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
  var isMapVisible = false.obs;
  var mapVisible = true.obs;

  late String addressOff;
  @override
  onInit() async {
    SingleToneValue.instance.pickAddress = "";
    getAddress();
    await getCurrentLocation();
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
    SingleToneValue.instance.pickLat = lat.value;
    SingleToneValue.instance.pickLng = lng.value;
    print("current lat: ${lat.value}");
    print("current lng: ${lng.value}");
    getCustomLocation(
        SingleToneValue.instance.pickLat, SingleToneValue.instance.pickLng);
    getAddressFromLatLang(
        SingleToneValue.instance.pickLat, SingleToneValue.instance.pickLng);

    update();
    // return LatLng(lat.value, lng.value);
  }

  ///get location

  getLocation(GoogleMapController controller) {
    mapController = controller;
    getAddressFromLatLang(
        SingleToneValue.instance.pickLat, SingleToneValue.instance.pickLng);
  }

  /// function of  convert into the latlng to the address
  Future<String> getAddressFromLatLang(double lat, double lng) async {
    await locationPermissionUsed();
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemark[0];
    name.value = place.name!;
    cityName.value = place.locality!;
    street.value = place.locality!;
    postCode.value = place.postalCode!;
    address.value = '${place.name}, '
        '${place.locality}, '
        '${place.administrativeArea},'
        '${place.country},';
    addressOff = address.value;
    SingleToneValue.instance.pickAddress = addressOff;
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
    customLocation.value = "${placemarks[0].street}";
    customLocationDisplay.value =
        "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
    SingleToneValue.instance.postalCode.value = placemarks[0].postalCode!;
    SingleToneValue.instance.state.value = placemarks[0].administrativeArea!;
    SingleToneValue.instance.city.value = placemarks[0].locality!;
    SingleToneValue.instance.exactAddress.value = customLocation.value;
    String codeTest = placemarks[0].postalCode!;
    String textState = placemarks[0].administrativeArea!;
    String citTest = placemarks[0].locality!;
    stateName.value = TextEditingController(text: textState);
    city.value = TextEditingController(text: citTest);
    zip.value = TextEditingController(text: codeTest);
    exactAddress.value = TextEditingController(text: customLocation.value);
    SingleToneValue.instance.pickAddress = customLocation.value;
    // locationTextController.text = customLocation.value;
    print("Address: ${customLocation.value}");
    print("Address List: ${placemarks[0]}");
  }

  var selected_index = 0.obs;

  var code = '+1';

  final _repository = Repository();
  // GlobalKey<FormState> addAddressKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController building = TextEditingController();

  TextEditingController aptNum = TextEditingController();
  Rx<TextEditingController> exactAddress =
      TextEditingController(text: SingleToneValue.instance.exactAddress.value)
          .obs;
  Rx<TextEditingController> stateName =
      TextEditingController(text: SingleToneValue.instance.state.value).obs;
  Rx<TextEditingController> city =
      TextEditingController(text: SingleToneValue.instance.city.value).obs;
  Rx<TextEditingController> zip =
      TextEditingController(text: SingleToneValue.instance.postalCode.value)
          .obs;
  TextEditingController phone = TextEditingController();

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
        aptNum: "N/A",
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
          .then((value) {
        if (value.responseCode == "1") {
          Get.snackbar(
            "Message",
            value.responseMessage.toString(),
            backgroundColor: MyColors.green600,
            colorText: MyColors.white,
          );
          getAddress();
          clearData();
          Get.offAll(() => PickupDetails());
        }
      }).whenComplete(() => getAddress());
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString().replaceAll('Exception:', ''),
        backgroundColor: MyColors.red500,
        colorText: MyColors.white,
      );
    }
  }

  ///get address

  getAddress() async {
    await _repository.getAddressRepo().then((value) {
      if (value.responseCode == "1") {
        change(value, status: RxStatus.success());

        //SingleToneValue.instance.pickupAddressId =   value.response![0].id.toString();
        // SingleToneValue.instance.sAddress = value.response![0].exactAddress;
        // SingleToneValue.instance.sPhone = value.response![0].phoneNum;
      } else {
        change(value, status: RxStatus.empty());
      }
    });
  }

  onPickUpaddAddress() async {
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
          lat: SingleToneValue.instance.pickLat.toString(),
          lng: SingleToneValue.instance.pickLng.toString(),
          address: SingleToneValue.instance.pickAddress,
        );
      }
    } else {
      //when no internet
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  /// will pop scope pickup screen
  onPopScope() {
    Get.defaultDialog(
        title: "Caution",
        middleText: "Your data will be cleared in case of you go back",
        titleStyle: Get.textTheme.subtitle2!
            .copyWith(color: MyColors.red500, fontWeight: FontWeight.w500),
        onCancel: () {},
        onConfirm: () {
          SingleToneValue.instance.addressIDs.clear();
          SingleToneValue.instance.addPackage.clear();
          SingleToneValue.instance.sId = 0;
          SingleToneValue.instance.vehicleState = -1;
          SingleToneValue.instance.pAddressSate = -1;
          SingleToneValue.instance.dAddressState = -1;
          SingleToneValue.instance.updateApiId = 0;
          SingleToneValue.instance.packageIds.clear();

          SingleToneValue.instance.coupon = '';
          SingleToneValue.instance.rEmail = null;
          SingleToneValue.instance.rName = null;
          SingleToneValue.instance.loadUnload = false;

          Get.offAll(SendParcel());
        });
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
                SingleToneValue.instance.customLocation =
                    data.predict[index].structuredformatting.secondarytext;
                _mainText = data.predict[index].structuredformatting.maintext;
                _secondaryText =
                    data.predict[index].structuredformatting.secondarytext;
                callApi(' ');

                locationTextController.text = _mainText;
                FocusScope.of(context).requestFocus(new FocusNode());
                update();
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
    SingleToneValue.instance.pickLat =
        _getPlaceLatLong!.result.geometry.locationData.lat;
    SingleToneValue.instance.pickLng =
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

  onButton() {
    if (SingleToneValue.instance.pAddressSate < 0) {
      Fluttertoast.showToast(
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        msg: 'Please select pickup address first', // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.BOTTOM, // location// duration
      );
    } else {
      Get.off(ReceiverDetails());
    }
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
  }
}

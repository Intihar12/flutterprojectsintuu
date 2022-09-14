import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart' as loc;

import '../../data/model/map_search_models/id_to_latlng/id_to_latlng.dart';
import '../../data/model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import '../../ui/values/dimens.dart';

class LocationController extends GetxController {
  AutoComplete? _getAutoComplete;
  final _repository = Repository();

  /// stream of position
  late StreamSubscription<Position> streamSubscription;
  IdtoLatLong? _getPlaceLatLong;
  var lat = 32.7767.obs;
  var lng = 96.7970.obs;
//  var streamLat=0.0.obs;
  //var streamLng=0.0.obs;
  AutoComplete? searchPlaces;
  Marker? driverMarker;
  String _currentSearch = ' ';
  //var databaseRef = FirebaseDatabase.instance.ref();
  Set<Marker> Markers = {};
//  LatLng currentLatLng= LatLng(0.0, 0.0);
  /// stream of position

  var address = 'Getting Address..'.obs;
  var customAddress = 'Getting Address..'.obs;
  var street = 'Getting street..'.obs;
  var postCode = 'Getting postCode..'.obs;
  var city = 'Getting city..'.obs;
  var name = 'Getting name..'.obs;
  var customLocation = 'Getting Location..'.obs;
  var customLocationTextField = 'Getting Location..'.obs;
  late String addressOff;
  GoogleMapController? mapController;
  String _mainText = ' ';
  String _secondaryText = ' ';
  double? _lat;
  double? _long;
  Completer<GoogleMapController> controller = Completer();
  final locationTextController = TextEditingController();

  @override
  onInit() async {
    SingleToneValue.instance.customLocation = "";
    await getCurrentLocation();

    // print('barrer Token :${userModel.token}');

    super.onInit();
  }

  onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    SingleToneValue.instance.currentLat = lat.value;
    SingleToneValue.instance.currentLng = lng.value;
    //await getDriverInitialLocation();
    await getCurrentLocation();

    // await updateDriverLocation();
  }

  Future getCurrentLocation() async {
    await locationPermissionUsed();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lat.value = position.latitude;
    lng.value = position.longitude;
    SingleToneValue.instance.latc = lat.value;
    SingleToneValue.instance.lngc = lng.value;
    print("current lat: ${lat.value}");
    print("current lng: ${lng.value}");
    getAddressFromLatLang(
        SingleToneValue.instance.latc, SingleToneValue.instance.lngc);

    update();
    // return LatLng(lat.value, lng.value);
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

  /// function of  convert into the latlng to the address
  Future<String> getAddressFromLatLang(double lat, double lng) async {
    await locationPermissionUsed();
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemark[0];
    name.value = place.name!;
    city.value = place.locality!;
    street.value = place.street!;
    postCode.value = place.postalCode!;
    // address.value = '${place.name}, '
    //     '${place.locality}, '
    //     '${place.administrativeArea},'
    //     '${place.country},';
    address.value = '${place.street}';
    addressOff = address.value;
    SingleToneValue.instance.currentAddress = addressOff;
    print('stream Address${addressOff}');
    update();
    return addressOff;
  }

  getCustomLocation(double lat, double lng) async {
    await locationPermissionUsed();
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    customLocationTextField.value = "${placemarks[0].street}";
    customLocation.value = " ${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
    SingleToneValue.instance.postalCode.value = placemarks[0].postalCode!;
    SingleToneValue.instance.state.value = placemarks[0].administrativeArea!;
    SingleToneValue.instance.city.value = placemarks[0].locality!;
    SingleToneValue.instance.customLocation = customLocationTextField.value;
    print("Address: ${customLocation.value}");
    print("Address List: ${placemarks[0]}");
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
            top: Dimens.size16, left: Dimens.size15, right: Dimens.size15),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: Dimens.size5),
            child: GestureDetector(
              onTap: () async {
                SingleToneValue.instance.customLocation =
                    data.predict[index].structuredformatting.secondarytext;
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
    await locationPermissionUsed();
    _getPlaceLatLong = await getPlacesLatLong(placeId);
    lat.value = _getPlaceLatLong!.result.geometry.locationData.lat;
    lng.value = _getPlaceLatLong!.result.geometry.locationData.lng;
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
}

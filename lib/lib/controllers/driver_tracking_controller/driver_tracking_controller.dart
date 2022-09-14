import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/model/latlng_modal/latlng_modal.dart';
import '../../data/singleton/singleton.dart';

class DriverTrackingController extends GetxController with StateMixin {
  var databaseRef = FirebaseDatabase.instance.ref();
  Set<Marker> Markers = {};
  GoogleMapController? mapController;
  var lat = 32.7767.obs;
  var lng = 96.7970.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    updateDriverLocation();
    super.onInit();
  }

  onMapCreated(GoogleMapController controller) async {
    //mapController = controller;
    await updateDriverLocation();
  }

  Future updateDriverLocation() async {
    databaseRef
        .child("drivers")
        .child("${SingleToneValue.instance.driverID}")
        .onValue
        .listen((event) {
      dynamic snapshot = event.snapshot.value;

      lat.value = snapshot["lat"];
      lng.value = snapshot["lng"];

      print("driver lat${lat.value}");
      print("driver lng${lng.value}");
      Markers = {};

      // mapController!.animateCamera(
      //     CameraUpdate.newLatLngZoom(LatLng(lat.value, lng.value), 14.0));

      Markers.add(Marker(
          markerId: MarkerId("driver_marker"),
          position: LatLng(lat.value, lng.value),
          icon: BitmapDescriptor.defaultMarker));
      change(LatLngModel(Markers, onMapCreated), status: RxStatus.success());
    });
    update();
  }
}

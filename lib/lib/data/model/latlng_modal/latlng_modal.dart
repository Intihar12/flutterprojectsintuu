import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngModel {
  Set<Marker> marker;

  void Function(GoogleMapController)? onMapCreated;

  LatLngModel(this.marker, this.onMapCreated);
}

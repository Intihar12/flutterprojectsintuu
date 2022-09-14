import 'dart:io';

import 'package:get/get.dart';
import 'constants/constants.dart';

import 'model/map_search_models/id_to_latlng/id_to_latlng.dart';
import 'model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';

class MapClient extends GetConnect {
  static const _key = 'AIzaSyDYemrIWj0xMxdjONCcD5W4lDj2zxKzLx8';
  static const _pfields = 'fields';
  static const _pKey = 'key';
  static const _pLanguage = 'language';
  static const _pQuery = 'input';
  static const _pPlaceid = 'place_id';

  /// get places of lat lng get places
  Future<IdtoLatLong> getPlacesLatLong(String str) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await get(
      "https://maps.googleapis.com/maps/api/place/details/json",
      query: {'place_id': str, 'key': Constants.mapKey, 'fields': 'geometry'},
    );
    if (response.statusCode == HttpStatus.ok) {
      return IdtoLatLong.fromJson(response.body);
    }
    throw (response.status.hasError);
  }

  Future<AutoComplete> getPlaces(String str,
      {String? key, String? language}) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await get(
      "https://maps.googleapis.com/maps/api/place/autocomplete/json",
      query: {_pQuery: str, _pKey: _key, _pLanguage: 'en'},
    );
    if (response.statusCode == HttpStatus.ok) {
      return AutoComplete.fromJson(response.body);
    }
    throw (response.status.hasError);
  }
}

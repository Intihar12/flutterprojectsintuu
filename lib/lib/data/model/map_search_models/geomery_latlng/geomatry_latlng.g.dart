// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geomatry_latlng.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeomatryLatLng _$GeomatryLatLngFromJson(Map<String, dynamic> json) {
  return GeomatryLatLng(
    result: Result.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeomatryLatLngToJson(GeomatryLatLng instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'geometry': instance.geometry,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    location: Locationlat.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
    };

Locationlat _$LocationlatFromJson(Map<String, dynamic> json) {
  return Locationlat(
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LocationlatToJson(Locationlat instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

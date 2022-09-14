import 'package:json_annotation/json_annotation.dart';

part 'geomatry_latlng.g.dart';

@JsonSerializable()
class GeomatryLatLng {
  @JsonKey(name: 'result')
  Result result;

  GeomatryLatLng({required this.result});

  factory GeomatryLatLng.fromJson(Map<String, dynamic> json) =>
      _$GeomatryLatLngFromJson(json);

  Map<String, dynamic> toJson() => _$GeomatryLatLngToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'geometry')
  Geometry geometry;

  Result({required this.geometry});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Geometry {
  @JsonKey(name: 'location')
  Locationlat location;

  Geometry({required this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Locationlat {
  @JsonKey(name: 'lat')
  double lat;
  @JsonKey(name: 'lng')
  double lng;

  Locationlat({required this.lat, required this.lng});

  factory Locationlat.fromJson(Map<String, dynamic> json) =>
      _$LocationlatFromJson(json);

  Map<String, dynamic> toJson() => _$LocationlatToJson(this);
}

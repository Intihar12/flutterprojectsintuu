import 'package:json_annotation/json_annotation.dart';
part 'fetch_address_model.g.dart';
@JsonSerializable()
class FetchAddress {
  @JsonKey(name:  "results")
  List<Result> results;
  FetchAddress({required this.results});
  factory FetchAddress.fromJson(Map<String, dynamic> json) =>
      _$FetchAddressFromJson(json);
  Map<String, dynamic> toJson() => _$FetchAddressToJson(this);
}
@JsonSerializable()
class Result {
  @JsonKey(name:  "formatted_address")
  String formattedAddress;
  @JsonKey(name:  "address_components")
  List<AddressComponents> addresscomponents;
  Result({
    required this.formattedAddress,
    required this.addresscomponents,
  });
  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
  }
@JsonSerializable()
class AddressComponents {
  @JsonKey(name:  "short_name")
  String shortName;
  @JsonKey(name:  "long_name")
  String longName;
  AddressComponents({
    required this.shortName,
    required this.longName,
  });
  factory AddressComponents.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentsFromJson(json);
  Map<String, dynamic> toJson() => _$AddressComponentsToJson(this);
}
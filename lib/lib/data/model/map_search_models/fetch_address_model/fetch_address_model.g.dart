// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchAddress _$FetchAddressFromJson(Map<String, dynamic> json) {
  return FetchAddress(
    results: (json['results'] as List<dynamic>)
        .map((e) => Result.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FetchAddressToJson(FetchAddress instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    formattedAddress: json['formatted_address'] as String,
    addresscomponents: (json['address_components'] as List<dynamic>)
        .map((e) => AddressComponents.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'formatted_address': instance.formattedAddress,
      'address_components': instance.addresscomponents,
    };

AddressComponents _$AddressComponentsFromJson(Map<String, dynamic> json) {
  return AddressComponents(
    shortName: json['short_name'] as String,
    longName: json['long_name'] as String,
  );
}

Map<String, dynamic> _$AddressComponentsToJson(AddressComponents instance) =>
    <String, dynamic>{
      'short_name': instance.shortName,
      'long_name': instance.longName,
    };

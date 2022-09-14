// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_auto_complete_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoComplete _$AutoCompleteFromJson(Map<String, dynamic> json) {
  return AutoComplete(
    status: json['status'] as String,
    predict: (json['predictions'] as List<dynamic>)
        .map((e) => Predictions.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AutoCompleteToJson(AutoComplete instance) =>
    <String, dynamic>{
      'status': instance.status,
      'predictions': instance.predict,
    };

Predictions _$PredictionsFromJson(Map<String, dynamic> json) {
  return Predictions(
    placeid: json['place_id'] as String,
    structuredformatting: StructuredFormatting.fromJson(
        json['structured_formatting'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'place_id': instance.placeid,
      'structured_formatting': instance.structuredformatting,
    };

StructuredFormatting _$StructuredFormattingFromJson(Map<String, dynamic> json) {
  return StructuredFormatting(
    maintext: json['main_text'] as String,
    secondarytext: json['secondary_text'] as String,
  );
}

Map<String, dynamic> _$StructuredFormattingToJson(
        StructuredFormatting instance) =>
    <String, dynamic>{
      'main_text': instance.maintext,
      'secondary_text': instance.secondarytext,
    };


import 'package:json_annotation/json_annotation.dart';

part 'map_search.g.dart';

@JsonSerializable()
class MapSearchModel {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'predictions')
  List<Predictions> predictions;

  MapSearchModel({required this.status, required this.predictions});

  factory MapSearchModel.fromJson(Map<String, dynamic> json) =>
      _$MapSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapSearchModelToJson(this);
}

@JsonSerializable()
class Predictions {
  @JsonKey(name: 'place_id')
  String placeid;
  @JsonKey(name: 'structured_formatting')
  StructuredFormatting structuredformatting;

  Predictions({required this.placeid, required this.structuredformatting});

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsToJson(this);
}

@JsonSerializable()
class StructuredFormatting {
  @JsonKey(name: 'main_text')
  String maintext;
  @JsonKey(name: 'secondary_text')
  String secondarytext;

  StructuredFormatting({required this.maintext, required this.secondarytext});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}

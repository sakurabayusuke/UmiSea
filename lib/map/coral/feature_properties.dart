// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_properties.freezed.dart';
part 'feature_properties.g.dart';

@freezed
class FeatureProperties with _$FeatureProperties {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory FeatureProperties({
    required List<String> bottomMaterial,
  }) = _FeatureProperties;

  factory FeatureProperties.fromJson(Map<String, dynamic> json) =>
      _$FeaturePropertiesFromJson(json);
}

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'crs_properties.freezed.dart';
part 'crs_properties.g.dart';

@freezed
class CrsProperties with _$CrsProperties {
  factory CrsProperties({
    required String name,
  }) = _CrsProperties;

  factory CrsProperties.fromJson(Map<String, dynamic> json) =>
      _$CrsPropertiesFromJson(json);
}

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:umi_sea/map/coral/feature_properties.dart';
import 'package:umi_sea/map/coral/geometry.dart';

part 'feature.freezed.dart';
part 'feature.g.dart';

@freezed
class Feature with _$Feature {
  factory Feature({
    required String type,
    required FeatureProperties properties,
    required Geometry geometry,
  }) = _Feature;

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
}

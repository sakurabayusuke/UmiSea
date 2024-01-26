// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:umi_sea/map/coral/crs.dart';
import 'package:umi_sea/map/coral/feature.dart';

part 'geo_root.freezed.dart';
part 'geo_root.g.dart';

@freezed
class GeoRoot with _$GeoRoot {
  factory GeoRoot({
    required String type,
    required Crs crs,
    required List<Feature> features,
  }) = _GeoRoot;

  factory GeoRoot.fromJson(Map<String, dynamic> json) =>
      _$GeoRootFromJson(json);
}

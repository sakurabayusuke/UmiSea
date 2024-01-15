// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:umi_sea/map/coral2/crs_properties.dart';

part 'crs.freezed.dart';
part 'crs.g.dart';

@freezed
class Crs with _$Crs {
  factory Crs({
    required String type,
    required CrsProperties properties,
  }) = _Crs;

  factory Crs.fromJson(Map<String, dynamic> json) => _$CrsFromJson(json);
}

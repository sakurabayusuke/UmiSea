// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'coral.freezed.dart';
part 'coral.g.dart';

@freezed
class Coral with _$Coral {
  const Coral._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Coral({
    required int umishiruCoralsId,
    required double longitude,
    required double latitude,
  }) = _Coral;

  factory Coral.fromJson(Map<String, dynamic> json) => _$CoralFromJson(json);
}

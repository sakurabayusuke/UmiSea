import 'package:freezed_annotation/freezed_annotation.dart';

part 'coral.freezed.dart';
part 'coral.g.dart';

@freezed
class Coral with _$Coral {
  const factory Coral({
    required String umishiruCoralsId,
    required String coordinate,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int createdBy,
    required int updatedBy,
  }) = _Coral;

  factory Coral.fromJson(Map<String, dynamic> json) => _$CoralFromJson(json);
}

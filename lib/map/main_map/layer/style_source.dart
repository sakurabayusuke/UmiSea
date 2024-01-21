import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';

class StyleSource {
  static const _styleSource = StyleSource._internal();
  factory StyleSource() => _styleSource;
  const StyleSource._internal();

  Future<void> add(MapboxMap mapboxMap, String sourceName,
      Map<String, dynamic> geoJson, String sourceFormatPath) async {
    final sourceExist = await mapboxMap.style.styleSourceExists(sourceName);
    if (sourceExist) return;

    try {
      logger.t("${LoggerStateEnum.trace}:$sourceName 読み込み開始");
      final sourceFormat = await rootBundle.loadString(sourceFormatPath);
      final Map<String, dynamic> sourceJson = jsonDecode(sourceFormat);
      sourceJson["data"] = geoJson;
      await mapboxMap.style.addStyleSource(sourceName, jsonEncode(sourceJson));
    } on PlatformException catch (e, s) {
      logger.e("${LoggerStateEnum.exception}:$sourceName 追加中に例外}",
          error: e, stackTrace: s);
      rethrow;
    } on Exception catch (e, s) {
      logger.e("${LoggerStateEnum.exception}:$sourceName 読み込み中に例外}",
          error: e, stackTrace: s);
      rethrow;
    }
  }
}

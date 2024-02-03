import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';
import 'package:umi_sea/map/mapbox.dart';

part 'style_layer.g.dart';

@riverpod
class StyleLayer extends _$StyleLayer {
  @override
  void build() => {};

  Future<void> add(String layerName, String layerPath) async {
    final mapboxMap = ref.read(mapboxMapProvider);
    final exist = await mapboxMap.style.styleLayerExists(layerName);
    if (exist) return;

    try {
      logger.t("${LoggerStateEnum.trace}:$layerName 読み込み開始");
      final layer = await rootBundle.loadString(layerPath);
      await mapboxMap.style.addStyleLayer(layer, null);
    } on PlatformException catch (e, s) {
      logger.e("${LoggerStateEnum.exception}:$layerName 追加中に例外}",
          error: e, stackTrace: s);
      rethrow;
    } on Exception catch (e, s) {
      logger.e("${LoggerStateEnum.exception}:$layerName 読み込み中に例外}",
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> remove(String layerName) async {
    final mapboxMap = ref.read(mapboxMapProvider);
    final exist = await mapboxMap.style.styleLayerExists(layerName);
    if (!exist) return;
    try {
      await mapboxMap.style.removeStyleLayer(layerName);
    } on PlatformException catch (e, s) {
      logger.e("${LoggerStateEnum.exception}:$layerName 削除中に例外}",
          error: e, stackTrace: s);
    }
  }
}

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';

class StyleImage {
  static const _styleImage = StyleImage._internal();
  factory StyleImage() => _styleImage;
  const StyleImage._internal();

  Future<void> add(
      MapboxMap mapboxMap, String imageName, String imagePath) async {
    final image = await mapboxMap.style.getStyleImage(imageName);
    if (image != null) return;
    try {
      logger.t("${LoggerStateEnum.trace}:$imageName 読み込み開始");
      final bytes = await rootBundle.load(imagePath);
      final converted = bytes.buffer.asUint8List();
      await mapboxMap.style.addStyleImage(imageName, 7,
          MbxImage(width: 0, height: 0, data: converted), false, [], [], null);
    } on PlatformException catch (e, s) {
      logger.e("${LoggerStateEnum.exception}:$imageName 追加中に例外}",
          error: e, stackTrace: s);
      rethrow;
    } on Exception catch (e, s) {
      logger.e("${LoggerStateEnum.exception}:$imageName 読み込み中に例外}",
          error: e, stackTrace: s);
      rethrow;
    }
  }
}

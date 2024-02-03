import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/Component/icon/icon_png.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';
import 'package:umi_sea/map/mapbox.dart';

part 'style_image.g.dart';

@riverpod
class StyleImage extends _$StyleImage {
  @override
  void build() => {};

  Future<void> add(String imageName, IconPng icon) async {
    final mapboxMap = ref.read(mapboxMapProvider);
    // Android でgetStyleImage を呼ぶと、エラーが表示されて鬱陶しいため、IOS の時だけ実施
    if (Platform.isIOS) {
      final image = await mapboxMap.style.getStyleImage(imageName);
      if (image != null) return;
    }
    try {
      logger.t("${LoggerStateEnum.trace}:$imageName 読み込み開始");
      final bytes = await rootBundle.load(icon.path);
      final converted = bytes.buffer.asUint8List();
      await mapboxMap.style.addStyleImage(
          imageName,
          7,
          MbxImage(width: icon.width, height: icon.height, data: converted),
          false,
          [],
          [],
          null);
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

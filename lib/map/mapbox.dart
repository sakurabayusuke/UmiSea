import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/infrastructure/logger/logger.dart';

part 'mapbox.g.dart';

void initMapboxMap(MapboxMap mapboxMap) => _mapboxMap = mapboxMap;

late final MapboxMap? _mapboxMap;

@Riverpod(keepAlive: true)
// ignore: unsupported_provider_value
MapboxMap mapboxMap(MapboxMapRef ref) {
  if (_mapboxMap == null) {
    logger.f("MapboxMap が初期化されていません。");
    throw Error;
  }
  return _mapboxMap!;
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/Component/icon/icon_png.dart';
import 'package:umi_sea/infrastructure/exception/server_error_exception.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/infrastructure/mapbox/style_image.dart';
import 'package:umi_sea/infrastructure/mapbox/style_layer.dart' as infra_layer;
import 'package:umi_sea/infrastructure/mapbox/style_source.dart'
    as infra_source;
import 'package:umi_sea/main.dart';
import 'package:umi_sea/map/coral/coral_repository.dart';

class CoralLayer {
  CoralLayer(MapboxMap mapboxMap)
      : this.forTesting(
          mapboxMap: mapboxMap,
          styleImage: StyleImage(),
          styleLayer: infra_layer.StyleLayer(),
          styleSource: infra_source.StyleSource(),
          repository: CoralRepository(),
        );

  CoralLayer.forTesting({
    required MapboxMap mapboxMap,
    required StyleImage styleImage,
    required infra_layer.StyleLayer styleLayer,
    required infra_source.StyleSource styleSource,
    required CoralRepository repository,
  })  : _mapboxMap = mapboxMap,
        _styleImage = styleImage,
        _styleLayer = styleLayer,
        _styleSource = styleSource,
        _coralRepository = repository;

  final MapboxMap _mapboxMap;
  final StyleImage _styleImage;
  final infra_layer.StyleLayer _styleLayer;
  final infra_source.StyleSource _styleSource;
  final CoralRepository _coralRepository;

  static const ({String name, String path}) _source =
      (name: "corals", path: "assets/coral_cluster/source.json");

  static const ({String name, String path}) _clusterLayer =
      (name: "cluster_layer", path: "assets/coral_cluster/cluster_layer.json");

  static const ({String name, String path}) _clusterCountLayer = (
    name: "cluster_count_layer",
    path: "assets/coral_cluster/cluster_count_layer.json"
  );

  static const ({String name, String path}) _unclusterLayer = (
    name: "uncluster_layer",
    path: "assets/coral_cluster/uncluster_layer.json"
  );

  static const String _coralIconName = "coral_icon";
  static const String _coralMarkerIconName = "coral_marker_icon";

  /// レイヤーが追加中かどうか。状況によって複数回 create がコールされてしまうため、その防止策。
  static bool _addingLayer = false;

  Future<void> create() async {
    if (_addingLayer) {
      logger.t("$LoggerStateEnum.trace:現在、珊瑚礁レイヤーを追加中です。新規の命令は受け付けられません。");
      return;
    }
    _addingLayer = true;
    try {
      await _styleImage.add(_mapboxMap, _coralIconName, IconPng.coral.path);
      await _styleImage.add(
          _mapboxMap, _coralMarkerIconName, IconPng.coralMarker.path);

      final geoJson = await _coralRepository.getCoralGeoJson();
      await _styleSource.add(_mapboxMap, _source.name, geoJson!, _source.path);

      await _styleLayer.add(_mapboxMap, _clusterLayer.name, _clusterLayer.path);
      await _styleLayer.add(
          _mapboxMap, _clusterCountLayer.name, _clusterCountLayer.path);
      await _styleLayer.add(
          _mapboxMap, _unclusterLayer.name, _unclusterLayer.path);
    } on TimeoutException catch (e, s) {
      logger.e("$LoggerStateEnum.e:サーバーから応答がない", error: e, stackTrace: s);
      rethrow;
    } on ServerErrorException catch (e, s) {
      logger.e("$LoggerStateEnum.e:サーバーになんらかの異常が発生", error: e, stackTrace: s);
      rethrow;
    } on Exception catch (e, s) {
      logger.e("$LoggerStateEnum.e:レイヤー追加中になんらかの例外が発生",
          error: e, stackTrace: s);
      remove();
      rethrow;
    } finally {
      _addingLayer = false;
    }
  }

  Future<void> remove() async {
    try {
      await _styleLayer.remove(_mapboxMap, _clusterCountLayer.name);
      await _styleLayer.remove(_mapboxMap, _clusterLayer.name);
      await _styleLayer.remove(_mapboxMap, _unclusterLayer.name);
    } on Exception catch (e, s) {
      logger.e("$LoggerStateEnum.e:レイヤー追加中になんらかの例外が発生",
          error: e, stackTrace: s);
      rethrow;
    }
  }
}

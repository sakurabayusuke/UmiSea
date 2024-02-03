import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/Component/icon/icon_png.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';
import 'package:umi_sea/map/coral/coral_repository.dart';
import 'package:umi_sea/map/main_map/layer/style_image.dart';
import 'package:umi_sea/map/main_map/layer/style_layer.dart';
import 'package:umi_sea/map/main_map/layer/style_source.dart';

part 'coral_layer.g.dart';

@riverpod
class CoralLayer extends _$CoralLayer {
  @override
  void build() => {};

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
      logger.w("${LoggerStateEnum.warning}:現在、珊瑚礁レイヤーを追加中です。新規の命令は受け付けられません。");
      return;
    }
    _addingLayer = true;
    try {
      await ref
          .read(styleImageProvider.notifier)
          .add(_coralIconName, IconPng.coral);
      await ref
          .read(styleImageProvider.notifier)
          .add(_coralMarkerIconName, IconPng.coralMarker);

      final geoJson =
          await ref.read(coralRepositoryProvider.notifier).getCoralGeoJson();
      await ref
          .read(styleSourceProvider.notifier)
          .add(_source.name, geoJson!, _source.path);

      await ref
          .read(styleLayerProvider.notifier)
          .add(_clusterLayer.name, _clusterLayer.path);
      await ref
          .read(styleLayerProvider.notifier)
          .add(_clusterCountLayer.name, _clusterCountLayer.path);
      await ref
          .read(styleLayerProvider.notifier)
          .add(_unclusterLayer.name, _unclusterLayer.path);
    } on Exception {
      rethrow;
    } finally {
      _addingLayer = false;
    }
  }

  Future<void> remove() async {
    try {
      await ref
          .read(styleLayerProvider.notifier)
          .remove(_clusterCountLayer.name);
      await ref.read(styleLayerProvider.notifier).remove(_clusterLayer.name);
      await ref.read(styleLayerProvider.notifier).remove(_unclusterLayer.name);
    } on Exception {
      rethrow;
    }
  }
}

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/Component/icon/icon_png.dart';
import 'package:umi_sea/map/coral/coral_repository.dart';

class CoralLayer {
  static final _creator = CoralLayer._internal();
  factory CoralLayer() => _creator;
  CoralLayer._internal();

  final CoralRepository _coralRepository = CoralRepository();

  static const String _sourceName = "corals";
  static const String _sourcePath = "assets/coral_cluster/source.json";

  static const String _clusterLayerName = "cluster_layer";
  static const String _clusterLayerPath =
      "assets/coral_cluster/cluster_layer.json";
  static const String _clusterCountLayerName = "cluster_count_layer";
  static const String _clusterCountLayerPath =
      "assets/coral_cluster/cluster_count_layer.json";
  static const String _unclusterLayerName = "uncluster_layer";
  static const String _unclusterLayerPath =
      "assets/coral_cluster/uncluster_layer.json";

  static const String _coralIconName = "coral_icon";
  static const String _coralMarkerIconName = "coral_marker_icon";

  /// アイコンの幅と高さ。必須だがどんなサイズを入れても、変化が見られない
  static const int _iconWidthAndHeight = 0;

  Future<bool> create(MapboxMap mapboxMap) async {
    await _addImage(mapboxMap);
    final sourceCreateSuccess = await _addSource(mapboxMap);
    if (!sourceCreateSuccess) {
      return false;
    }
    await _addLayer(mapboxMap);
    return true;
  }

  Future<bool> _addSource(MapboxMap mapboxMap) async {
    final sourceExist = await mapboxMap.style.styleSourceExists(_sourceName);
    if (sourceExist) {
      return true;
    }

    final corals = await _coralRepository.getCoralGeoJson();
    if (corals == null) {
      return false;
    }
    final source = await rootBundle.loadString(_sourcePath);
    final Map<String, dynamic> sourceJson = jsonDecode(source);
    sourceJson["data"] = corals;
    await mapboxMap.style.addStyleSource(_sourceName, jsonEncode(sourceJson));

    return true;
  }

  Future<void> _addImage(MapboxMap mapboxMap) async {
    final coral = await mapboxMap.style.getStyleImage(_coralIconName);
    if (coral == null) {
      final bytes = await rootBundle.load(IconPng.coral.path);
      final converted = bytes.buffer.asUint8List();
      await mapboxMap.style.addStyleImage(
          _coralIconName,
          7,
          MbxImage(
              width: _iconWidthAndHeight,
              height: _iconWidthAndHeight,
              data: converted),
          false,
          [],
          [],
          null);
    }

    final coralMarker =
        await mapboxMap.style.getStyleImage(_coralMarkerIconName);
    if (coralMarker != null) return;

    final bytes = await rootBundle.load(IconPng.coralMarker.path);
    final converted = bytes.buffer.asUint8List();
    await mapboxMap.style.addStyleImage(
      _coralMarkerIconName,
      3,
      MbxImage(
        width: _iconWidthAndHeight,
        height: _iconWidthAndHeight,
        data: converted,
      ),
      false,
      [],
      [],
      null,
    );
  }

  Future<void> _addLayer(MapboxMap mapboxMap) async {
    final clusterLayerExist =
        await mapboxMap.style.styleLayerExists(_clusterLayerName);
    if (!clusterLayerExist) {
      final layer = await rootBundle.loadString(_clusterLayerPath);
      await mapboxMap.style.addStyleLayer(layer, null);
    }

    final clusterCountLayerExist =
        await mapboxMap.style.styleLayerExists(_clusterCountLayerName);
    if (!clusterCountLayerExist) {
      final layer = await rootBundle.loadString(_clusterCountLayerPath);
      await mapboxMap.style.addStyleLayer(layer, null);
    }

    final unclusterLayerExist =
        await mapboxMap.style.styleLayerExists(_unclusterLayerName);
    if (!unclusterLayerExist) {
      final layer = await rootBundle.loadString(_unclusterLayerPath);
      await mapboxMap.style.addStyleLayer(layer, null);
    }
  }
}

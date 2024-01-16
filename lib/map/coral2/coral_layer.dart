import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/Component/icon/icon_png.dart';
import 'package:umi_sea/map/coral2/coral_repository.dart';

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

  static const String _coralIconBaseName = "coral_icon_";
  static const List<String> _coralIconNames = [
    "${_coralIconBaseName}large",
    "${_coralIconBaseName}middle",
    "${_coralIconBaseName}small",
  ];
  static const List<int> _coralIconSizes = [56, 40, 24];
  static const String _coralMarkerIconName = "coral_marker_icon";
  static const double _baseScale = 1.0;
  static const int _coralMarkerHeight = 46;
  static const int _coralMarkerWidth = 31;

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
    for (var i = 0; i < _coralIconNames.length; i++) {
      final coral = await mapboxMap.style.getStyleImage(_coralIconNames[i]);
      if (coral != null) continue;

      final bytes = await rootBundle.load(IconPng.coral.path);
      final converted = bytes.buffer.asUint8List();
      await mapboxMap.style.addStyleImage(
          _coralIconNames[i],
          7,
          MbxImage(
            width: _coralIconSizes[i],
            height: _coralIconSizes[i],
            data: converted,
          ),
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
        width: _coralMarkerWidth,
        height: _coralMarkerHeight,
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

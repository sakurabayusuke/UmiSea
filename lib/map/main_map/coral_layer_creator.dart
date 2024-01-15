import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/Component/icon/icon_png.dart';
import 'package:umi_sea/map/coral2/coral_repository.dart';

class CoralLayerCreator {
  static final _repository = CoralLayerCreator._internal();
  factory CoralLayerCreator() => _repository;
  CoralLayerCreator._internal();

  final CoralRepository _coralRepository = CoralRepository();

  static const String _sourceName = "corals";
  static const String _layerName = "corals";
  static const String _coralIconBaseName = "coral-icon";
  static const List<String> _coralIconNames = [
    "${_coralIconBaseName}large",
    "${_coralIconBaseName}middle",
    "${_coralIconBaseName}small",
  ];
  static const List<int> _coralIconSizes = [56, 40, 24];
  static const String _coralMarkerIconName = "coral-marker-icon";
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
    final geojson = <String, dynamic>{
      "type": "geojson",
      "data": corals,
      "cluster": true,
      "clusterMaxZoom": 14,
      "clusterRadius": 50
    };
    mapboxMap.style.addStyleSource(_sourceName, geojson.toString());

    return true;
  }

  Future<void> _addImage(MapboxMap mapboxMap) async {
    for (var i = 0; i < _coralIconNames.length; i++) {
      final coral = await mapboxMap.style.getStyleImage(_coralIconNames[i]);
      if (coral != null) continue;

      final bytes = await rootBundle.load(IconPng.coral.path);
      final converted = bytes.buffer.asUint8List();
      mapboxMap.style.addStyleImage(
        _coralIconNames[i],
        _baseScale,
        MbxImage(
          width: _coralIconSizes[i],
          height: _coralIconSizes[i],
          data: converted,
        ),
        true,
        [],
        [],
        null,
      );
    }
    final coralMarker =
        await mapboxMap.style.getStyleImage(_coralMarkerIconName);
    if (coralMarker != null) return;

    final bytes = await rootBundle.load(IconPng.coralMarker.path);
    final converted = bytes.buffer.asUint8List();
    mapboxMap.style.addStyleImage(
      _coralMarkerIconName,
      _baseScale,
      MbxImage(
        width: _coralMarkerWidth,
        height: _coralMarkerHeight,
        data: converted,
      ),
      true,
      [],
      [],
      null,
    );
  }

  Future<bool> _addLayer(MapboxMap mapboxMap) async {
    final layerExist = await mapboxMap.style.styleLayerExists(_layerName);
    if (layerExist) {
      return true;
    }
    return true;
  }
}

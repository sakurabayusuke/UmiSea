import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/coral/coral_layer.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

class MapScreenNotifier extends StateNotifier<MapScreenState> {
  MapScreenNotifier(this._coralLayerCreator)
      : super(const MapScreenState(
          initialized: false,
          coralIsDisplaying: false,
          splashIsEnd: false,
        ));
  late final MapboxMap? _mapboxMap;
  final CoralLayer _coralLayerCreator;

  void onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    mapboxMap.style.localizeLabels("ja", null);

    // スプラッシュスクリーンを表示させておくための処理
    await Future.delayed(const Duration(milliseconds: 1500));
    state = state.copyWith(initialized: true);
  }

  Future<void> addCoralLayer() async {
    if (state.coralIsDisplaying) return;
    await _coralLayerCreator.create(_mapboxMap!);
    state = state.copyWith(coralIsDisplaying: true);
  }

  Future<void> deleteAllCorals() async {
    if (!state.coralIsDisplaying) return;
    await _coralLayerCreator.remove(_mapboxMap!);
    state = state.copyWith(coralIsDisplaying: false);
  }

  void removeSplash() {
    state = state.copyWith(splashIsEnd: true);
  }
}

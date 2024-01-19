import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/coral/coral_layer.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

part 'map_screen_notifier.g.dart';

@riverpod
class MapScreenNotifier extends _$MapScreenNotifier {
  MapScreenNotifier() : this.forTesting(coralLayer: CoralLayer());

  MapScreenNotifier.forTesting({required coralLayer})
      : _coralLayer = coralLayer;

  @override
  MapScreenState build() => const MapScreenState(
        initialized: false,
        splashIsEnd: false,
      );

  late final MapboxMap? _mapboxMap;
  final CoralLayer _coralLayer;

  void onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    mapboxMap.style.localizeLabels("ja", null);

    // スプラッシュスクリーンを表示させておくための処理
    await Future.delayed(const Duration(milliseconds: 1500));
    state = state.copyWith(initialized: true);
  }

  Future<void> addCoralLayer() async {
    await _coralLayer.create(_mapboxMap!);
  }

  Future<void> deleteAllCorals() async {
    await _coralLayer.remove(_mapboxMap!);
  }

  void removeSplash() {
    state = state.copyWith(splashIsEnd: true);
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';
import 'package:umi_sea/map/main_map/layer_notifier.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

part 'map_screen_notifier.g.dart';

@riverpod
class MapScreenNotifier extends _$MapScreenNotifier {
  MapScreenNotifier() : this.forTesting();

  MapScreenNotifier.forTesting();

  @override
  MapScreenState build() => const MapScreenState(
        initialized: false,
        splashIsEnd: false,
        bottomSheetIsAnimating: false,
      );

  Future<void> onMapCreated(MapboxMap mapboxMap) async {
    mapboxMap.style.localizeLabels("ja", null);
    ref.read(layerNotifierProvider.notifier).initialize(mapboxMap);

    // スプラッシュスクリーンを表示させておくための処理
    await Future.delayed(const Duration(milliseconds: 1500));
    initialized();
  }

  Future<void> initialized() async {
    state = state.copyWith(initialized: true);

    final filterState = ref.read(filterSheetNotifierProvider);
    if (filterState.filters[Filter.coral]!) {
      await ref.read(layerNotifierProvider.notifier).addCoralLayer();
    }
  }

  void activateSheetAnimation() =>
      state = state.copyWith(bottomSheetIsAnimating: true);

  void deactivateSheetAnimation() =>
      state = state.copyWith(bottomSheetIsAnimating: false);

  void removeSplash() {
    state = state.copyWith(splashIsEnd: true);
  }
}

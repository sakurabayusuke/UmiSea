import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/coral/coral_layer.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

part 'async_map_screen_notifier.g.dart';

@riverpod
class AsyncMapScreenNotifier extends _$AsyncMapScreenNotifier {
  AsyncMapScreenNotifier() : this.forTesting(coralLayer: CoralLayer());

  AsyncMapScreenNotifier.forTesting({required coralLayer})
      : _coralLayer = coralLayer;

  @override
  FutureOr<MapScreenState> build() => const MapScreenState(
        initialized: false,
        splashIsEnd: false,
      );

  late final MapboxMap? _mapboxMap;
  final CoralLayer _coralLayer;

  Future<void> onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    mapboxMap.style.localizeLabels("ja", null);

    // スプラッシュスクリーンを表示させておくための処理
    await Future.delayed(const Duration(milliseconds: 1500));
    initialized();
  }

  void initialized() {
    state = AsyncData(state.value!.copyWith(initialized: true));

    final filterState = ref.read(filterSheetNotifierProvider);
    if (filterState.filters[Filter.coral]!) {
      addCoralLayer();
    }
  }

  Future<void> addCoralLayer() async {
    state = const AsyncLoading<MapScreenState>();
    await Future.delayed(const Duration(milliseconds: 1500));
    try {
      await _coralLayer.create(_mapboxMap!);
      state = AsyncData(state.value!.copyWith());
    } on Exception catch (e, s) {
      state = AsyncError<MapScreenState>(e, s);
    }
  }

  Future<void> deleteCoralLayer() async {
    state = const AsyncLoading<MapScreenState>();
    try {
      await _coralLayer.remove(_mapboxMap!);
      state = AsyncData(state.value!.copyWith());
    } on Exception catch (e, s) {
      state = AsyncError<MapScreenState>(e, s);
    }
  }

  void removeSplash() {
    state = AsyncData(state.value!.copyWith(splashIsEnd: true))
        .copyWithPrevious(state);
  }
}

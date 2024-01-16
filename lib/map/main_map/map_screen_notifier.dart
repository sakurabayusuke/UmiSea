import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/coral/coral_layer.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

class MapScreenNotifier extends StateNotifier<MapScreenState> {
  MapScreenNotifier({required this.coralLayerCreator})
      : super(const MapScreenState(
          initialized: false,
          coralIsDisplaying: false,
          splashIsEnd: false,
          bottomSheetIsVisible: false,
        ));
  late final MapboxMap? mapboxMap;
  final CoralLayer coralLayerCreator;

  void onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    await Future.delayed(const Duration(milliseconds: 1500));
    state = state.copyWith(initialized: true);
  }

  Future<void> addCoralLayer() async {
    if (state.coralIsDisplaying) return;
    await coralLayerCreator.create(mapboxMap!);
    state = state.copyWith(coralIsDisplaying: true);
  }

  Future<void> deleteAllCorals() async {
    if (!state.coralIsDisplaying) return;
    await coralLayerCreator.remove(mapboxMap!);
    state = state.copyWith(coralIsDisplaying: false);
  }

  void removeSplash() {
    state = state.copyWith(splashIsEnd: true);
  }

  void showBottomSheet() => state = state.copyWith(bottomSheetIsVisible: true);

  void removeBottomSheet() =>
      state = state.copyWith(bottomSheetIsVisible: false);
}

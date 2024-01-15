import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/main_map/coral_layer_creator.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

class MapScreenNotifier extends StateNotifier<MapScreenState> {
  MapScreenNotifier({required this.coralLayerCreator})
      : super(
            const MapScreenState(initialized: false, coralIsDisplaying: false));
  late final MapboxMap? mapboxMap;
  final CoralLayerCreator coralLayerCreator;

  void onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    state = state.copyWith(initialized: true);
  }

  Future<void> addCoralLayer() async {
    await coralLayerCreator.create(mapboxMap!);
    state = state.copyWith(coralIsDisplaying: true);
  }

  Future<void> deleteAllCorals() async {}
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/coral/coral_repository.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';
import 'package:umi_sea/map/main_map/point_annotation_option_creator.dart';

class MapScreenNotifier extends StateNotifier<MapScreenState> {
  MapScreenNotifier() : super(MapScreenState(coralsPoint: []));

  final CoralRepository coralRepository = CoralRepository();

  void onMapCreated(MapboxMap mapboxMap) async {
    final pointManager =
        await mapboxMap.annotations.createPointAnnotationManager();
    state = state.copyWith(
        mapboxMap: mapboxMap, pointAnnotationManager: pointManager);
  }

  Future<void> putAllCorals() async {
    if (state.mapboxMap == null) {
      return;
    }
    if (state.coralsPoint.isNotEmpty) {
      return;
    }
    final pointCreator = PointAnnotationOptionCreator();
    final coralsPoint = await pointCreator.getCoralAnnotations;
    final coralsPointAnnotation =
        await state.pointAnnotationManager!.createMulti(coralsPoint);
    state = state.copyWith(coralsPoint: coralsPointAnnotation);
  }

  Future<void> deleteAllCorals() async {
    if (state.mapboxMap == null) {
      return;
    }
    if (state.coralsPoint.isEmpty) {
      return;
    }
    final futures = <Future>[];
    for (final point in state.coralsPoint) {
      if (point == null) continue;
      futures.add(state.pointAnnotationManager!.delete(point));
    }
    await Future.wait(futures);
    state = state.copyWith(coralsPoint: []);
  }
}

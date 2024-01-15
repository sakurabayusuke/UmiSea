import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreenState {
  MapScreenState({
    this.mapboxMap,
    // this.pointAnnotationManager,
    // required this.coralsPoint,
  });

  late final MapboxMap? mapboxMap;
  // late final PointAnnotationManager? pointAnnotationManager;
  // final List<PointAnnotation?> coralsPoint;

  MapScreenState copyWith({
    MapboxMap? mapboxMap,
    // PointAnnotationManager? pointAnnotationManager,
    // List<PointAnnotation?>? coralsPoint,
  }) {
    return MapScreenState(
      mapboxMap: mapboxMap ?? this.mapboxMap,
      // pointAnnotationManager:
      //     pointAnnotationManager ?? this.pointAnnotationManager,
      // coralsPoint: coralsPoint ?? this.coralsPoint,
    );
  }
}

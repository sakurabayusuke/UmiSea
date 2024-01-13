import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreenState {
  MapScreenState({
    this.mapboxMap,
    this.pointAnnotationManager,
    this.coralsPoint,
    this.coralIsDisplaying,
  });

  late final MapboxMap? mapboxMap;
  late final PointAnnotationManager? pointAnnotationManager;
  late final List<PointAnnotation?>? coralsPoint;
  late final bool? coralIsDisplaying;

  MapScreenState copyWith({
    MapboxMap? mapboxMap,
    PointAnnotationManager? pointAnnotationManager,
    List<PointAnnotation?>? coralsPoint,
    bool? coralIsDisplaying,
  }) {
    return MapScreenState(
        mapboxMap: mapboxMap ?? this.mapboxMap,
        pointAnnotationManager:
            pointAnnotationManager ?? this.pointAnnotationManager,
        coralsPoint: coralsPoint ?? this.coralsPoint,
        coralIsDisplaying: coralIsDisplaying ?? this.coralIsDisplaying);
  }
}

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/map/coral/coral_repository.dart';
import 'package:umi_sea/map/filter/filter.dart';

class PointAnnotationOptionCreator {
  static final _creator = PointAnnotationOptionCreator._internal();
  factory PointAnnotationOptionCreator() => _creator;
  PointAnnotationOptionCreator._internal();

  final CoralRepository _coralRepository = CoralRepository();

  Future<List<PointAnnotationOptions>> get getCoralAnnotations async {
    final corals = await _coralRepository.getAllCoral();
    final maker = await rootBundle.load(Filter.coral.maker.path);
    final makerBinary = maker.buffer.asUint8List();

    final annotations = <PointAnnotationOptions>[];
    for (var i = 0; i < corals.length; i++) {
      final coral = corals[i];
      annotations.add(
        PointAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                coral.longitude,
                coral.latitude,
              ),
            ).toJson(),
            iconOffset: [0.0, -0.5],
            image: makerBinary,
            iconSize: 2,
            symbolSortKey: i.toDouble()),
      );
    }
    return annotations;
  }
}

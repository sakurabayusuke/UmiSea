import 'dart:async';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/infrastructure/exception/exception_mixin.dart';
import 'package:umi_sea/map/coral/coral_layer.dart';
import 'package:umi_sea/snack_bar_notifier.dart';

part 'layer_notifier.g.dart';

@riverpod
class LayerNotifier extends _$LayerNotifier with ExceptionMethods {
  LayerNotifier() : this.forTesting(coralLayer: CoralLayer());

  LayerNotifier.forTesting({required coralLayer}) : _coralLayer = coralLayer;

  final CoralLayer _coralLayer;
  late final MapboxMap _mapboxMap;

  @override
  FutureOr<void> build() => {};

  void initialize(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
  }

  Future<bool> addCoralLayer() async {
    state = const AsyncLoading<void>();
    try {
      await _coralLayer.create(_mapboxMap);
      state = const AsyncData(null);
      return true;
    } on Exception catch (e, s) {
      state = AsyncError<void>(e, s);
      ref
          .read(snackBarNotifierProvider.notifier)
          .showSnackBar(getErrorMessage(e));
      return false;
    }
  }

  Future<bool> removeCoralLayer() async {
    state = const AsyncLoading<void>();
    try {
      await _coralLayer.remove(_mapboxMap);
      state = const AsyncData(null);
      return true;
    } on Exception catch (e, s) {
      state = AsyncError<void>(e, s);
      ref
          .read(snackBarNotifierProvider.notifier)
          .showSnackBar(getErrorMessage(e));
      return false;
    }
  }
}

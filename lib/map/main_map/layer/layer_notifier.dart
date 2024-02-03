import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/infrastructure/exception/exception_mixin.dart';
import 'package:umi_sea/map/coral/coral_layer.dart';
import 'package:umi_sea/snack_bar_notifier.dart';

part 'layer_notifier.g.dart';

@riverpod
class LayerNotifier extends _$LayerNotifier with ExceptionMethods {
  @override
  FutureOr<void> build() => {};

  Future<bool> addCoralLayer() async {
    state = const AsyncLoading<void>();
    try {
      await ref.read(coralLayerProvider.notifier).create();
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
      await ref.read(coralLayerProvider.notifier).remove();
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

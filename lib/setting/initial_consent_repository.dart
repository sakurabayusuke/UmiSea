import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/infrastructure/repository/shared_preference_repository.dart';

part 'initial_consent_repository.g.dart';

@riverpod
class InitialConsentRepository extends _$InitialConsentRepository {
  static const key = "initialConsent";

  @override
  bool build() => ref.read(sharedPreferencesProvider).getBool(key) ?? false;

  Future<void> setInitialConsent(bool value) async =>
      await ref.read(sharedPreferencesProvider).setBool(key, value);
}

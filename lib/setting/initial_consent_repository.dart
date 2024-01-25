import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/infrastructure/repository/shared_preference_repository.dart';

part 'initial_consent_repository.g.dart';

@riverpod
class InitialConsentRepository extends _$InitialConsentRepository {
  @override
  bool build() {
    final pref = SharedPreferenceRepository();
    return pref.getBool(key) ?? false;
  }

  static const key = "initialConsent";

  Future<void> setInitialConsent(bool value) async {
    final pref = SharedPreferenceRepository();
    await pref.setBool(key, value);
  }
}

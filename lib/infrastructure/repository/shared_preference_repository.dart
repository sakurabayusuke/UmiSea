import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference_repository.g.dart';

Future<void> initSharedPreference() async =>
    _pref = await SharedPreferences.getInstance();

late final SharedPreferences _pref;

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) => _pref;

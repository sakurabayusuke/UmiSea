import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snack_bar_notifier.g.dart';

@riverpod
class SnackBarNotifier extends _$SnackBarNotifier {
  @override
  String build() => "";

  void showSnackBar(String message) => state = message;
  void clearState() => state = "";
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';

class FilterSheetNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterSheetNotifier(Map<Filter, bool> state) : super(state);

  void toggle(Filter filter) {
    state[filter] = !state[filter]!;
    final repository = FilterRepository();
    repository.setFilter(filter, state[filter]!);
    state = {...state};
  }
}

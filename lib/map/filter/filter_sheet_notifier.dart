import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_state.dart';

class FilterSheetNotifier extends StateNotifier<FilterSheetState> {
  FilterSheetNotifier(Map<Filter, bool> filters)
      : super(FilterSheetState(filters: filters));

  void toggle(Filter filter) {
    state.filters[filter] = !state.filters[filter]!;
    final repository = FilterRepository();
    repository.setFilter(filter, state.filters[filter]!);
    state = state.copyWith(filters: state.filters);
  }
}

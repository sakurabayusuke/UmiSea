import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_state.dart';

class FilterSheetNotifier extends StateNotifier<FilterSheetState> {
  FilterSheetNotifier(this._filterRepository,
      {required this.scrollableController})
      : super(
          FilterSheetState(
            filters: _filterRepository.getFilter,
            isAnimating: false,
          ),
        );
  final FilterRepository _filterRepository;

  final DraggableScrollableController scrollableController;

  void toggle(Filter filter) {
    state.filters[filter] = !state.filters[filter]!;
    _filterRepository.setFilter(filter, state.filters[filter]!);
    state = state.copyWith(filters: state.filters);
  }

  void display() async {
    state = state.copyWith(isAnimating: true);
    await scrollableController.animateTo(0.45,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    state = state.copyWith(isAnimating: false);
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_state.dart';

part 'filter_sheet_notifier.g.dart';

@riverpod
class FilterSheetNotifier extends _$FilterSheetNotifier {
  FilterSheetNotifier()
      : this.forTesting(
          repository: FilterRepository(),
          scrollableController: DraggableScrollableController(),
        );
  FilterSheetNotifier.forTesting({
    required FilterRepository repository,
    required this.scrollableController,
  }) : _repository = repository;

  @override
  FilterSheetState build() =>
      FilterSheetState(filters: _repository.getFilter, isAnimating: false);

  final FilterRepository _repository;

  final DraggableScrollableController scrollableController;

  void toggle(Filter filter) {
    state.filters[filter] = !state.filters[filter]!;
    _repository.setFilter(filter, state.filters[filter]!);
    state = state.copyWith(filters: state.filters);
  }

  void display() async {
    state = state.copyWith(isAnimating: true);
    await scrollableController.animateTo(0.45,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    state = state.copyWith(isAnimating: false);
  }
}

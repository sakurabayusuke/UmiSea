import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_state.dart';
import 'package:umi_sea/map/main_map/async_map_screen_notifier.dart';

part 'filter_sheet_notifier.g.dart';

@riverpod
class FilterSheetNotifier extends _$FilterSheetNotifier {
  FilterSheetNotifier()
      : this.forTesting(
          repository: FilterRepository(),
        );
  FilterSheetNotifier.forTesting({
    required FilterRepository repository,
  }) : _repository = repository;

  @override
  FilterSheetState build() =>
      FilterSheetState(filters: _repository.getFilter, isAnimating: false);

  final FilterRepository _repository;

  void toggle(Filter filter) async {
    state.filters[filter] = !state.filters[filter]!;
    _repository.setFilter(filter, state.filters[filter]!);
    state = state.copyWith(filters: state.filters);
    var a = ref.read(asyncMapScreenNotifierProvider.notifier);
    await a.addCoralLayer();
    // ここで更新？
  }
}

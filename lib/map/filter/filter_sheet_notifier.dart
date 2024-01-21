import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_state.dart';
import 'package:umi_sea/map/main_map/layer/layer_notifier.dart';

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
  FilterSheetState build() => FilterSheetState(
        filters: _repository.getFilter,
        isAnimating: false,
        requireShowErrorMessage: false,
      );

  final FilterRepository _repository;

  Future<void> addCoralLayer(Filter filter) async {
    final result =
        await ref.read(layerNotifierProvider.notifier).addCoralLayer();
    if (!result) return;
    state.filters[filter] = true;
    state = state.copyWith(filters: state.filters);
    _repository.setFilters(state.filters);
  }

  Future<void> removeCoralLayer(Filter filter) async {
    final result =
        await ref.read(layerNotifierProvider.notifier).removeCoralLayer();
    if (!result) return;
    state.filters[filter] = false;
    state = state.copyWith(filters: state.filters);
    _repository.setFilters(state.filters);
  }
}

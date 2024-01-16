import 'package:umi_sea/map/filter/filter.dart';

class FilterSheetState {
  const FilterSheetState({
    required this.filters,
  });

  final Map<Filter, bool> filters;

  FilterSheetState copyWith({
    Map<Filter, bool>? filters,
  }) {
    return FilterSheetState(
      filters: filters ?? this.filters,
    );
  }
}

import 'package:umi_sea/map/filter/filter.dart';

class FilterSheetState {
  const FilterSheetState({
    required this.filters,
    required this.isAnimating,
  });

  final Map<Filter, bool> filters;
  final bool isAnimating;

  FilterSheetState copyWith({
    Map<Filter, bool>? filters,
    bool? isAnimating,
  }) {
    return FilterSheetState(
      filters: filters ?? this.filters,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }
}

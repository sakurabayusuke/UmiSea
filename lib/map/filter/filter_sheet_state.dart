import 'package:umi_sea/map/filter/filter.dart';

class FilterSheetState {
  const FilterSheetState({
    required this.filters,
    required this.isAnimating,
    required this.requireShowErrorMessage,
  });

  final Map<Filter, bool> filters;
  final bool isAnimating;
  final bool requireShowErrorMessage;

  FilterSheetState copyWith({
    Map<Filter, bool>? filters,
    bool? isAnimating,
    bool? requireShowErrorMessage,
  }) {
    return FilterSheetState(
      filters: filters ?? this.filters,
      isAnimating: isAnimating ?? this.isAnimating,
      requireShowErrorMessage:
          requireShowErrorMessage ?? this.requireShowErrorMessage,
    );
  }
}

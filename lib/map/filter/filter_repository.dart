import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/infrastructure/repository/shared_preference_repository.dart';
import 'package:umi_sea/map/filter/filter.dart';

part 'filter_repository.g.dart';

@riverpod
class FilterRepository extends _$FilterRepository {
  @override
  void build() {}

  Map<Filter, bool> get() {
    Map<Filter, bool> filtersSelected = {};
    for (var filter in Filter.values) {
      filtersSelected[filter] =
          ref.read(sharedPreferencesProvider).getBool(filter.name) ?? false;
    }
    return filtersSelected;
  }

  void setFilters(Map<Filter, bool> filters) {
    filters.forEach((Filter key, bool value) {
      ref.read(sharedPreferencesProvider).setBool(key.name, value);
    });
  }

  void setFilter(Filter filter, bool isSelected) {
    ref.read(sharedPreferencesProvider).setBool(filter.name, isSelected);
  }
}

import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/infrastructure/repository/shared_preference_repository.dart';

class FilterRepository {
  static final _repository = FilterRepository._internal();
  factory FilterRepository() => _repository;
  FilterRepository._internal();

  final SharedPreferenceRepository _prefs = SharedPreferenceRepository();

  Map<Filter, bool> get getFilter {
    Map<Filter, bool> filtersSelected = {};
    for (var filter in Filter.values) {
      filtersSelected[filter] = _prefs.getBool(filter.name) ?? false;
    }
    return filtersSelected;
  }

  void setFilters(Map<Filter, bool> filters) {
    filters.forEach((Filter key, bool value) {
      _prefs.setBool(key.name, value);
    });
  }

  void setFilter(Filter filter, bool isSelected) {
    _prefs.setBool(filter.name, isSelected);
  }
}

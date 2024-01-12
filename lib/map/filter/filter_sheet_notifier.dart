import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/map/filter/filter.dart';

class FilterSheetNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterSheetNotifier(Map<Filter, bool> state) : super(state);
}

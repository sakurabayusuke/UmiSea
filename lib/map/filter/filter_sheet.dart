import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';
import 'package:umi_sea/map/filter/filter_tile.dart';

final filterSheetNotifierProvider =
    StateNotifierProvider<FilterSheetNotifier, Map<Filter, bool>>((_) {
  var filterRepository = FilterRepository();
  return FilterSheetNotifier(filterRepository.getFilter);
});

class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list = <Widget>[];
    var filters = ref.watch(filterSheetNotifierProvider);
    for (var filter in filters.keys) {
      list.add(FilterTile(filter: filter));
    }

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.45,
      child: GridView.count(
        crossAxisCount: 4,
        children: list,
      ),
    );
  }
}

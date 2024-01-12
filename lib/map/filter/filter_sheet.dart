import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';

final filterSheetNotifierProvider =
    StateNotifierProvider<FilterSheetNotifier, Map<Filter, bool>>((_) {
  var filterRepository = FilterRepository();
  return FilterSheetNotifier(filterRepository.getFilter);
});

class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.45,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 20,
        itemBuilder: (context, index) => Card(
          color: UmiSeaColors.blue400,
          child: Center(
            child: Text("Item $index"),
          ),
        ),
      ),
    );
  }
}

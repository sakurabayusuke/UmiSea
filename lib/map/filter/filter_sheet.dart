import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';
import 'package:umi_sea/map/filter/filter_tile.dart';

class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list = <Widget>[];
    var filterState = ref.watch(filterSheetNotifierProvider);
    var filterNotifier = ref.watch(filterSheetNotifierProvider.notifier);
    for (var filter in filterState.filters.keys) {
      list.add(FilterTile(filter: filter));
    }

    return DraggableScrollableSheet(
      minChildSize: 0,
      initialChildSize: 0,
      maxChildSize: 0.9,
      controller: filterNotifier.scrollableController,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: UmiSeaColors.gray000),
          child: Stack(
            children: [
              GridView.count(
                controller: scrollController,
                crossAxisCount: 4,
                children: list,
              ),
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  final pixel = filterNotifier.scrollableController.pixels -
                      details.delta.dy;
                  final size =
                      filterNotifier.scrollableController.pixelsToSize(pixel);
                  filterNotifier.scrollableController.jumpTo(size);
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const Flexible(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: 100,
                          height: 7,
                          decoration: BoxDecoration(
                            color: UmiSeaColors.gray300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

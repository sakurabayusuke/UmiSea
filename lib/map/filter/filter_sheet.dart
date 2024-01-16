import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/map/filter/filter_repository.dart';
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';
import 'package:umi_sea/map/filter/filter_sheet_state.dart';
import 'package:umi_sea/map/filter/filter_tile.dart';
import 'package:umi_sea/map/main_map/map_screen.dart';

final filterSheetNotifierProvider =
    StateNotifierProvider<FilterSheetNotifier, FilterSheetState>((_) {
  final filters = FilterRepository().getFilter;
  return FilterSheetNotifier(filters);
});

class FilterSheet extends ConsumerWidget {
  FilterSheet({super.key});

  final DraggableScrollableController _controller =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list = <Widget>[];
    var filterState = ref.watch(filterSheetNotifierProvider);
    var mapState = ref.watch(mapScreenNotifierProvider.notifier);
    for (var filter in filterState.filters.keys) {
      list.add(FilterTile(filter: filter));
    }

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification event) {
        if (event.extent != event.minExtent) return false;
        // 閉じる処理... アニメーションで
        mapState.removeBottomSheet();
        return false;
      },
      child: DraggableScrollableSheet(
        minChildSize: 0.08,
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        controller: _controller,
        shouldCloseOnMinExtent: true,
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
                    final pixel = _controller.pixels - details.delta.dy;
                    final size = _controller.pixelsToSize(pixel);
                    _controller.jumpTo(size);
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          height: 7,
                          decoration: BoxDecoration(
                            color: UmiSeaColors.gray300,
                            borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}

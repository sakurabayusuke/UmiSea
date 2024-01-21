import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/map/filter/filter_sheet_notifier.dart';
import 'package:umi_sea/map/filter/filter_tile.dart';
import 'package:umi_sea/map/main_map/layer/layer_notifier.dart';

class FilterSheet extends ConsumerWidget {
  const FilterSheet(DraggableScrollableController controller, {super.key})
      : _controller = controller;

  final DraggableScrollableController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = <Widget>[];
    final filterState = ref.watch(filterSheetNotifierProvider);
    final layerState = ref.watch(layerNotifierProvider);
    for (var filter in filterState.filters.keys) {
      list.add(FilterTile(filter: filter));
    }

    return DraggableScrollableSheet(
      minChildSize: 0,
      initialChildSize: 0,
      maxChildSize: 0.9,
      controller: _controller,
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
              switch (layerState) {
                AsyncLoading() => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: UmiSeaColors.loadingGray200),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                _ => const SizedBox.shrink(),
              }
            ],
          ),
        );
      },
    );
  }
}

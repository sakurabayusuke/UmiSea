import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/Map/filter/filter_sheet.dart';
import 'package:umi_sea/env/env.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart' as atom;
import 'package:umi_sea/Component/icon/icon.dart' as atom;
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/main_map/map_screen_notifier.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

final mapScreenNotifierProvider =
    StateNotifierProvider<MapScreenNotifier, MapScreenState>((_) {
  return MapScreenNotifier();
});

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mapNotifier = ref.watch(mapScreenNotifierProvider.notifier);
    var filterState = ref.watch(filterSheetNotifierProvider);

    // ここで呼ぶと止まってしまう... FutureBuilder を使ってやる方法を検討
    if (filterState[Filter.coral]!) {
      mapNotifier.putAllCorals(filterState);
    } else {
      mapNotifier.deleteAllCorals(filterState);
    }

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          MapWidget(
            resourceOptions:
                ResourceOptions(accessToken: Env.mapboxPublicAccessToken),
            cameraOptions: CameraOptions(
              center: Point(
                coordinates: Position(139.7586677640881, 35.67369269880291),
              ).toJson(),
              zoom: 14,
            ),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: mapNotifier.onMapCreated,
          ),
          Positioned(
            bottom: 160,
            right: 24,
            child: atom.IconButton(
              icon: atom.Icon.filter,
              onPressed: () async {
                await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    barrierColor: Colors.transparent,
                    builder: (context) => const FilterSheet());
              },
            ),
          ),
        ],
      ),
    );
  }
}

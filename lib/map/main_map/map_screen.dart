import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/Map/filter/filter_sheet.dart';
import 'package:umi_sea/env/env.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart' as atom;
import 'package:umi_sea/Component/icon/icon.dart' as atom;
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/coral2/coral_layer.dart';
import 'package:umi_sea/map/main_map/map_screen_notifier.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';

final mapScreenNotifierProvider =
    StateNotifierProvider<MapScreenNotifier, MapScreenState>((_) {
  return MapScreenNotifier(coralLayerCreator: CoralLayer());
});

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapNotifier = ref.watch(mapScreenNotifierProvider.notifier);
    final filterState = ref.watch(filterSheetNotifierProvider);
    final mapState = ref.watch(mapScreenNotifierProvider);

    if (mapState.initialized) {
      if (filterState[Filter.coral]!) {
        mapNotifier.addCoralLayer();
      } else {
        mapNotifier.deleteAllCorals();
      }
    }

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          MapWidget(
            resourceOptions:
                ResourceOptions(accessToken: Env.mapboxPublicAccessToken),
            key: const ValueKey("mapWidget"),
            cameraOptions: CameraOptions(
              center: Point(
                coordinates: Position(139.7586677640881, 35.67369269880291),
              ).toJson(),
              zoom: 5,
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

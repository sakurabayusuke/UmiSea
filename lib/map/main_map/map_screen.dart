import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as map;
import 'package:umi_sea/Component/buttons/button_color.dart';
import 'package:umi_sea/Map/filter/filter_sheet.dart';
import 'package:umi_sea/env/env.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart' as atom;
import 'package:umi_sea/Component/icon/icon.dart' as atom;
import 'package:umi_sea/map/filter/filter.dart';
import 'package:umi_sea/map/coral/coral_layer.dart';
import 'package:umi_sea/map/main_map/map_screen_notifier.dart';
import 'package:umi_sea/map/main_map/map_screen_state.dart';
import 'package:umi_sea/setting/setting_list_screen.dart';
import 'package:umi_sea/splash_screen.dart';

final mapScreenNotifierProvider =
    StateNotifierProvider<MapScreenNotifier, MapScreenState>((_) {
  return MapScreenNotifier(CoralLayer());
});

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapNotifier = ref.watch(mapScreenNotifierProvider.notifier);
    final filterState = ref.watch(filterSheetNotifierProvider);
    final filterNotifier = ref.watch(filterSheetNotifierProvider.notifier);
    final mapState = ref.watch(mapScreenNotifierProvider);

    if (mapState.initialized) {
      if (filterState.filters[Filter.coral]!) {
        mapNotifier.addCoralLayer();
      } else {
        mapNotifier.deleteAllCorals();
      }
    }

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          map.MapWidget(
            resourceOptions:
                map.ResourceOptions(accessToken: Env.mapboxPublicAccessToken),
            key: const ValueKey("mapWidget"),
            cameraOptions: map.CameraOptions(
              center: map.Point(
                coordinates: map.Position(139.7586677640881, 35.67369269880291),
              ).toJson(),
              zoom: 5,
            ),
            styleUri: map.MapboxStyles.MAPBOX_STREETS,
            onMapCreated: mapNotifier.onMapCreated,
          ),
          Positioned(
            bottom: 160,
            right: 24,
            child: atom.IconButton(
              icon: atom.Icon.filter,
              onPressed:
                  filterState.isAnimating ? () {} : filterNotifier.display,
            ),
          ),
          Positioned(
            top: 160,
            right: 24,
            child: atom.IconButton(
              icon: atom.Icon.settings,
              buttonColor: ButtonColor.secondary,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const SettingListScreen();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1, 0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end).chain(
                        CurveTween(
                          curve: Curves.easeIn,
                        ),
                      );
                      final animeOffset = animation.drive(tween);
                      return SlideTransition(
                          position: animeOffset, child: child);
                    },
                    transitionDuration: const Duration(
                      milliseconds: 200,
                    ),
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: !mapState.splashIsEnd,
            child: AnimatedOpacity(
              curve: Curves.easeOutBack,
              onEnd: mapNotifier.removeSplash,
              opacity: !mapState.initialized ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1500),
              child: const SplashScreen(),
            ),
          ),
          const FilterSheet(),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as map;
import 'package:umi_sea/Component/buttons/button_color.dart';
import 'package:umi_sea/Map/filter/filter_sheet.dart';
import 'package:umi_sea/ad/ad_mob.dart';
import 'package:umi_sea/env/env.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart' as atom;
import 'package:umi_sea/Component/icon/icon.dart' as atom;
import 'package:umi_sea/map/main_map/map_screen_notifier.dart';
import 'package:umi_sea/setting/setting_list_screen.dart';

class MapScreen extends ConsumerStatefulWidget {
  MapScreen({super.key});

  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: 8), (Timer timer) async {
      final loaded = await ref.read(adMobProvider.notifier).load();
      if (!loaded) return;
      await ref.read(adMobProvider.notifier).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapNotifier = ref.watch(mapScreenNotifierProvider.notifier);
    final mapState = ref.watch(mapScreenNotifierProvider);

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
            bottom: 80,
            right: 24,
            child: atom.IconButton(
              icon: atom.Icon.filter,
              onPressed: () async {
                if (mapState.bottomSheetIsAnimating) return;
                mapNotifier.activateSheetAnimation();
                await widget.sheetController.animateTo(0.45,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                mapNotifier.deactivateSheetAnimation();
              },
            ),
          ),
          Positioned(
            top: 100,
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
          FilterSheet(widget.sheetController),
        ],
      ),
    );
  }
}

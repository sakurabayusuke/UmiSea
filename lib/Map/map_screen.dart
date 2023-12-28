import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:umi_sea/env/env.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: MapWidget(
        resourceOptions:
            ResourceOptions(accessToken: Env.mapboxPublicAccessToken),
        cameraOptions: CameraOptions(
          center: Point(
            coordinates: Position(139.7586677640881, 35.67369269880291),
          ).toJson(),
          zoom: 14,
        ),
        styleUri: MapboxStyles.MAPBOX_STREETS,
      ),
    );
  }
}

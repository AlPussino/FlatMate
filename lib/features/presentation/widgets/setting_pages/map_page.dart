import 'dart:developer';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/profile_providers/map_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/setting_pages/map_widgets/map_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapboxMap? mapboxMap;
    PointAnnotationManager? pointAnnotationManager;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: FutureBuilder(
        future: context.read<MapProvider>().getLocation(),
        builder: (context, snapshot) {
          final lat = context.watch<MapProvider>().currentLatitude;
          final lng = context.watch<MapProvider>().currentLongitude;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.orangeColor,
              ),
            );
          } else {
            return Stack(
              children: [
                MapWidget(
                  onMapCreated: (controller) {
                    mapboxMap = controller;
                    mapboxMap!.location.updateSettings(
                      LocationComponentSettings(
                        enabled: true,
                        pulsingMaxRadius: 50,
                        showAccuracyRing: true,
                        accuracyRingBorderColor: 0xFFFFA500,
                        accuracyRingColor: 0xFFFFFF,
                        pulsingEnabled: true,
                        puckBearingEnabled: true,
                        pulsingColor: 0xFFFFA500,
                      ),
                    );
                    mapboxMap!.scaleBar
                        .updateSettings(ScaleBarSettings(enabled: false));
                    mapboxMap!.compass.updateSettings(CompassSettings(
                      enabled: true,
                      clickable: true,
                      marginTop: 100,
                      fadeWhenFacingNorth: false,
                    ));
                    mapboxMap!.logo
                        .updateSettings(LogoSettings(marginBottom: -100));
                    mapboxMap!.attribution.updateSettings(
                        AttributionSettings(marginBottom: -100));
                  },
                  onLongTapListener: (coordinate) {
                    log("${coordinate.y} , ${coordinate.x}");
                    mapboxMap!.annotations
                        .createPointAnnotationManager()
                        .then((value) async {
                      pointAnnotationManager = value;

                      final ByteData bytes =
                          await rootBundle.load('assets/images/location.png');
                      final Uint8List list = bytes.buffer.asUint8List();

                      await value.create(PointAnnotationOptions(
                        geometry: {
                          'type': 'Point',
                          'coordinates': [coordinate.y, coordinate.x],
                        },
                        image: list,
                      ));
                    });

                    mapBottomSheet(context, coordinate);
                  },
                  onTapListener: (coordinate) {
                    log("One Tap");
                    pointAnnotationManager!.deleteAll();
                  },
                  styleUri: MapboxStyles.MAPBOX_STREETS,
                  mapOptions: MapOptions(
                    pixelRatio: 3,
                    constrainMode: ConstrainMode.HEIGHT_ONLY,
                    optimizeForTerrain: true,
                    orientation: NorthOrientation.UPWARDS,
                    viewportMode: ViewportMode.DEFAULT,
                  ),
                  key: ValueKey("mapWidget"),
                  cameraOptions: CameraOptions(
                      center: LatLng(lat, lng).toJson(), zoom: 13),
                  resourceOptions: ResourceOptions(
                      tileStoreUsageMode: TileStoreUsageMode.READ_AND_UPDATE,
                      accessToken:
                          'sk.eyJ1IjoiZmxhdGVtYXRlIiwiYSI6ImNsbzJ0N2RjZDA1NG8ycnJ5NW0wM3N5cmcifQ.ZtCblEk_kNe4S0BWJ7rAPw'),
                  textureView: true,
                ),
                Positioned(
                  right: 6,
                  top: 100,
                  child: InkWell(
                    onTap: () {
                      context.read<MapProvider>().isStreetStyle
                          ? mapboxMap!.loadStyleURI(MapboxStyles.SATELLITE)
                          : mapboxMap!
                              .loadStyleURI(MapboxStyles.MAPBOX_STREETS);
                      context.read<MapProvider>().changeMapStyle();
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColor.blackColor,
                      foregroundColor: AppColor.orangeColor,
                      child: Icon(Icons.change_circle),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: Offstage(
        offstage: false,
        child: FloatingActionButton(
          backgroundColor: AppColor.whiteColor,
          foregroundColor: AppColor.orangeColor,
          onPressed: () async {
            await context.read<MapProvider>().getLocation();

            mapboxMap!.flyTo(
                CameraOptions(
                    center: LatLng(context.read<MapProvider>().currentLatitude,
                            context.read<MapProvider>().currentLongitude)
                        .toJson(),
                    anchor: ScreenCoordinate(x: 0, y: 0),
                    zoom: 19,
                    bearing: 0,
                    pitch: 30),
                MapAnimationOptions(duration: 2000, startDelay: 0));
          },
          child: Icon(Icons.location_on),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapas/blocs/map/map_bloc.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polyline;
  final Set<Marker> markers;
  final double zoom;

  const MapView({
    Key? key,
    required this.initialLocation,
    required this.polyline,
    required this.markers,
    required this.zoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("******$zoom******");
    final bloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCamaraPosition = CameraPosition(
      target: initialLocation,
      zoom: zoom,
    );
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Listener(
          onPointerMove: (event) {
            bloc.add(OnStopFollowingUser());
          },
          child: GoogleMap(
            initialCameraPosition: initialCamaraPosition,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            polylines: polyline,
            markers: markers,
            onCameraMove: (position) {
              bloc.mapCenter = position.target;
            },
            onMapCreated: (controller) {
              bloc.add(OnMapInitializeEvent(controller));
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas/widgets/btn_toggle_user_route.dart';

import '../blocs/location/location_bloc.dart';
import '../blocs/map/map_bloc.dart';
import '../views/map_view.dart';
import '../widgets/btn_follow_user.dart';
import '../widgets/btn_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<LocationBloc>(context);
    bloc.starFollowingUser();
    super.initState();
  }

  @override
  void dispose() {
    bloc.stopFlollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LocationBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, stateLocation) {
            if (stateLocation.lastKnowLocation == null) {
              return const Center(child: Text("Espere por favor"));
            }

            return BlocBuilder<MapBloc, MapState>(
              builder: (contextMap, stateMap) {
                Map<String, Polyline> polylines = Map.from(stateMap.polylines);
                if (!stateMap.showMyRoute) {
                  polylines.removeWhere((key, value) => key == 'myRoute');
                }

                return Stack(
                  children: [
                    MapView(
                      initialLocation: stateLocation.lastKnowLocation!,
                      polyline: polylines.values.toSet(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnTogleUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}

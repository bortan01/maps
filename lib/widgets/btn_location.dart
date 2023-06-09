import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';
import '../blocs/map/map_bloc.dart';
import '../ui/custom_snack_bar.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.black,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            final userLocation = locationBloc.state.lastKnowLocation;

            if (userLocation == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: 'No hay ubicación',
                  onOk: () {},
                ),
              );
              return;
            }
            mapBloc.moveCamera(userLocation);
          },
          icon: const Icon(
            Icons.my_location_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

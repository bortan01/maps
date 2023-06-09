import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/map/map_bloc.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.black,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            mapBloc.add(OnStarFollowingUser());
          },
          icon: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return Icon(
                state.isFollowingUser ? Icons.hail_rounded : Icons.directions_run_rounded,
                color: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/map/map_bloc.dart';

class BtnTogleUserRoute extends StatelessWidget {
  const BtnTogleUserRoute({super.key});

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
            print("Toggle");
            mapBloc.add(OnTogleUserRoute());
          },
          icon: const Icon(
            Icons.more_horiz_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

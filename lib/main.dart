import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas/blocs/gps/gps_bloc.dart';
import 'package:mapas/blocs/location/location_bloc.dart';
import 'package:mapas/blocs/map/map_bloc.dart';
import 'package:mapas/screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GpsBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingScreen(),
      ),
    );
  }
}

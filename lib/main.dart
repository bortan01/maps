import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas/screens/pago_completo_screen.dart';

import 'blocs/gps/gps_bloc.dart';
import 'blocs/location/location_bloc.dart';
import 'blocs/map/map_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GpsBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color(0xff21232A),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff284879),
          ),
        ),
        title: 'Material App',
        home: const HomeScreen(),
      ),
    );
  }
}

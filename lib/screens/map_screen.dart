import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: const Center(
        child: Text('Map'),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas/blocs/location/location_bloc.dart';
import 'package:mapas/blocs/map/map_bloc.dart';
import 'package:mapas/helpers/show_loadin_messsages.dart';

import '../blocs/search/search_bloc.dart';

class ManualMarket extends StatelessWidget {
  const ManualMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.displayManualMarker) {
          return const _ManualMarketBody();
        }
        return const SizedBox();
      },
    );
  }
}

class _ManualMarketBody extends StatelessWidget {
  const _ManualMarketBody();

  @override
  Widget build(BuildContext context) {
    final blocSearc = BlocProvider.of<SearchBloc>(context);
    final blocLocation = BlocProvider.of<LocationBloc>(context);
    final blocMap = BlocProvider.of<MapBloc>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          const Positioned(
            top: 10,
            left: 10,
            child: _BtnBack(),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: BounceInDown(
                from: 100,
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                color: Colors.black,
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                child: const Text(
                  'Confirmar Destino',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final start = blocLocation.state.lastKnowLocation;
                  if (start == null) return;
                  final end = blocMap.mapCenter;
                  if (end == null) return;
                  await showLoadingMessage(context);

                  final destination = await blocSearc.getCoorsStartToEnd(start, end);
                  await blocMap.drawRoutePolilyne(destination);
                  blocSearc.add(const OnActivateManualMarkerEvent(isActive: false));

                  navigator.pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    return FadeInLeft(
      duration: const Duration(milliseconds: 200),
      child: SafeArea(
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              bloc.add(const OnActivateManualMarkerEvent(isActive: false));
            },
            icon: Icon(
              Icons.adaptive.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

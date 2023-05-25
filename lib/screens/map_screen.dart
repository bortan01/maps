import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';
import '../views/map_view.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: SafeArea(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state.lastKnowLocation == null) {
              return const Center(child: Text("Espere por favor"));
            }

            return Stack(
              children: [
                MapView(
                  initialLocation: state.lastKnowLocation!,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}



// /Users/boris/.rvm/gems/ruby-3.1.3/bin:
// /Users/boris/.rvm/gems/ruby-3.1.3@global/bin:
// /Users/boris/.rvm/rubies/ruby-3.1.3/bin:
// /Users/boris/fvm/default/bin:
// /opt/homebrew/bin:
// /usr/local/bin:
// /usr/local/bin:
// /System/Cryptexes/App/usr/bin:
// /usr/bin:
// /bin:
// /usr/sbin:
// /sbin:
// /Library/Apple/usr/bin:
// /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:
// /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:
// /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:
// /Users/boris/.rvm/bin
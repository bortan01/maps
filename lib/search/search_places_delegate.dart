import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas/blocs/location/location_bloc.dart';
import 'package:mapas/blocs/search/search_bloc.dart';
import 'package:mapas/models/search_result.dart';

import '../models/places_response.dart';

class SearchPlacesDelegate extends SearchDelegate<SearchResult> {
  SearchPlacesDelegate()
      : super(
          searchFieldLabel: 'Buscar...',
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, SearchResult(cancel: true, description: '', manual: true, name: ''));
      },
      icon: Icon(Icons.adaptive.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    bloc.getPlacesByQuery(locationBloc.state.lastKnowLocation!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
          itemCount: places.length,
          itemBuilder: (BuildContext context, int index) {
            final Feature place = places[index];
            return ListTile(
              title: Text(place.text ?? 'NO_NAME'),
              subtitle: Text(place.placeName ?? 'NO_PLACENAME'),
              leading: const Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                bloc.add(AddToHistoryEvent(place: places[index]));
                close(
                  context,
                  SearchResult(
                    cancel: false,
                    manual: false,
                    position: LatLng(
                      place.center[1],
                      place.center[0],
                    ),
                    description: place.placeName ?? '',
                    name: place.text ?? '',
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    final history = bloc.state.history;
    return ListView(
      children: [
           ListTile(
          onTap: () {
            close(context, SearchResult(cancel: false, manual: true, description: '', name: ''));
          },
          title: const Text(
            'Colocar la ubicación manualmente',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
        ),
        ...history.map(
          (e) => ListTile(
            onTap: () {
              bloc.add(AddToHistoryEvent(place: e));
              close(
                context,
                SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(
                    e.center[1],
                    e.center[0],
                  ),
                  description: e.placeName ?? '',
                  name: e.text ?? '',
                ),
              );
            },
            title: Text(
              e.text ?? 'NO_TEXT',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            leading: const Icon(
              Icons.location_on_outlined,
              color: Colors.black,
            ),
          ),
        ),
     
      ],
    );
  }
}

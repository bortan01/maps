import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas/blocs/location/location_bloc.dart';
import 'package:mapas/blocs/search/search_bloc.dart';
import 'package:mapas/models/search_result.dart';

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
        close(context, SearchResult(cancel: true));
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
        return IconButton(
          onPressed: () {
            close(context, SearchResult(cancel: true));
          },
          icon: Icon(Icons.adaptive.arrow_back),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {
            close(context, SearchResult(cancel: false, manual: true));
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
      ],
    );
  }
}

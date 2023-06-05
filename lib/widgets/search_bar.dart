import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas/blocs/search/search_bloc.dart';

import '../search/search_places_delegate.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return state.displayManualMarker ? const SizedBox() : const _SearchBarBody();
        },
      ),
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    return FadeInDown(
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(context: context, delegate: SearchPlacesDelegate());
            if (result == null) return;
            bloc.add(OnActivateManualMarkerEvent(isActive: result.manual));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100), boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 10),
              ),
            ]),
            child: const Text(
              "Dónde Quieres ir?",
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

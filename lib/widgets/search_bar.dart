import 'package:flutter/material.dart';

import '../search/search_places_delegate.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () async {
          final result = await showSearch(context: context, delegate: SearchPlacesDelegate());
          if (result == null) return;
          print(result);
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
    );
  }
}

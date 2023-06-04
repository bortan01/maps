class SearchResult {
  final bool cancel;
  final bool manual;

  SearchResult({required this.cancel, this.manual = false});


  SearchResult copyWith({
    bool? cancel,
    bool? manual,
  }) {
    return SearchResult(
      cancel: cancel ?? this.cancel,
      manual: manual ?? this.manual,
    );
  }

  @override
  String toString() => 'SearchResult(cancel: $cancel, manual: $manual)';
  }

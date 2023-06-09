// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromMap(jsonString);

import 'dart:convert';

class PlacesResponse {
    final String type;
    // final List<String> query;
    final List<Feature> features;
    final String attribution;

    PlacesResponse({
        required this.type,
        // required this.query,
        required this.features,
        required this.attribution,
    });

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        // query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        // "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    final String? id;
    final String? type;
    final List<String> placeType;
    final num? relevance;
    final Properties properties;
    final String? textEs;
    final String? languageEs;
    final String? placeNameEs;
    final String? text;
    final String? language;
    final String? placeName;
    final String? matchingText;
    final String? matchingPlaceName;
    final List<double> center;
    final Geometry geometry;
    final List<ContextG> context;

    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.relevance,
        required this.properties,
        required this.textEs,
        required this.languageEs,
        required this.placeNameEs,
        required this.text,
        required this.language,
        required this.placeName,
        required this.matchingText,
        required this.matchingPlaceName,
        required this.center,
        required this.geometry,
        required this.context,
    });

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        languageEs: json["language_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"],
        placeName: json["place_name"],
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: List<ContextG>.from(json["context"].map((x) => ContextG.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toMap(),
        "text_es": textEs,
        "language_es": languageEs,
        "place_name_es": placeNameEs,
        "text": text,
        "language": language,
        "place_name": placeName,
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
    };

  @override
  String toString() {
    return 'Feature(id: $id, type: $type, placeType: $placeType, relevance: $relevance, properties: $properties, textEs: $textEs, languageEs: $languageEs, placeNameEs: $placeNameEs, text: $text, language: $language, placeName: $placeName, matchingText: $matchingText, matchingPlaceName: $matchingPlaceName, center: $center, geometry: $geometry, context: $context)';
  }
}

class ContextG {
    final String? id;
    final String? mapboxId;
    final String? textEs;
    final String? text;
    final String? wikidata;
    final String? languageEs;
    final String? language;
    final String? shortCode;

    ContextG({
        required this.id,
        required this.mapboxId,
        required this.textEs,
        required this.text,
        required this.wikidata,
        required this.languageEs,
        required this.language,
        required this.shortCode,
    });

    factory ContextG.fromJson(String str) => ContextG.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ContextG.fromMap(Map<String, dynamic> json) => ContextG(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        languageEs: json["language_es"],
        language: json["language"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "language_es": languageEs,
        "language": language,
        "short_code": shortCode,
    };
}

class Geometry {
    final List<double> coordinates;
    final String type;

    Geometry({
        required this.coordinates,
        required this.type,
    });

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Properties {
    final String? address;
    final String? foursquare;
    final String? wikidata;
    final bool? landmark;
    final String? category;

    Properties({
        required this.address,
        required this.foursquare,
        required this.wikidata,
        required this.landmark,
        required this.category,
    });

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        address: json["address"],
        foursquare: json["foursquare"],
        wikidata: json["wikidata"],
        landmark: json["landmark"],
        category: json["category"],
    );

    Map<String, dynamic> toMap() => {
        "address": address,
        "foursquare": foursquare,
        "wikidata": wikidata,
        "landmark": landmark,
        "category": category,
    };
}

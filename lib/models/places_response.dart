// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromMap(jsonString);

import 'dart:convert';

class PlacesResponse {
    final String type;
    final List<String> query;
    final List<Feature> features;
    final String attribution;

    PlacesResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    final String id;
    final String type;
    final List<String> placeType;
    final Properties properties;
    final String textEs;
    final String? languageEs;
    final String placeNameEs;
    final String? text;
    final String? language;
    final String placeName;
    final String? matchingText;
    final String matchingPlaceName;
    final List<double> center;
    final Geometry geometry;

    Feature({
        required this.id,
        required this.type,
        required this.placeType,
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
    });

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
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
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
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
    final String address;
    final String foursquare;
    final String wikidata;
    final bool landmark;
    final String category;

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

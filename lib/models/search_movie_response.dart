import 'dart:convert';

import 'package:presentacion_t5/models/movie.dart';

class SearchMovieResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  SearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMovieResponse.fromRawJson(String str) =>
      SearchMovieResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      SearchMovieResponse(
        page: json["page"],
        results: List<Movie>.from(
          json["results"].map((x) => Movie.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

enum OriginalLanguage { EN, MS, XX }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ms": OriginalLanguage.MS,
  "xx": OriginalLanguage.XX,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

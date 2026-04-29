import 'dart:convert';

class TopRatedResponse {
  int page;
  List<TopRatedMovie> results;
  int totalPages;
  int totalResults;

  TopRatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TopRatedResponse.fromRawJson(String str) =>
      TopRatedResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopRatedResponse.fromJson(Map<String, dynamic> json) =>
      TopRatedResponse(
        page: json["page"],
        results: List<TopRatedMovie>.from(
          json["results"].map((x) => TopRatedMovie.fromJson(x)),
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

class TopRatedMovie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String title;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  bool softcore;
  bool video;
  double voteAverage;
  int voteCount;

  TopRatedMovie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.softcore,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  get fullPosterImg {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  factory TopRatedMovie.fromRawJson(String str) =>
      TopRatedMovie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopRatedMovie.fromJson(Map<String, dynamic> json) => TopRatedMovie(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    title: json["title"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: DateTime.parse(json["release_date"]),
    softcore: json["softcore"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "title": title,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "softcore": softcore,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

import 'dart:convert';

class Movie {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  String? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  bool? softcore;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Movie({
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

  get fullbackdropPath {
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"],
    backdropPath: json["backdrop_path"] ?? '',
    genreIds: List<int>.from((json["genre_ids"] ?? []).map((x) => x)),
    id: json["id"].toString(),
    title: json["title"],
    originalLanguage: json["original_language"] ?? '',
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"] ?? '',
    releaseDate: json["release_date"] != null && json["release_date"] != ""
        ? DateTime.parse(json["release_date"])
        : DateTime.now(),
    softcore: json["softcore"] ?? false,
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "title": title,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date":
        "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
    "softcore": softcore,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

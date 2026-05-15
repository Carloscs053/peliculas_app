import 'dart:convert';
import 'package:presentacion_t5/models/movie.dart'; // Asegúrate de que la ruta es correcta

class ActorMoviesResponse {
  final List<Movie> cast;

  ActorMoviesResponse({required this.cast});

  factory ActorMoviesResponse.fromRawJson(String str) =>
      ActorMoviesResponse.fromJson(json.decode(str));

  factory ActorMoviesResponse.fromJson(Map<String, dynamic> json) =>
      ActorMoviesResponse(
        // Recorremos el JSON y reutilizamos tu modelo Movie
        cast: List<Movie>.from(json["cast"].map((x) => Movie.fromJson(x))),
      );
}

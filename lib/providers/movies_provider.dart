import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presentacion_t5/models/cast_response.dart';
import 'package:presentacion_t5/models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = 'b34ddaf4e39fbe9a90cc4ccbe6c80b34';
  final String _language = 'es-ES';
  int _popularPage = 0;

  // Para guardar y consultar las pelis en cines
  List<Movie> enCines = [];
  List<Movie> populares = [];
  List<Movie> mejorValoradas = [];
  List<Movie> proximamente = [];
  Map<String, List<Cast>> movieCast = {};

  MoviesProvider() {
    getEnCinesMovie();
    getPopularMovies();
    getTopRatedMovies();
    getProxiamente();
  }

  Future<List<Movie>> _getJsonData(String endpoint, [int page = 1]) async {
    List<Movie> movies = [];
    var url = Uri.https(_urlBase, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(response.body);
      if (decodedData['results'] != null) {
        movies = List<Movie>.from(
          decodedData['results'].map((x) => Movie.fromJson(x)),
        );
      }
    } else {
      throw Exception('Failed to load movies');
    }

    return movies.isEmpty ? [] : movies;
  }

  getEnCinesMovie() async {
    enCines = await _getJsonData('/3/movie/now_playing');

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    populares = await _getJsonData('/3/movie/popular', _popularPage);

    notifyListeners();
  }

  getTopRatedMovies() async {
    _popularPage++;
    mejorValoradas = await _getJsonData('/3/movie/top_rated', _popularPage);

    notifyListeners();
  }

  getProxiamente() async {
    _popularPage++;
    proximamente = await _getJsonData('/3/movie/upcoming', _popularPage);

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(String movieId) async {
    if (movieCast.containsKey(movieId)) {
      return movieCast[movieId]!;
    }

    var url = Uri.https(_urlBase, '/3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final castResponse = CastResponse.fromRawJson(response.body);

      movieCast[movieId] = castResponse.cast;

      return castResponse.cast;
    } else {
      throw Exception('Failed to load cast');
    }
  }
}

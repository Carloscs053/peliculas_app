import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:presentacion_t5/models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = 'b34ddaf4e39fbe9a90cc4ccbe6c80b34';
  final String _language = 'es-ES';

  // Para guardar y consultar las pelis en cines
  List<Movie> enCines = [];
  List<Movie> populares = [];
  List<Movie> mejorValoradas = [];
  List<Movie> proximamente = [];

  MoviesProvider() {
    getEnCinesMovie();
    getPopularMovies();
    getTopRatedMovies();
    getProxiamente();
  }

  getEnCinesMovie() async {
    Map<String, dynamic> parameters = {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    };
    Uri url = Uri.https(_urlBase, '/3/movie/now_playing', parameters);

    Response response = await get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    if (decodedData['results'] != null) {
      enCines = List<Movie>.from(
        decodedData['results'].map((x) => Movie.fromJson(x)),
      );
    }

    notifyListeners();
  }

  getPopularMovies() async {
    Map<String, dynamic> parameters = {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    };

    Uri url = Uri.https(_urlBase, '/3/movie/popular', parameters);

    Response response = await get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    if (decodedData['results'] != null) {
      populares = List<Movie>.from(
        decodedData['results'].map((x) => Movie.fromJson(x)),
      );
    }

    notifyListeners();
  }

  getTopRatedMovies() async {
    Map<String, dynamic> parameters = {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    };

    Uri url = Uri.https(_urlBase, '/3/movie/top_rated', parameters);

    Response response = await get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    if (decodedData['results'] != null) {
      mejorValoradas = List<Movie>.from(
        decodedData['results'].map((x) => Movie.fromJson(x)),
      );
    }

    notifyListeners();
  }

  getProxiamente() async {
    Map<String, dynamic> parameters = {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    };

    Uri url = Uri.https(_urlBase, '3/movie/upcoming', parameters);

    Response response = await get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    if (decodedData['results'] != null) {
      proximamente = List<Movie>.from(
        decodedData['results'].map((x) => Movie.fromJson(x)),
      );
    }

    notifyListeners();
  }
}

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

  MoviesProvider() {
    getEnCinesMovie();
    getPopularMovies();
    getTopRatedMovies();
  }

  getEnCinesMovie() async {
    Map<String, dynamic> parameters = {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    };
    Uri url = Uri.https(_urlBase, '/3/movie/now_playing', parameters);

    Response response = await get(url);

    final nowPlayingResponse = Movie.fromRawJson(response.body);

    enCines = nowPlayingResponse;

    print(enCines[0].title);
    // Meto la respuesta en una variable mapa

    //final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

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

    final popularResponse = PopularResponse.fromRawJson(response.body);

    populares = popularResponse.results;

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

    final topRatedResponse = TopRatedResponse.fromRawJson(response.body);

    mejorValoradas = topRatedResponse.results;

    notifyListeners();
  }
}

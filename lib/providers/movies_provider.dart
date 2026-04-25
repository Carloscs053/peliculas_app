import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:presentacion_t5/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = 'b34ddaf4e39fbe9a90cc4ccbe6c80b34';
  final String _language = 'es-ES';

  // Para guardar y consultar las pelis en cines
  List<Movie> enCines = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');
    getEnCinesMovie();
  }

  getEnCinesMovie() async {
    Map<String, dynamic> parameters = {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    };
    Uri url = Uri.https(_urlBase, '/3/movie/now_playing', parameters);

    Response response = await get(url);

    // Meto la respuesta en una variable mapa

    final Map<String, dynamic> pelisEnCine = jsonDecode(response.body);

    enCines = NowPlayingResponse.fromJson(pelisEnCine).movies;

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentacion_t5/models/movie.dart';

class MovieSlider extends StatelessWidget {
  String? titulo;
  List<Movie> peliculas = [];
  MovieSlider({super.key, this.titulo, required this.peliculas});

  @override
  Widget build(BuildContext context) {
    if (peliculas.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 250,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              titulo ?? 'Populares',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: peliculas.length,
              itemBuilder: (_, int index) =>
                  _MoviePoster(movie: peliculas[index]),
            ),
          ),
        ],
      ),
    );
  }
}

// Una clase aparte, para separar código y hacer más fácil la lectura y modificaciones
class _MoviePoster extends StatelessWidget {
  Movie? movie;

  _MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      //color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.push('/detalle/${movie!.id}'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/loading.png'),
                  image: NetworkImage(movie?.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(movie?.title ?? ''),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentacion_t5/models/movie.dart';

class MovieSlider extends StatefulWidget {
  String? titulo;
  List<Movie> peliculas = [];
  final Function
  nextPage; // Función que disparo cuando llegue al final del scroll
  MovieSlider({
    super.key,
    this.titulo,
    required this.peliculas,
    required this.nextPage,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent + 50) {
        print('Obtener siguiente página');
        widget.nextPage(); // Disparo la función que me pasan
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.peliculas.isEmpty) {
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
              widget.titulo ?? 'Populares',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.peliculas.length,
              itemBuilder: (_, int index) {
                if (index == widget.peliculas.length - 3) {
                  widget.nextPage();
                }
                final Movie pelicula = widget.peliculas[index];
                return _MoviePoster(movie: pelicula);
              },
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
              onTap: () {
                context.push('/detalle', extra: movie);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/loading.gif'),
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

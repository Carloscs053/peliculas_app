import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:presentacion_t5/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies; // Lista de pelis que recibiré
  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    // Obtengo el tamaño de la pantalla de mi dispositivo
    // lo hago leyendo el context

    final size = MediaQuery.of(context).size;

    final double cardWidth = size.width > 600 ? 300 : size.width * 0.75;
    final double cardHeight = size.width > 600 ? 450 : size.height * 0.6;
    final double swiperHeight = size.width > 600 ? 500 : size.height * 0.6;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: swiperHeight,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: swiperHeight, // La mitad de la altura. Da juego
      //color: Colors.red,
      child: Swiper(
        itemCount: movies.length, // Tantas tarjetas como pelis tenga la lista
        layout: SwiperLayout.STACK, // Layout, Jugar con esto
        itemWidth: cardWidth,
        itemHeight: cardHeight, // Se puede quitar, lo cogería del padre
        // Un builder siempre construye algo, en este caso devolvemos un
        // FadeImage por cada elemento. El context se puede sustituir por _
        itemBuilder: (BuildContext context, int index) {
          final Movie movie = movies[index];
          movie.heroId = 'swiper-${movie.id}';
          return GestureDetector(
            onTap: () {
              context.push('/detalle', extra: movie);
            },
            child: Hero(
              tag: movie.heroId!, // id único para que sepa moverse el Hero
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

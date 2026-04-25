import 'package:flutter/material.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:presentacion_t5/widgets/movie_slider.dart';
import 'package:presentacion_t5/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Declaramos el acceso al provider para acceder a las películas en cines
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20),
            // En cines
            // Ahora el swiper recibirá una lista de películas
            CardSwiper(movies: moviesProvider.enCines),

            SizedBox(height: 10),

            // Populares
            MovieSlider(),

            SizedBox(height: 10),

            // Próximamente
            MovieSlider(titulo: 'Próximamente'),

            SizedBox(height: 10),

            // Tus colecciones
            MovieSlider(titulo: 'Tu lista'),

            SizedBox(height: 10),

            // Cine champagne
            MovieSlider(titulo: 'Cine Champagne'),

            SizedBox(height: 10),

            // Serie B
            MovieSlider(titulo: 'Serie B'),

            // TODO Lista populares
          ],
        ),
      ),
    );
  }
}

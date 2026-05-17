import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:presentacion_t5/pages/favorites_screen.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:presentacion_t5/search/search_delegate.dart';
import 'package:presentacion_t5/widgets/movie_slider.dart';
import 'package:presentacion_t5/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Declaramos el acceso al provider para acceder a las películas en cines
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        centerTitle: true,
        title: Text(
          _selectedIndex == 0 ? 'Películas en cines' : "Mis Favoritas",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  onPressed: () => showSearch(
                    context: context,
                    delegate: MovieSearchDelegate(),
                  ),
                  icon: Icon(Icons.search_outlined),
                ),
              ]
            : null,
      ),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height:
                        MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        20,
                  ),
                  // En cines
                  // Ahora el swiper recibirá una lista de películas
                  CardSwiper(movies: moviesProvider.enCines),

                  SizedBox(height: 10),

                  // Populares
                  MovieSlider(
                    peliculas: moviesProvider.populares,
                    nextPage: () => moviesProvider.getPopularMovies(),
                  ),

                  SizedBox(height: 10),

                  MovieSlider(
                    peliculas: moviesProvider.mejorValoradas,
                    titulo: 'Mejor valoradas',
                    nextPage: () => moviesProvider.getTopRatedMovies(),
                  ),

                  SizedBox(height: 10),

                  MovieSlider(
                    peliculas: moviesProvider.proximamente,
                    titulo: "Próximamente",
                    nextPage: () => moviesProvider.getProxiamente(),
                  ),
                ],
              ),
            )
          : const FavoritesScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: 'Cartelera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favoritas',
          ),
        ],
      ),
    );
  }
}

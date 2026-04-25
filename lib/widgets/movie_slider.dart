import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieSlider extends StatelessWidget {
  String? titulo;

  MovieSlider({super.key, this.titulo});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              itemCount: 20,
              itemBuilder: (_, int index) => _MoviePoster(pos: index),
            ),
          ),
        ],
      ),
    );
  }
}

// Una clase aparte, para separar código y hacer más fácil la lectura y modificaciones
class _MoviePoster extends StatelessWidget {
  int? pos;

  _MoviePoster({this.pos});

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
              onTap: () => context.push('/detalle/movie_id'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/loading.png'),
                  image: NetworkImage('https://placehold.co/300x400.png'),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text('Peli' + (pos! + 1).toString()),
        ],
      ),
    );
  }
}

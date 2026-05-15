import 'package:flutter/material.dart';
import 'package:presentacion_t5/models/cast_response.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final String? movieId;
  const CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId!),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 210,
            child: const CircularProgressIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 210,
          child: ListView.builder(
            itemBuilder: (_, int index) => _CastCard(actor: cast[index]),
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
    // return SizedBox(
    //   width: double.infinity,
    //   height: 180,
    //   color: Colors.red,
    //   child: ListView.builder(
    //     itemCount: 10,
    //     itemBuilder: (_, int index) => _CastCard(),
    //     scrollDirection: Axis.horizontal,
    //   ),
    // );
  }
}

class _CastCard extends StatelessWidget {
  final Cast? actor;
  const _CastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      //color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/loading.gif'),
              image: NetworkImage(actor!.fullPosterPath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            actor!.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

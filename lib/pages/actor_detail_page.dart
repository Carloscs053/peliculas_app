import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentacion_t5/models/actor_detail_response.dart';
import 'package:presentacion_t5/models/cast_response.dart';
import 'package:presentacion_t5/models/movie.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class ActorDetailScreen extends StatelessWidget {
  final Cast? actor;
  const ActorDetailScreen({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _ActorAppBar(actor: actor),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              _ActorInfo(actor: actor),
              const SizedBox(height: 20),
              _ActorBiography(actorId: actor?.id),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ActorBiography extends StatelessWidget {
  final int? actorId;
  const _ActorBiography({required this.actorId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getActorBiography(actorId!),
      builder: (context, AsyncSnapshot<ActorDetailsResponse> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final actorInfo = snapshot.data!;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Biografía',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                actorInfo.biography ?? 'No hay biografía disponible',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              actorInfo.placeOfBirth != null
                  ? _PersonalDataRow(
                      icon: Icons.location_on_outlined,
                      label: 'Lugar de nacimiento',
                      value: actorInfo.placeOfBirth ?? 'Desconocido',
                    )
                  : SizedBox(),
              actorInfo.birthday != null
                  ? _PersonalDataRow(
                      icon: Icons.cake_outlined,
                      label: 'Fecha de nacimiento',
                      value: actorInfo.birthday!,
                    )
                  : SizedBox(),
              actorInfo.deathday != null
                  ? _PersonalDataRow(
                      icon: Icons.event_busy_outlined,
                      label: 'Fallecimiento',
                      value: actorInfo.deathday!,
                    )
                  : SizedBox(),
              const SizedBox(height: 20),
              _ActorMovies(actorId: actorId),
            ],
          ),
        );
      },
    );
  }
}

class _ActorMovies extends StatelessWidget {
  final int? actorId;
  const _ActorMovies({required this.actorId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getActorMovies(actorId!),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final List<Movie> movies = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Conocido por',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, int index) {
                  final movie = movies[index];
                  movie.heroId = 'actor-movie-${movie.id}';
                  return Container(
                    width: 110,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.push('/detalle', extra: movie);
                          },
                          child: Hero(
                            tag: movie.heroId!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                placeholder: const AssetImage(
                                  'assets/images/loading.gif',
                                ),
                                image: NetworkImage(movie.fullPosterImg),
                                height: 160,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          movie.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PersonalDataRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _PersonalDataRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 20),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class _ActorInfo extends StatelessWidget {
  final Cast? actor;
  const _ActorInfo({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información del actor',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.movie_filter_outlined, color: Colors.indigo),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Interpretó a: ${actor!.character ?? 'Desconocido'}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.star_border, color: Colors.indigo),
              const SizedBox(width: 10),
              Text(
                'Popularidad: ${actor!.popularity.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActorAppBar extends StatelessWidget {
  final Cast? actor;
  const _ActorAppBar({required this.actor});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black26,
          width: double.infinity,
          child: Text(
            actor!.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        background: Hero(
          tag: 'actor-${actor!.id}',
          child: SizedBox.expand(
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/loading.gif'),
              image: NetworkImage(actor!.fullPosterPath),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
}

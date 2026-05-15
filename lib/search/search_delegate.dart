import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentacion_t5/models/movie.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    if (query.isEmpty) {
      return Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 100,
        ),
      );
    } else {
      return FutureBuilder(
        future: moviesProvider.searchMovies(query),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, int index) {
              return _SuggestionItem(movie: snapshot.data![index]);
            },
          );
        },
      );
    }
  }
}

class _SuggestionItem extends StatelessWidget {
  final Movie movie;
  const _SuggestionItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('assets/images/loading.gif'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title!),
      subtitle: Text(movie.originalTitle!),
      trailing: Text(movie.voteAverage!.toStringAsFixed(2)),
      onTap: () {
        context.push('/detalle', extra: movie);
      },
    );
  }
}

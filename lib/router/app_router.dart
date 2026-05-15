import 'package:go_router/go_router.dart';
import 'package:presentacion_t5/models/cast_response.dart';
import 'package:presentacion_t5/models/movie.dart';
import 'package:presentacion_t5/pages/actor_detail_page.dart';
import 'package:presentacion_t5/pages/detail_page.dart';
import 'package:presentacion_t5/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/detalle',
      builder: (context, state) {
        final movie = state.extra as Movie;

        return DetailScreen(movie: movie);
      },
    ),
    GoRoute(
      path: '/actor',
      builder: (context, state) {
        final actor = state.extra as Cast;
        return ActorDetailScreen(actor: actor);
      },
    ),
  ],
);

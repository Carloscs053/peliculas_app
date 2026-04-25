import 'package:go_router/go_router.dart';
import 'package:presentacion_t5/pages/detail.page.dart';
import 'package:presentacion_t5/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/detalle/:movie_id',
      builder: (context, state) {
        final String? id = state.pathParameters['id'];

        return DetailScreen(movieId: id);
      },
    ),
  ],
);

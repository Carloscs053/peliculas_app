import 'package:flutter/material.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:presentacion_t5/router/app_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      // Para escuchar varios provider
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(),
          lazy: false, // Para que la creación del provider no sea perezosa
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.indigo),
      ),
      routerConfig: appRouter,
    );
  }
}

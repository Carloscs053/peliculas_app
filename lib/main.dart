import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:presentacion_t5/router/app_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  usePathUrlStrategy();
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
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: const Color(0xFF15151D),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF15151D),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.indigoAccent,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1C1C26),
          selectedIconTheme: IconThemeData(color: Colors.indigoAccent),
          unselectedIconTheme: IconThemeData(color: Colors.white54),
          elevation: 10,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
      ),
      routerConfig: appRouter,
    );
  }
}

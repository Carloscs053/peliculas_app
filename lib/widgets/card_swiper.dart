import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtengo el tamaño de la pantalla de mi dispositivo
    // lo hago leyendo el context

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5, // La mitad de la altura. Da juego
      //color: Colors.red,
      child: Swiper(
        itemCount: 10, // Número de elementos
        layout: SwiperLayout.STACK, // Layout, Jugar con esto
        itemWidth: size.width * 0.75,
        itemHeight: size.height * 0.5, // Se puede quitar, lo cogería del padre
        // Un builder siempre construye algo, en este caso devolvemos un
        // FadeImage por cada elemento. El context se puede sustituir por _
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => context.push('/detalle/movie_id'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/loading.gif'),
                image: NetworkImage('https://placehold.co/300x400.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

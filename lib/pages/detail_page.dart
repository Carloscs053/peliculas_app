import 'package:flutter/material.dart';
import 'package:presentacion_t5/widgets/casting_cards.dart';

class DetailScreen extends StatelessWidget {
  final String? movieId;
  const DetailScreen({super.key, this.movieId});

  @override
  Widget build(BuildContext context) {
    if (movieId == null) movieId == 'no-movie';
    return Scaffold(
      // Parecido al SingleChildScrollView pero lleva Slivers,
      // que son Widgets con animaciones chulas cuando hacemos Scroll
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            // Voy a meter un Slivers que es una lista de widgets normales
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              CastingCards(),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ex tellus, faucibus sit amet ipsum ut, porta laoreet erat. In pellentesque iaculis dolor, nec eleifend elit feugiat vel. Fusce eu vestibulum lacus, in congue massa. Sed mattis hendrerit leo a mollis. In mollis magna non cursus malesuada. Proin dignissim scelerisque nulla, eu tristique orci eleifend sit amet. Phasellus sagittis, risus ultricies sodales posuere, turpis lorem ultrices tellus, vitae sodales arcu arcu dapibus enim. Vestibulum consectetur massa ipsum, quis iaculis augue pretium at. Quisque non felis porttitor, facilisis nisl eget, tristique nisl. Mauris quam tellus, viverra ac nibh sit amet, vehicula sodales tortor. Ut volutpat tincidunt dolor, sagittis pharetra leo lobortis in. Donec velit est, ornare eget gravida et, fermentum sit amet nibh. Mauris ullamcorper ornare ultricies. Nunc odio est, faucibus eget tincidunt vel, sollicitudin id risus. Donec luctus dolor metus, ac aliquet magna volutpat vitae.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

// Creo un AppBar personalizado de tipo Slivers
class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.black12, // Un color un poco oscuro por si viene una
          // foto en tonos claros, que se vean las letras
          width: double.infinity,
          child: Text('Peli', style: TextStyle(fontSize: 16)),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/images/loading.png'),
          image: NetworkImage('https://placehold.co/500x300.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/loading.png'),
              image: NetworkImage('https://placehold.co/150x250.png'),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'Original title',
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    'movie.Average',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

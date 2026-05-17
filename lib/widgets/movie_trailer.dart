import 'package:flutter/material.dart';
import 'package:presentacion_t5/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MovieTrailer extends StatelessWidget {
  final String movieId;
  const MovieTrailer({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProviders = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProviders.getMovieTrailer(movieId),
      builder: (context, AsyncSnapshot<String?> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final youtubeKey = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Tráiler Oficial',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _YoutubePlayerSafe(youtubeKey: youtubeKey),
          ],
        );
      },
    );
  }
}

class _YoutubePlayerSafe extends StatefulWidget {
  final String youtubeKey;
  const _YoutubePlayerSafe({required this.youtubeKey});

  @override
  State<StatefulWidget> createState() => _YoutubePlayerSafeState();
}

class _YoutubePlayerSafeState extends State<_YoutubePlayerSafe> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.youtubeKey,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: YoutubePlayer(controller: _controller),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: OutlinedButton.icon(
            onPressed: () async {
              final url = Uri.parse(
                'https://www.youtube.com/watch?v=${widget.youtubeKey}',
              );
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
            label: const Text('¿El video no carga? Ver en YouTube'),
            icon: const Icon(Icons.open_in_new, color: Colors.indigo),
          ),
        ),
      ],
    );
  }
}

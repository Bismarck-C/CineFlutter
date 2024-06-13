import 'package:cineapp/provaider/movie_provaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  static const routeName = '/movie-detail';

  const MovieDetailScreen({super.key});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  YoutubePlayerController? _youtubeController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final movieId = ModalRoute.of(context)?.settings.arguments as int?;
    if (movieId != null) {
      Provider.of<MovieProvider>(context, listen: false).fetchMovieDetails(movieId);
    }

    final provider = Provider.of<MovieProvider>(context, listen: false);
    final trailerKey = provider.youtubeTrailerKey;

    if (trailerKey.isNotEmpty) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: trailerKey,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieProvider>(context).selectedMovie;
    final actors = Provider.of<MovieProvider>(context).actors;

    if (movie == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cargando...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(movie['original_title'] ?? 'Sin título', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 231, 145, 17),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (movie['poster_path'] != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('👁️‍🗨️Sinopsis: \n${movie['overview']?? 'Sin descripción'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Género: ${movie['genres']?.map((g) => g['name']).join(', ') ?? 'No disponible'}',
                style: TextStyle(fontSize: 18, color: Colors.white, ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '🔝Popularidad: ${movie['popularity'].toString()}',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text('🎬Trailer: ', style: TextStyle(fontSize: 25, color: Colors.white),),
            if (_youtubeController != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: YoutubePlayer(
                  controller: _youtubeController!,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                ),
              ),
            const SizedBox(height: 20),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '🎭Actores:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: actors.length,
              itemBuilder: (ctx, index) {
                final actor = actors[index];
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (actor['profile_path'] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w200${actor['profile_path']}',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      const SizedBox(height: 5),
                      Text(
                        actor['name'] ?? 'Desconocido',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

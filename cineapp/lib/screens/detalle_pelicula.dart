import 'package:cineapp/screens/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cineapp/provaider/movie_provaider.dart';

class DetallePeliculaScreen extends StatefulWidget {
  static const routeName = '/movie-detail';

  const DetallePeliculaScreen({super.key});

  @override
  DetallePeliculaScreenState createState() => DetallePeliculaScreenState();
}

class DetallePeliculaScreenState extends State<DetallePeliculaScreen> {
  bool _isLoading = true;
  bool _didFetchData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetchData) {
      _loadMovieDetails();
      _didFetchData = true;
    }
  }

  void _loadMovieDetails() {
    final movieId = ModalRoute.of(context)?.settings.arguments as int?;
    if (movieId != null) {
      Provider.of<MovieProvider>(context, listen: false)
          .fetchPeliculaDetalle(movieId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        print('Error al obtener película: $error');
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieProvider>(context).selectedMovie;
    final actors = Provider.of<MovieProvider>(context).actors;
    final trailer = Provider.of<MovieProvider>(context).youtubeTrailerKey;
    var isFavorite = false;
    if(movie.isNotEmpty){
      isFavorite = Provider.of<MovieProvider>(context).isFavorite(movie['id']);
    }
    final iconColor = isFavorite ? Colors.red : Colors.white;
    final icon = isFavorite ? Icons.favorite : Icons.favorite_border;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 86.2,
        centerTitle: true,
        title: Text(
          movie['original_title'] ?? 'Sin título',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(icon, color: iconColor),
            onPressed: () {
              final movieProvider = Provider.of<MovieProvider>(context, listen: false);
              if (isFavorite) {
                movieProvider.removeFavoriteMovie(movie['id']);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Película eliminada de favoritos')),
                );
              } else {
                movieProvider.addFavoriteMovie(movie);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Película añadida a favoritos')),
                );
              }
              setState(() {});
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (movie['poster_path'] != null)
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: Colors.red, size: 50);
                      },
                    ),
                  const SizedBox(height: 30),
                  const Text('👁️‍🗨️ Sinopsis:', style:TextStyle(fontSize:25, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '${movie['overview'] ?? 'Sin descripción'}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('🍿 Genero:', style:TextStyle(fontSize:25, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      '${movie['genres']?.map((g) => g['name']).join(', ') ?? 'No disponible'}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Row(
                      children: [
                        const Text(
                          '⏫ Puntuación:    ',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 73, 212, 45),
                          ),
                          child: Center(
                            child: Text(
                              movie['vote_average'].toStringAsFixed(1),
                              style: const TextStyle(fontSize: 23, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: Text(
                      '🎬 Trailer:',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(child: TrailerPlayer(url: trailer)),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '🎭 Actores:',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
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
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error, color: Colors.red, size: 50);
                                    },
                                  ),
                                ),
                              const SizedBox(height: 5),
                              Text(
                                actor['name'] ?? 'Desconocido',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14),
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

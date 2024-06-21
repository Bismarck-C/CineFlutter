import 'package:cineapp/screens/trailer_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cineapp/provaider/movie_provaider.dart';
import 'package:video_player/video_player.dart';

class DetallePeliculaScreen extends StatefulWidget {
  static const routeName = '/movie-detail';

  const DetallePeliculaScreen({super.key});

  @override
  DetallePeliculaScreenState createState() => DetallePeliculaScreenState();
}

class DetallePeliculaScreenState extends State<DetallePeliculaScreen> {
  bool _isLoading = true; // Estado para controlar la carga inicial
  bool _didFetchData =
      false; // Para evitar múltiples llamadas a fetchMovieDetails

  late VideoPlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetchData) {
      _loadMovieDetails();
      _didFetchData = true; // Asegurarse de que solo se cargue una vez
    }
  }

  // Función para cargar los detalles de la película
  void _loadMovieDetails() {
    final movieId = ModalRoute.of(context)?.settings.arguments as int?;
    if (movieId != null) {
      Provider.of<MovieProvider>(context, listen: false)
          .fetchMovieDetails(movieId)
          .then((_) {
        setState(() {
          _isLoading =
              false; // Cambiar el estado a false cuando los datos estén cargados
        });
      }).catchError((error) {
        print('Error fetching movie details: $error');
        setState(() {
          _isLoading = false; // Cambiar el estado a false si hay un error
        });
      });
    } else {
      setState(() {
        _isLoading =
            false; // Cambiar el estado a false si no se proporciona un movieId
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieProvider>(context).selectedMovie;
    final actors = Provider.of<MovieProvider>(context).actors;
    final trailer = Provider.of<MovieProvider>(context).youtubeTrailerKey;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 86.2,
        centerTitle: true,
        title: Text(
          movie['original_title'] ?? 'Sin título',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: _isLoading // Mostrar el indicador de carga si estamos cargando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (movie['poster_path'] != null)
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error,
                            color: Colors.red, size: 50);
                      },
                    ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '👁️‍🗨️ Sinopsis: \n${movie['overview'] ?? 'Sin descripción'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '🍿 Género: ${movie['genres']?.map((g) => g['name']).join(', ') ?? 'No disponible'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Text(
                          '⏫ Puntuación:    ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[800],
                          ),
                          child: Center(
                            child: Text(
                              movie['vote_average'].toStringAsFixed(1),
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '🎬 Trailer:',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Center(
                    child: TrailerPlayer(url: trailer)
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '🎭 Actores:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                      return const Icon(Icons.error,
                                          color: Colors.red, size: 50);
                                    },
                                  ),
                                ),
                              const SizedBox(height: 5),
                              Text(
                                actor['name'] ?? 'Desconocido',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
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

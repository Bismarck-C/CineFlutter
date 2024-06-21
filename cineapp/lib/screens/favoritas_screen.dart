import 'package:cineapp/navegacion/navegacion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cineapp/provaider/movie_provaider.dart';

class FavoritaScreen extends StatefulWidget {
  static const routeName = '/favoritas';

  const FavoritaScreen({super.key});

  @override
  State<FavoritaScreen> createState() => FavoritaScreenState();
}

class FavoritaScreenState extends State<FavoritaScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = Provider.of<MovieProvider>(context).favoriteMovies;

    return Navegador(
      selectedIndex: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 86.2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Mis Favoritas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )
        ),
        body: favoriteMovies.isEmpty
            ? const Center(
                child: Text(
                  'No tienes películas favoritas.',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: favoriteMovies.length,
                itemBuilder: (ctx, index) {
                  final movie = favoriteMovies[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                        fit: BoxFit.cover,
                        width: 60,
                        height: 90,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                      title: Text(
                        movie['original_title'] ?? 'Sin título',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        movie['overview'] ?? 'Sin descripción',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Provider.of<MovieProvider>(context, listen: false)
                              .removeFavoriteMovie(movie['id']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Película eliminada de favoritos!')),
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/movie-detail',
                          arguments: movie['id'],
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

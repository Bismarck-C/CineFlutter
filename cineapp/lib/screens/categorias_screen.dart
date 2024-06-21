import 'package:carousel_slider/carousel_slider.dart';
import 'package:cineapp/navegacion/navegacion.dart';
import 'package:cineapp/provaider/movie_provaider.dart';
import 'package:cineapp/screens/detalle_pelicula.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaScreen extends StatelessWidget {
  static const routeName = '/categorias';
  const CategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return Navegador(
      selectedIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '📽️ Categorias',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          toolbarHeight: 86.2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildCategoriaSeccion('Populares 🔥', movieProvider.popularMovies),
              buildOtrasCategoriasSection('Mejor calificadas ⭐', movieProvider.topRatedMovies),
              buildOtrasCategoriasSection('En cartelera 🎞️', movieProvider.nowPlayingMovies),
              buildOtrasCategoriasSection("Proximamente 🎦", movieProvider.upComingMovies),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoriaSeccion(String title, List movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 670,
            enlargeCenterPage: true,
            autoPlay: false,
            viewportFraction: 0.8,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: true,
          ),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetallePeliculaScreen.routeName,
                      arguments: movie['id'],
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: SizedBox(
                          height: 550,
                          width: 300,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        movie['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildOtrasCategoriasSection(String title, List movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            enlargeCenterPage: false,
            autoPlay: true,
            viewportFraction: 0.5,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.decelerate,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: true,
          ),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetallePeliculaScreen.routeName,
                      arguments: movie['id'],
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                          fit: BoxFit.cover,
                          height: 280,
                          width: 170,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 100,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

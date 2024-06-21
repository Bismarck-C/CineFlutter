import 'package:carousel_slider/carousel_slider.dart';
import 'package:cineapp/navegacion/navegacion.dart';
import 'package:cineapp/provaider/movie_provaider.dart';
import 'package:cineapp/screens/detalle_pelicula.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importar el CustomLayout

class CategoriaScreen extends StatelessWidget {
  static const routeName = '/categorias';
  const CategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return Navegador( // Utilizando CustomLayout
      selectedIndex: 1, // Ajustar el índice según corresponda
      child: Scaffold(
        appBar: AppBar(
          title: const Text('📽️ Categorias', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              buildCategorySection('Populares 🔥', movieProvider.popularMovies),
              buildOtherCategorySection('Mejor calificadas ⭐', movieProvider.topRatedMovies),
              buildOtherCategorySection('En cartelera 🎞️', movieProvider.nowPlayingMovies),
              buildOtherCategorySection("Proximamente 🎦", movieProvider.upComingMovies)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategorySection(String title, List movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black,),
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 670,
            enlargeCenterPage: true,
            autoPlay: true,
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
                      Text(movie['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
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

  Widget buildOtherCategorySection(String title, List movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize:26, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 460,
            enlargeCenterPage: true,
            autoPlay: true,
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
                        child: Expanded(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                            fit: BoxFit.cover,
                            height: 350,
                            width: 230,
                          ),
                        ),
                      ),
                      Text(movie['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
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

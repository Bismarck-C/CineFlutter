import 'package:cineapp/provaider/movie_provaider.dart';
import 'package:cineapp/screens/detalle_pelicula.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider()..fetchMovies(),
      child: MaterialApp(
        home: HomeScreen(),
        routes: {
          MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('📽️ Categorias', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const  Color.fromARGB(174, 235, 10, 2),
      ),
      backgroundColor: Colors.black54,
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
    );
  }

  Widget buildCategorySection(String title, List movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 640,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      MovieDetailScreen.routeName,
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
                            height: 500,
                            width: 290,
                          ),
                        ),
                      ),
                      Text(movie['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
                      MovieDetailScreen.routeName,
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
                      Text(movie['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
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

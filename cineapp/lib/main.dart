import 'package:cineapp/provaider/movie_provaider.dart';
import 'package:cineapp/screens/categorias_screen.dart';
import 'package:cineapp/screens/detalle_pelicula.dart';
import 'package:cineapp/screens/home_screen.dart';
import 'package:cineapp/screens/sobre_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider()..fetchMovies(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        routes: {
          DetallePeliculaScreen.routeName: (ctx) => const DetallePeliculaScreen(),
          CategoriaScreen.routeName: (cxt) => const CategoriaScreen(),
          SobreScreen.routeName: (ctx) => const SobreScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}

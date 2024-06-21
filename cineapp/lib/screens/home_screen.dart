import 'package:cineapp/navegacion/navegacion.dart';
import 'package:cineapp/screens/categorias_screen.dart';
import 'package:flutter/material.dart';
import 'package:cineapp/screens/sobre_screen.dart';// Importar el CustomLayout

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, CategoriaScreen.routeName);
    } else if (index == 2) {
      Navigator.pushNamed(context, SobreScreen.routeName);
    } else {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navegador(
      selectedIndex: _selectedIndex,
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
            'Cine APP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: const Color.fromARGB(255, 247, 17, 0),
        body: Stack(
          children: <Widget>[
            // Imagen de fondo
            Positioned.fill(
              child: Image.asset(
                'assets/images/fondo.jpg', // Asegúrate de que la ruta sea correcta
                fit: BoxFit.cover,
              ),
            ),
            // Contenido de la pantalla
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, CategoriaScreen.routeName);
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      'Ir a categorías',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}